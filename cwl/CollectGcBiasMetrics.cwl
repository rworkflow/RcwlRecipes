cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- picard
- CollectGcBiasMetrics
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/picard:2.26.4--hdfd78af_0
inputs:
  bam:
    type: File
    inputBinding:
      prefix: I=
      separate: false
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: R=
      separate: false
  gc:
    type: string
    inputBinding:
      prefix: O=
      separate: false
  chart:
    type: string
    inputBinding:
      prefix: CHART=
      separate: false
  summary:
    type: string
    inputBinding:
      prefix: S=
      separate: false
outputs:
  GC:
    type: File
    outputBinding:
      glob: $(inputs.gc)
  Chart:
    type: File
    outputBinding:
      glob: $(inputs.chart)
  Summary:
    type: File
    outputBinding:
      glob: $(inputs.summary)
