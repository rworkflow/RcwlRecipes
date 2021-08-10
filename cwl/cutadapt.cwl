cwlVersion: v1.0
class: CommandLineTool
baseCommand: cutadapt
requirements:
- class: DockerRequirement
  dockerPull: kfdrc/cutadapt
inputs:
  threadN:
    type: int?
    inputBinding:
      position: 1
      prefix: -j
      separate: true
    default: 1
  adapter:
    type: string
    inputBinding:
      position: 2
      prefix: -b
      separate: true
  out1prefix:
    type: string
    inputBinding:
      position: 3
      prefix: -o
      separate: true
  out2prefix:
    type: string?
    inputBinding:
      position: 4
      prefix: -p
      separate: true
  in1:
    type: File
    inputBinding:
      position: 5
      separate: true
  in2:
    type: File?
    inputBinding:
      position: 6
      separate: true
outputs:
  out1:
    type: File
    outputBinding:
      glob: $(inputs.out1prefix)
  out2:
    type: File?
    outputBinding:
      glob: $(inputs.out2prefix)
