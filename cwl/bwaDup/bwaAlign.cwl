cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
inputs:
  threads:
    type: int
  RG:
    type: string
  Ref:
    type: File
    secondaryFiles:
    - .amb
    - .ann
    - .bwt
    - .pac
    - .sa
  FQ1:
    type: File
  FQ2:
    type: File?
  outBam:
    type: string
outputs:
  Bam:
    type: File
    outputSource: sortBam/sbam
  Idx:
    type: File
    outputSource: idxBam/idx
steps:
  bwa:
    run: bwa.cwl
    in:
      threads: threads
      RG: RG
      Ref: Ref
      FQ1: FQ1
      FQ2: FQ2
    out:
    - sam
  sam2bam:
    run: sam2bam.cwl
    in:
      bam: bwa/sam
      obam:
        valueFrom: $(inputs.bam.nameroot).bam
    out:
    - oBam
  sortBam:
    run: sortBam.cwl
    in:
      bam: sam2bam/oBam
      obam: outBam
    out:
    - sbam
  idxBam:
    run: idxBam.cwl
    in:
      bam: sortBam/sbam
    out:
    - idx
