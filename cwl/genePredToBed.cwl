cwlVersion: v1.0
class: CommandLineTool
baseCommand: genePredToBed
requirements:
- class: DockerRequirement
  dockerPull: hubentu/rcwl-rnaseq
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
