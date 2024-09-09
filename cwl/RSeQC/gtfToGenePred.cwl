cwlVersion: v1.0
class: CommandLineTool
baseCommand: gtfToGenePred
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/ucsc-gtftogenepred:377--h0b8a92a_4
arguments:
- -genePredExt
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
