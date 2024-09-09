cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- mageck
- test
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/mageck:0.5.9.4--py38hed8969a_0
inputs:
  countTable:
    type: File
    inputBinding:
      prefix: -k
      separate: true
  treat:
    type: string[]?
    inputBinding:
      prefix: -t
      separate: true
      itemSeparator: ','
  control:
    type: string[]?
    inputBinding:
      prefix: -c
      separate: true
      itemSeparator: ','
  prefix:
    type: string
    inputBinding:
      prefix: -n
      separate: true
  conSGRNA:
    type: File?
    inputBinding:
      prefix: --control-sgrna
      separate: true
  day0:
    type: string?
    inputBinding:
      prefix: --day0-label
      separate: true
outputs:
  touts:
    type: File[]
    outputBinding:
      glob: $(inputs.prefix)*
