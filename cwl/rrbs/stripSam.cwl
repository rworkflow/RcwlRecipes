cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bash
- /opt/strip_bismark_sam.sh
requirements:
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.sam)
- class: DockerRequirement
  dockerPull: hubentu/rrbs
inputs:
  sam:
    type: File
    inputBinding:
      separate: true
outputs:
  strip:
    type: File
    outputBinding:
      glob: '*_stripped.sam'
