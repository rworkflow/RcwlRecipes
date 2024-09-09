cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /usr/local/bin/spss.py
requirements:
- class: DockerRequirement
  dockerPull: hubentu/sigpro:v2
inputs:
  vcf:
    type: File
    inputBinding:
      position: 1
      separate: true
outputs:
  out:
    type: Directory
    outputBinding:
      glob: results
