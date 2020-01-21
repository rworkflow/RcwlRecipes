cwlVersion: v1.0
class: CommandLineTool
baseCommand: read_distribution.py
requirements:
- class: DockerRequirement
  dockerPull: hubentu/rcwl-rnaseq
inputs:
  bam:
    type: File
    inputBinding:
      prefix: -i
      separate: true
  bed:
    type: File
    inputBinding:
      prefix: -r
      separate: true
outputs:
  distOut:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).distribution.txt
stdout: $(inputs.bam.nameroot).distribution.txt
