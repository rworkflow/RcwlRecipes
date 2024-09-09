cwlVersion: v1.0
class: CommandLineTool
baseCommand: gistic2
requirements:
- class: DockerRequirement
  dockerPull: hubentu/gistic2
arguments:
- -b
- ./
inputs:
  seg:
    type: File
    inputBinding:
      prefix: -seg
      separate: true
  refgene:
    type: File
    inputBinding:
      prefix: -refgene
      separate: true
  markers:
    type: File?
    inputBinding:
      prefix: -mk
      separate: true
  rx:
    type: int?
    inputBinding:
      prefix: -rx
      separate: true
  genegistic:
    type: int?
    inputBinding:
      prefix: -genegistic
      separate: true
  savegene:
    type: int?
    inputBinding:
      prefix: -savegene
      separate: true
  tamp:
    type: float?
    inputBinding:
      prefix: -ta
      separate: true
  tdel:
    type: float?
    inputBinding:
      prefix: -td
      separate: true
  gcm:
    type: string?
    inputBinding:
      prefix: -gcm
      separate: true
  brlen:
    type: float?
    inputBinding:
      prefix: -brlen
      separate: true
  conf:
    type: float?
    inputBinding:
      prefix: -conf
      separate: true
outputs:
  outs:
    type: File[]
    outputBinding:
      glob: '*'
