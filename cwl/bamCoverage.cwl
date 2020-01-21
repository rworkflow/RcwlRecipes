cwlVersion: v1.0
class: CommandLineTool
baseCommand: bamCoverage
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/deeptools:3.3.1--py_0
arguments:
- --ignoreDuplicates
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -b
      separate: true
  bw:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  binsize:
    type: int
    inputBinding:
      prefix: -bs
      separate: true
    default: 1
  processors:
    type: int
    inputBinding:
      prefix: -p
      separate: true
    default: 2
outputs:
  bigwig:
    type: File
    outputBinding:
      glob: $(inputs.bw)
