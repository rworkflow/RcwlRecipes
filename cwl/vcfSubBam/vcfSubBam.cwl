cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
- class: InlineJavascriptRequirement
inputs:
  vcf:
    type: File
  fai:
    type: File
  win:
    type: int
  bam:
    type: File
outputs:
  outBam:
    type: File
    secondaryFiles: .bai
    outputSource: idxBam/idx
steps:
  vcf2bed:
    run: vcf2bed.cwl
    in:
      vcf: vcf
      fai: fai
      win: win
    out:
    - bed
  subBam:
    run: subBam.cwl
    in:
      bam: bam
      bed: vcf2bed/bed
      outb:
        valueFrom: $(true)
      obam:
        valueFrom: $(inputs.bam.nameroot).sub.bam
    out:
    - oBam
  idxBam:
    run: idxBam.cwl
    in:
      bam: subBam/oBam
    out:
    - idx
