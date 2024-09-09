cwlVersion: v1.0
class: Workflow
inputs:
  samplefq:
    type: string
  fq:
    type: File
  adapt:
    type: string
  ref:
    type: string
  DB:
    type: Directory
outputs:
  out:
    type: Directory
    outputSource: compsra/outdir
steps:
  copy:
    run: copy.cwl
    in:
      file1: fq
      file2: samplefq
    out:
    - cpfile
  compsra:
    run: compsra.cwl
    in:
      fq: copy/cpfile
      adapt: adapt
      ref: ref
      DB: DB
    out:
    - outdir
