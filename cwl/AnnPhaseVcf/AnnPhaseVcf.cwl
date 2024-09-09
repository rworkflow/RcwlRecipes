cwlVersion: v1.0
class: Workflow
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement
hints:
  cwltool:LoadListingRequirement:
    loadListing: no_listing
inputs:
  svcf:
    type: File
  gvcf:
    type: File
    secondaryFiles: .tbi
  ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
  VepDir:
    type: Directory
  tbam:
    type: File
    secondaryFiles: .bai
  rbam:
    type: File
    secondaryFiles: .bai
  tsample:
    type: string
  nsample:
    type: string
  rnaseqs:
    type: File[]
  kallistoIdx:
    type: File
  threads:
    type: int
    default: 16
outputs:
  annVcf:
    type: File
    outputSource: VCFexpression/ExpVcf
  phasedVCF:
    type: File
    outputSource: PhaseVcf/pvcf
$namespaces:
  cwltool: http://commonwl.org/cwltool#
steps:
  VCFvep:
    run: VCFvep.cwl
    in:
      ivcf: svcf
      ref: ref
      cacheDir: VepDir
      ovcf:
        valueFrom: $(inputs.ivcf.nameroot)_vep.vcf
    out:
    - oVcf
  dVCFcoverage:
    run: dVCFcoverage.cwl
    in:
      vcf: VCFvep/oVcf
      bam: tbam
      sample:
        valueFrom: SAMPLE
      ref: ref
    out:
    - outvcf
  rVCFcoverage:
    run: rVCFcoverage.cwl
    in:
      vcf: dVCFcoverage/outvcf
      bam: rbam
      sample:
        valueFrom: SAMPLE
      ntype:
        valueFrom: RNA
      ref: ref
    out:
    - outvcf
  VCFexpression:
    run: VCFexpression.cwl
    in:
      rnafqs: rnaseqs
      kallistoIdx: kallistoIdx
      svcf: rVCFcoverage/outvcf
      threads: threads
    out:
    - ExpVcf
  PhaseVcf:
    run: PhaseVcf.cwl
    in:
      gvariant: gvcf
      svariant: VCFexpression/ExpVcf
      bam: tbam
      outvcf:
        valueFrom: $(inputs.tsample)_phased.vcf
      nsample: nsample
      tsample: tsample
      ref: ref
    out:
    - pvcf
