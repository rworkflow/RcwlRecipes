cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- picard
- CollectInsertSizeMetrics
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/picard:2.21.1--0
inputs:
  bam:
    type: File
    inputBinding:
      prefix: I=
      separate: false
  metrics:
    type: string
    inputBinding:
      prefix: O=
      separate: false
  hist:
    type: string
    inputBinding:
      prefix: H=
      separate: false
outputs:
  Metrics:
    type: File
    outputBinding:
      glob: $(inputs.metrics)
  Hist:
    type: File
    outputBinding:
      glob: $(inputs.hist)
