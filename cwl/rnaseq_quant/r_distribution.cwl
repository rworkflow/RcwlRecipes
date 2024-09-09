cwlVersion: v1.0
class: CommandLineTool
baseCommand: read_distribution.py
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:4.0.0--py38h4a8c8d9_1
inputs:
  bam:
    type: File
    secondaryFiles: .bai
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
