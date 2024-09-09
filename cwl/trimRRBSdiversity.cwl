cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /opt/trimRRBSdiversityAdaptCustomers.py
requirements:
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.fq1)
  - $(inputs.fq2)
- class: DockerRequirement
  dockerPull: hubentu/rrbs
inputs:
  fq1:
    type: File
    inputBinding:
      prefix: '-1'
      separate: true
  fq2:
    type: File
    inputBinding:
      prefix: '-2'
      separate: true
outputs:
  FQ1:
    type: File
    outputBinding:
      glob: $(inputs.fq1.nameroot)_*
  FQ2:
    type: File
    outputBinding:
      glob: $(inputs.fq2.nameroot)_*
