cwlVersion: v1.0
class: CommandLineTool
baseCommand: bamCoverage
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/deeptools:3.4.3--py_0
arguments:
- --ignoreDuplicates
- --skipNonCoveredRegions
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -b
      separate: true
  outFile:
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
    type: string
    inputBinding:
      prefix: -p
      separate: true
    default: max
  outFormat:
    type: string
    inputBinding:
      prefix: --outFileFormat
      separate: true
    default: bigwig
outputs:
  bigwig:
    type: File
    outputBinding:
      glob: $(inputs.bw)
