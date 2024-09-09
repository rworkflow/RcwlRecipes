cwlVersion: v1.0
class: Workflow
requirements:
- class: SubworkflowFeatureRequirement
- class: ScatterFeatureRequirement
inputs:
  idBam:
    type: string
  RG:
    type: string[]
  threads:
    type: int
  Ref:
    type: File
    secondaryFiles:
    - .amb
    - .ann
    - .bwt
    - .pac
    - .sa
  FQ1s:
    type: File[]
  FQ2s:
    type: File[]
outputs:
  oBam:
    type: File
    outputSource: mergeBamDup/oBam
  matrix:
    type: File
    outputSource: mergeBamDup/matrix
  Idx:
    type: File
    outputSource: mergeBamDup/Idx
  stat:
    type: File
    outputSource: mergeBamDup/stat
steps:
  bwaAlign:
    run: bwaAlign.cwl
    in:
      threads: threads
      RG: RG
      Ref: Ref
      FQ1: FQ1s
      FQ2: FQ2s
    out:
    - Bam
    - Idx
    scatter:
    - RG
    - FQ1
    - FQ2
    scatterMethod: dotproduct
  mergeBamDup:
    run: mergeBamDup.cwl
    in:
      ibam: bwaAlign/Bam
      obam: idBam
    out:
    - oBam
    - matrix
    - Idx
    - stat
