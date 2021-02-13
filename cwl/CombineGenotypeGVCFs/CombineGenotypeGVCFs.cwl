cwlVersion: v1.0
class: Workflow
requirements:
- class: cwlStepInputExpressionRequirement
- class: InlineJavascriptRequirement
inputs:
  vcfs:
    type:
      type: array
      items: File
      inputBinding:
        separate: true
    secondaryFiles: .idx
  Ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
  out:
    type: string
outputs:
  VCF:
    type: File
    secondaryFiles: .idx
    outputSource: GenotypeGVCFs/vcf
steps:
  CombineGVCFs:
    run: CombineGVCFs.cwl
    in:
      vcfs: vcfs
      Ref: Ref
      ovcf:
        source: out
        valueFrom: $(self).g.vcf
    out:
    - vcf
  GenotypeGVCFs:
    run: GenotypeGVCFs.cwl
    in:
      variant: CombineGVCFs/cvcf
      ref: Ref
      vout: out
    out:
    - vcf
