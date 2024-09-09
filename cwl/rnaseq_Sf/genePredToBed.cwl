cwlVersion: v1.0
class: CommandLineTool
baseCommand: genePredToBed
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/ucsc-genepredtobed:377--h0b8a92a_4
inputs:
  genePred:
    type: File
    inputBinding:
      position: 1
      separate: true
  Bed:
    type: string
    inputBinding:
      position: 2
      separate: true
outputs:
  bed:
    type: File
    outputBinding:
      glob: $(inputs.Bed)
