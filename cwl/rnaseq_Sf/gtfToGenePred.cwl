cwlVersion: v1.0
class: CommandLineTool
baseCommand: gtfToGenePred
requirements:
- class: DockerRequirement
  dockerPull: hubentu/rcwl-rnaseq
inputs:
  gtf:
    type: File
    inputBinding:
      position: 1
      separate: true
  gPred:
    type: string
    inputBinding:
      position: 2
      separate: true
outputs:
  genePred:
    type: File
    outputBinding:
      glob: $(inputs.gPred)
