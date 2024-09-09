cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
- class: InlineJavascriptRequirement
inputs:
  vcfs:
    type:
      type: array
      items: File
    secondaryFiles: .tbi
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
      variant: CombineGVCFs/vcf
      ref: Ref
      vout: out
    out:
    - vcf
