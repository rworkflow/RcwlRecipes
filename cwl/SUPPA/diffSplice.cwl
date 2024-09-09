cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /opt/SUPPA/suppa.py
- diffSplice
requirements:
- class: DockerRequirement
  dockerPull: hubentu/suppa
inputs:
  method:
    type: string
    inputBinding:
      prefix: -m
      separate: true
  iox:
    type: File
    inputBinding:
      prefix: -i
      separate: true
  psi:
    type: File[]
    inputBinding:
      prefix: -p
      separate: true
  exp:
    type: File[]
    inputBinding:
      prefix: -e
      separate: true
  output:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  gc:
    type: boolean
    inputBinding:
      prefix: -gc
      separate: true
    default: true
  paired:
    type: boolean
    inputBinding:
      prefix: -pa
      separate: true
    default: false
outputs:
  outFile:
    type: File[]
    outputBinding:
      glob: $(inputs.output)*
