cwlVersion: v1.2
class: Workflow
requirements:
- class: ScatterFeatureRequirement
- class: StepInputExpressionRequirement
- class: InlineJavascriptRequirement
inputs:
  tbam:
    type: File
    secondaryFiles:
    - .bai?
    - ^.bai?
  nbam:
    type: File
    secondaryFiles:
    - .bai?
    - ^.bai?
  region:
    type: File[]
  dbsnp:
    type: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
  ref:
    type: File
    secondaryFiles: .fai
  vcf:
    type: string
outputs:
  ovcf:
    type: File
    outputSource: normVcf/Fout
steps:
  MuSEchr:
    run: MuSEchr.cwl
    in:
      tbam: tbam
      nbam: nbam
      dbsnp: dbsnp
      vcf: vcf
      ref: ref
      exome:
        valueFrom: $(false)
      genome:
        valueFrom: $(true)
      region: region
    out:
    - outVcf
    scatter: region
    scatterMethod: dotproduct
  mergeVcf:
    run: mergeVcf.cwl
    in:
      ovcf: vcf
      vcfs: MuSEchr/outVcf
    out:
    - Fout
  sortVcf:
    run: sortVcf.cwl
    in:
      ovcf: vcf
      vcf: mergeVcf/Fout
    out:
    - Fout
  normVcf:
    run: normVcf.cwl
    in:
      ovcf: vcf
      vcf: sortVcf/Fout
      dup:
        valueFrom: none
    out:
    - Fout
