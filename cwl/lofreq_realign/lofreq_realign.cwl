cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
inputs:
  ref:
    type: File
    secondaryFiles: .fai
  bam:
    type: File
    secondaryFiles: .bai
outputs:
  ibam:
    type: File
    secondaryFiles: .bai
    outputSource: bamIdx/idx
steps:
  realign:
    run: realign.cwl
    in:
      ref: ref
      bam: bam
      vbam:
        valueFrom: $(inputs.bam.nameroot)_v.bam
    out:
    - obam
  sortBam:
    run: sortBam.cwl
    in:
      bam: realign/obam
      obam:
        valueFrom: $(inputs.bam.nameroot)_sort.bam
    out:
    - sbam
  indelq:
    run: indelq.cwl
    in:
      ref: ref
      bam: sortBam/sbam
      ibam:
        valueFrom: $(inputs.bam.nameroot)_i.bam
    out:
    - obam
  bamIdx:
    run: bamIdx.cwl
    in:
      bam: indelq/obam
    out:
    - idx
