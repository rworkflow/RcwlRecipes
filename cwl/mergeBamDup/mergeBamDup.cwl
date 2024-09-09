cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
- class: InlineJavascriptRequirement
inputs:
  ibam:
    type: File[]
  obam:
    type: string
outputs:
  oBam:
    type: File
    outputSource: markdup/mBam
  matrix:
    type: File
    outputSource: markdup/Mat
  Idx:
    type: File
    outputSource: samtools_index/idx
  stat:
    type: File
    outputSource: samtools_flagstat/flagstat
steps:
  mergeBam:
    run: mergeBam.cwl
    in:
      ibam: ibam
      obam: obam
    out:
    - oBam
  markdup:
    run: markdup.cwl
    in:
      ibam: mergeBam/oBam
      obam: obam
      matrix:
        valueFrom: $(inputs.ibam.nameroot).markdup.txt
    out:
    - mBam
    - Mat
  samtools_index:
    run: samtools_index.cwl
    in:
      bam: markdup/mBam
    out:
    - idx
  samtools_flagstat:
    run: samtools_flagstat.cwl
    in:
      bam: markdup/mBam
    out:
    - flagstat
