cwlVersion: v1.0
class: Workflow
requirements:
- class: SubworkflowFeatureRequirement
- class: ScatterFeatureRequirement
- class: InlineJavascriptRequirement
inputs:
  outBam:
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
    - .fai
    - $(self.nameroot).dict
  FQ1s:
    type: File[]
  FQ2s:
    type: File[]
outputs:
  matrix:
    type: File
    outputSource: mergeBamDup/matrix
  Idx:
    type: File
    outputSource: mergeBamDup/Idx
  flagstat:
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
      obam: outBam
    out:
    - oBam
    - matrix
    - Idx
    - stat
