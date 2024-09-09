cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /opt/SUPPA/suppa.py
- psiPerEvent
requirements:
- class: DockerRequirement
  dockerPull: hubentu/suppa
inputs:
  ioe:
    type: File
    inputBinding:
      prefix: -i
      separate: true
  exp:
    type: File
    inputBinding:
      prefix: -e
      separate: true
  outfile:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  outFile:
    type: File[]
    outputBinding:
      glob: $(inputs.outfile).psi
