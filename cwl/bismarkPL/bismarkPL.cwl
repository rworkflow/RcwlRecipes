cwlVersion: v1.0
class: Workflow
inputs:
  fq1:
    type: File
  fq2:
    type: File
  genome:
    type: Directory
  threads:
    type: int
outputs:
  Align:
    type: File
    outputSource: bismark_align/align
  AReport:
    type: File
    outputSource: bismark_align/report
  DBam:
    type: File
    outputSource: deduplicate/dbam
  mcov:
    type: File
    outputSource: meth/cov
  mbed:
    type: File?
    outputSource: meth/Bed
  mreport:
    type: File[]
    outputSource: meth/report
steps:
  bismark_align:
    run: bismark_align.cwl
    in:
      fq1: fq1
      fq2: fq2
      genome: genome
      threads: threads
    out:
    - align
    - report
  deduplicate:
    run: deduplicate.cwl
    in:
      bam: bismark_align/align
    out:
    - dbam
  meth:
    run: meth.cwl
    in:
      bam: deduplicate/dbam
      core: threads
    out:
    - cov
    - Bed
    - report
