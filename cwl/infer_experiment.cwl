cwlVersion: v1.0
class: CommandLineTool
baseCommand: infer_experiment.py
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/rseqc:4.0.0--py38h4a8c8d9_1
inputs:
  bed:
    type: File
    inputBinding:
      prefix: -r
      separate: true
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -i
      separate: true
  size:
    type: int?
    inputBinding:
      prefix: -s
      separate: true
outputs:
  sout:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).strand.txt
stdout: $(inputs.bam.nameroot).strand.txt
