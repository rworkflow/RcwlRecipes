cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /opt/SUPPA/multipleFieldSelection.py
requirements:
- class: DockerRequirement
  dockerPull: hubentu/suppa
inputs:
  inputFiles:
    type: File[]
    inputBinding:
      prefix: -i
      separate: true
  key:
    type: int
    inputBinding:
      prefix: -k
      separate: true
  field:
    type: int
    inputBinding:
      prefix: -f
      separate: true
  outfile:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  noheader:
    type: boolean?
    inputBinding:
      separate: true
outputs:
  outFile:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
