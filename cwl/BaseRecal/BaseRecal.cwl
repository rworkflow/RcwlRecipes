cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
- class: InlineJavascriptRequirement
- class: InlineJavascriptRequirement
inputs:
  bam:
    type: File
  ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
  knowSites:
    type:
      type: array
      items: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
  oBam:
    type: string
outputs:
  rcBam:
    type: File
    secondaryFiles: .bai
    outputSource: samtools_index/idx
  flagstat:
    type: File
    outputSource: samtools_flagstat/flagstat
  stats:
    type: File
    outputSource: samtools_stats/stats
steps:
  BaseRecalibrator:
    run: BaseRecalibrator.cwl
    in:
      bam: bam
      ref: ref
      knowSites: knowSites
      recal:
        valueFrom: $(inputs.bam.nameroot).recal.txt
    out:
    - rtable
  ApplyBQSR:
    run: ApplyBQSR.cwl
    in:
      bam: bam
      ref: ref
      rtable: BaseRecalibrator/rtable
      oBam: oBam
    out:
    - Bam
  samtools_index:
    run: samtools_index.cwl
    in:
      bam: ApplyBQSR/Bam
    out:
    - idx
  samtools_flagstat:
    run: samtools_flagstat.cwl
    in:
      bam: ApplyBQSR/Bam
    out:
    - flagstat
  samtools_stats:
    run: samtools_stats.cwl
    in:
      bam: ApplyBQSR/Bam
    out:
    - stats
