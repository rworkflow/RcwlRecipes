cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- seqtk
- sample
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/seqtk:1.4--he4a0461_1
inputs:
  seq:
    type: File
    inputBinding:
      position: 1
      separate: true
  frac:
    type: float?
    inputBinding:
      position: 2
      separate: true
  num:
    type: int?
    inputBinding:
      position: 2
      separate: true
  seed:
    type: int?
    inputBinding:
      prefix: -s
      separate: true
  pass:
    type: boolean?
    inputBinding:
      prefix: '-2'
      separate: true
outputs:
  fq:
    type: File
    outputBinding:
      glob: $(inputs.seq.nameroot)_s.fq
stdout: $(inputs.seq.nameroot)_s.fq
