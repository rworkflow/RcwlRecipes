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
    type: File?
    secondaryFiles: .tbi
outputs:
  snvs:
    type: File
    outputSource: strelka/snvs
  indels:
    type: File
    outputSource: strelka/indels
  somaticSV:
    type: File
    outputSource: manta/somaticSV
  diploidSV:
    type: File
    outputSource: manta/diploidSV
steps:
  manta:
    run: cwl/mantaStrelka/manta.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: ref
      callRegions: region
    out:
    - somaticSV
    - diploidSV
    - candidateSV
    - candidateSmallIndels
  strelka:
    run: cwl/mantaStrelka/strelka.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: ref
      callRegions: region
      indelCandidates: manta/candidateSmallIndels
    out:
    - snvs
    - indels
