cwlVersion: v1.0
class: Workflow
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
outputs:
  Bam:
    type: File
    outputSource: sortBam/sbam
  Idx:
    type: File
    outputSource: idxBam/idx
steps:
  bwa:
    run: cwl/bwaAlign/bwa.cwl
    in:
      threads: threads
      RG: RG
      Ref: Ref
      FQ1: FQ1
      FQ2: FQ2
    out:
    - sam
  sam2bam:
    run: cwl/bwaAlign/sam2bam.cwl
    in:
      sam: bwa/sam
    out:
    - bam
  sortBam:
    run: cwl/bwaAlign/sortBam.cwl
    in:
      bam: sam2bam/bam
    out:
    - sbam
  idxBam:
    run: cwl/bwaAlign/idxBam.cwl
    in:
      bam: sortBam/sbam
    out:
    - idx
