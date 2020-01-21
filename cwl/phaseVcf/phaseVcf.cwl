cwlVersion: v1.0
class: Workflow
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
- class: MultipleInputFeatureRequirement
inputs:
  gvariant:
    type: File
    secondaryFiles: .tbi
  svariant:
    type: File
    secondaryFiles: .tbi
  ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
  bam:
    type: File
    secondaryFiles: .bai
  outvcf:
    type: string
  nsample:
    type: string
  tsample:
    type: string
outputs:
  pvcf:
    type: File
    outputSource: tabixIndex/idx
steps:
  splitSample:
    run: cwl/phaseVcf/splitSample.cwl
    in:
      vcf: gvariant
      sample: nsample
      fout:
        valueFrom: $(inputs.sample)_germline.vcf
      genotype:
        valueFrom: ^miss
      exclude:
        valueFrom: GT='0/0'
    out:
    - Fout
  renameGVcf:
    run: cwl/phaseVcf/renameGVcf.cwl
    in:
      vcf: splitSample/Fout
      ovcf:
        valueFrom: $(inputs.vcf.nameroot)_g.vcf
      NewName: tsample
    out:
    - oVcf
  renameSVcf:
    run: cwl/phaseVcf/renameSVcf.cwl
    in:
      vcf: svariant
      ovcf:
        valueFrom: $(inputs.vcf.nameroot)_s.vcf
      NewName: tsample
    out:
    - oVcf
  combineVariants:
    run: cwl/phaseVcf/combineVariants.cwl
    in:
      variants:
      - renameGVcf/oVcf
      - renameSVcf/oVcf
      ref: ref
      ovcf:
        valueFrom: combined_somatic_germline.vcf
    out:
    - oVcf
  sortVcf:
    run: cwl/phaseVcf/sortVcf.cwl
    in:
      vcf: combineVariants/oVcf
      ovcf:
        valueFrom: $(inputs.vcf.nameroot)_sorted.vcf
    out:
    - oVcf
  ReadBackedPhasing:
    run: cwl/phaseVcf/ReadBackedPhasing.cwl
    in:
      vcf: sortVcf/oVcf
      bam: bam
      ref: ref
      region: sortVcf/oVcf
      ovcf: outvcf
    out:
    - oVcf
  bgzip:
    run: cwl/phaseVcf/bgzip.cwl
    in:
      ifile: ReadBackedPhasing/oVcf
    out:
    - zfile
  tabixIndex:
    run: cwl/phaseVcf/tabixIndex.cwl
    in:
      tfile: bgzip/zfile
      type:
        valueFrom: vcf
    out:
    - idx
