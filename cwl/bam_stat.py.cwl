cwlVersion: v1.0
class: CommandLineTool
baseCommand: bam_stat.py
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:4.0.0--py38h4a8c8d9_1
inputs:
  bam:
    type: File
    inputBinding:
      prefix: -i
      separate: true
outputs:
  statOut:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).bamStat.txt
stdout: $(inputs.bam.nameroot).bamStat.txt
