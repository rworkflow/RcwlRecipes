cwlVersion: v1.0
class: Workflow
inputs:
  normal:
    type: File
    secondaryFiles: .bai
  tumor:
    type: File
    secondaryFiles: .bai
  ref:
    type: File
    secondaryFiles: .fai
  gc:
    type: File
  out:
    type: string
  window:
    type: int
    default: 50
  build:
    type: string
    default: grch37
outputs:
  segs:
    type: File
    outputSource: seqz_binning/seqzs
  score:
    type: File
    outputSource: hrd/HRD
steps:
  bam2seqz:
    run: bam2seqz.cwl
    in:
      normal: normal
      tumor: tumor
      ref: ref
      gc: gc
      out: out
    out:
    - seqz
  seqz_binning:
    run: seqz_binning.cwl
    in:
      seqz: bam2seqz/seqz
      window: window
      out: out
    out:
    - seqzs
  hrd:
    run: hrd.cwl
    in:
      seg: seqz_binning/seqzs
      reference: build
    out:
    - HRD
