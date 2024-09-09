cwlVersion: v1.0
class: CommandLineTool
baseCommand: mosdepth
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/mosdepth:0.3.3--h37c5b7d_2
arguments:
- -x
inputs:
  bedfile:
    type: File
    inputBinding:
      prefix: --by
      separate: true
  ct:
    type: string
    inputBinding:
      prefix: --thresholds
      separate: true
  fileID:
    type: string
    inputBinding:
      position: 1
      separate: true
  bamfile:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 2
      separate: true
outputs:
  out:
    type: File[]
    outputBinding:
      glob: $(inputs.fileID)*
