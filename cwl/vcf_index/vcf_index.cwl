cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
inputs:
  vcf:
    type: File
outputs:
  tbi:
    type: File
    outputSource: index/idx
steps:
  bgzip:
    run: bgzip.cwl
    in:
      ifile: vcf
    out:
    - zfile
  index:
    run: index.cwl
    in:
      tfile: bgzip/zfile
      type:
        valueFrom: vcf
    out:
    - idx
