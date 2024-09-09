cwlVersion: v1.0
class: Workflow
inputs:
  bam:
    type: File
    secondaryFiles: .bai
  threads:
    type: int
    default: 4
outputs:
  gout:
    type: File
    outputSource: Genotype/genotype
  pout:
    type: File
    outputSource: Partial/pg
steps:
  Extract:
    run: Extract.cwl
    in:
      bam: bam
      threads: threads
    out:
    - fqs
  Genotype:
    run: Genotype.cwl
    in:
      fqs: Extract/fqs
      threads: threads
    out:
    - genotype
    - align
    - gjs
  Partial:
    run: Partial.cwl
    in:
      fqs: Extract/fqs
      genotype: Genotype/genotype
      threads: threads
    out:
    - pg
    - align
