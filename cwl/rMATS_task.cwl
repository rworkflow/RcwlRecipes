cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- python
- /rmats/rmats.py
requirements:
- class: DockerRequirement
  dockerPull: rmats_darts
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.outdir)
    writable: true
inputs:
  task:
    type: string
    inputBinding:
      prefix: --task
      separate: true
    default: stat
  outdir:
    type: Directory
    inputBinding:
      prefix: --od
      separate: true
  tmp:
    type: string?
    inputBinding:
      prefix: --tmp
      separate: true
    default: tmp
  darts:
    type: boolean?
    inputBinding:
      prefix: --darts-model
      separate: true
  threads:
    type: int
    inputBinding:
      prefix: --nthread
      separate: true
outputs:
  res:
    type: File[]
    outputBinding:
      glob: $(inputs.outdir.basename)/*.txt
