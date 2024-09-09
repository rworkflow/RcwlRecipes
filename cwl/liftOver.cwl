cwlVersion: v1.0
class: CommandLineTool
baseCommand: liftOver
requirements:
- class: DockerRequirement
  dockerPull: biowardrobe2/ucscuserapps:v358_2
inputs:
  oldFile:
    type: File
    inputBinding:
      position: 1
      separate: true
  chain:
    type: File
    inputBinding:
      position: 2
      separate: true
  newFile:
    type: string
    inputBinding:
      position: 3
      separate: true
  unmap:
    type: string
    inputBinding:
      position: 4
      separate: true
outputs:
  outFile:
    type: File
    outputBinding:
      glob: $(inputs.newFile)
  unMap:
    type: File
    outputBinding:
      glob: $(inputs.unmap)
