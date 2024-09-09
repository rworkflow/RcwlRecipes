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
  indelq:
    run: indelq.cwl
    in:
      ref: ref
      bam: bam
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
