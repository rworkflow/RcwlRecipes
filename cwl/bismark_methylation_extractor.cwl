cwlVersion: v1.0
class: CommandLineTool
baseCommand: bismark_methylation_extractor
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bismark:0.23.1--hdfd78af_0
inputs:
  paired:
    type: boolean?
    inputBinding:
      prefix: -p
      separate: true
  single:
    type: boolean?
    inputBinding:
      prefix: -s
      separate: true
  bedGraph:
    type: boolean?
    inputBinding:
      prefix: --bedGraph
      separate: true
    default: true
  gzip:
    type: boolean?
    inputBinding:
      prefix: --gzip
      separate: true
    default: true
  core:
    type: int
    inputBinding:
      prefix: --multicore
      separate: true
    default: 4.0
  bam:
    type: File
    inputBinding:
      position: 10
      separate: true
outputs:
  cov:
    type: File
    outputBinding:
      glob: '*.cov*'
  Bed:
    type: File?
    outputBinding:
      glob: '*.bedGraph*'
  report:
    type: File[]
    outputBinding:
      glob: '*.txt'
