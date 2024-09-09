cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /opt/CnaAnnotator.py
requirements:
- class: DockerRequirement
  dockerPull: hubentu/oncokb-annotator
inputs:
  input:
    type: File
    inputBinding:
      prefix: -i
      separate: true
  output:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  clinic:
    type: File?
    inputBinding:
      prefix: -c
      separate: true
  token:
    type: string
    inputBinding:
      prefix: -b
      separate: true
outputs:
  ofile:
    type: File
    outputBinding:
      glob: $(inputs.output)
