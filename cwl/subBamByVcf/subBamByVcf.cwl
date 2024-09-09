cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
- class: InlineJavascriptRequirement
inputs:
  vcf:
    type: File
  bam:
    type: File
    secondaryFiles: .bai
outputs:
  mBam:
    type: File
    outputSource: samtoolsidx/idx
steps:
  vcf2bed:
    run: vcf2bed.cwl
    in:
      vcf: vcf
      out:
        valueFrom: $(inputs.vcf.nameroot).bed
    out:
    - bed
  samtoolsview:
    run: samtoolsview.cwl
    in:
      bam: bam
      bed: vcf2bed/bed
      outb:
        valueFrom: $(true)
      obam:
        valueFrom: $(inputs.bam.nameroot).mini.bam
    out:
    - oBam
  samtoolsidx:
    run: samtoolsidx.cwl
    in:
      bam: samtoolsview/oBam
    out:
    - idx
