cwlVersion: v1.0
class: Workflow
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
- class: ScatterFeatureRequirement
inputs:
  bam:
    type: File[]
    secondaryFiles: .bai
outputs:
  vcf:
    type: File
    outputSource: lumpy/vcf
steps:
  discord:
    run: discord.cwl
    in:
      bam: bam
      outb:
        valueFrom: $(true)
      exFlag:
        valueFrom: '1294'
      obam:
        valueFrom: $(inputs.bam.nameroot).discord.bam
    out:
    - oBam
    scatter: bam
  sam:
    run: sam.cwl
    in:
      bam: bam
      obam:
        valueFrom: $(inputs.bam.nameroot).sam
    out:
    - oBam
    scatter: bam
  split:
    run: split.cwl
    in:
      sam: sam/oBam
    out:
    - splitReads
    scatter: sam
  sam2bam:
    run: sam2bam.cwl
    in:
      bam: split/splitReads
      outb:
        valueFrom: $(true)
      obam:
        valueFrom: $(inputs.bam.nameroot).bam
    out:
    - oBam
    scatter: bam
  discord_idx:
    run: discord_idx.cwl
    in:
      bam: discord/oBam
    out:
    - idx
    scatter: bam
  split_idx:
    run: split_idx.cwl
    in:
      bam: sam2bam/oBam
    out:
    - idx
    scatter: bam
  lumpy:
    run: lumpy.cwl
    in:
      bam: bam
      split: split_idx/idx
      discord: discord_idx/idx
      vout:
        valueFrom: $(inputs.bam[0].nameroot).vcf
    out:
    - vcf
