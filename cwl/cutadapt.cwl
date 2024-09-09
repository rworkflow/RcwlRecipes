cwlVersion: v1.0
class: CommandLineTool
baseCommand: cutadapt
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/cutadapt:4.2--py310h1425a21_0
inputs:
  threadN:
    type: int?
    inputBinding:
      position: 1
      prefix: -j
      separate: true
    default: 1
  adapter1a:
    type: string?
    inputBinding:
      position: 2
      prefix: -a
      separate: true
  adapter2a:
    type: string?
    inputBinding:
      position: 3
      prefix: -A
      separate: true
  adapter1g:
    type: string?
    inputBinding:
      position: 4
      prefix: -g
      separate: true
  adapter2g:
    type: string?
    inputBinding:
      position: 5
      prefix: -G
      separate: true
  adapter1b:
    type: string?
    inputBinding:
      position: 6
      prefix: -b
      separate: true
  adapter2b:
    type: string?
    inputBinding:
      position: 7
      prefix: -B
      separate: true
  out1prefix:
    type: string
    inputBinding:
      position: 8
      prefix: -o
      separate: true
  out2prefix:
    type: string?
    inputBinding:
      position: 9
      prefix: -p
      separate: true
  in1:
    type: File
    inputBinding:
      position: 99
      separate: true
  in2:
    type: File?
    inputBinding:
      position: 100
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
