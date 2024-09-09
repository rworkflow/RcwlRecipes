cwlVersion: v1.0
class: CommandLineTool
baseCommand: bigWigToWig
requirements:
- class: DockerRequirement
  dockerPull: biowardrobe2/ucscuserapps:v358_2
inputs:
  bw:
    type: File
    inputBinding:
      position: 1
      separate: true
  wig:
    type: string
    inputBinding:
      position: 2
      separate: true
outputs:
  wigOut:
    type: File
    outputBinding:
      glob: $(inputs.wig)
