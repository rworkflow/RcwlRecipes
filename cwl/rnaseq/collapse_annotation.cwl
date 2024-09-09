cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /opt/collapse_annotation.py
requirements:
- class: DockerRequirement
  dockerPull: hubentu/collapse_annotation
inputs:
  gtf:
    type: File
    inputBinding:
      position: 1
      separate: true
  out:
    type: string
    inputBinding:
      position: 2
      separate: true
  blacklist:
    type: File?
    inputBinding:
      prefix: --transcript_blacklist
      separate: true
outputs:
  gtfout:
    type: File
    outputBinding:
      glob: $(inputs.out)
