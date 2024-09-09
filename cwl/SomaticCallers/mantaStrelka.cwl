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
  exome:
    type: boolean
    default: true
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
    run: manta.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: ref
      callRegions: region
      exome: exome
    out:
    - somaticSV
    - diploidSV
    - candidateSV
    - candidateSmallIndels
  strelka:
    run: strelka.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: ref
      callRegions: region
      indelCandidates: manta/candidateSmallIndels
      exome: exome
    out:
    - snvs
    - indels
