cwlVersion: v1.0
class: Workflow
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
  nbam:
    type: File
    secondaryFiles: .bai
  ref:
    type: File
    secondaryFiles: .fai
  region:
    type: File
  ensemble:
    type: File
  threads:
    type: int
    default: 2
  ovcf:
    type: string
outputs:
  outVcf:
    type: File
    outputSource: postprocess/oVcf
steps:
  preprocess:
    run: preprocess.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: ref
      ensemble: ensemble
      region: region
      threads: threads
    out:
    - candidates
    - fcandidates
  call:
    run: call.cwl
    in:
      candidates: preprocess/candidates
      ref: ref
    out:
    - pred
  postprocess:
    run: postprocess.cwl
    in:
      ref: ref
      tbam: tbam
      pred: call/pred
      fcandidates: preprocess/fcandidates
      ensemble: ensemble
      ovcf: ovcf
    out:
    - oVcf
