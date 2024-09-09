cwlVersion: v1.0
class: Workflow
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
inputs:
  fq1:
    type: File
  fq2:
    type: File?
  fq3:
    type: File
  sample:
    type: string
  genome:
    type: Directory
  threads:
    type: int
outputs:
  mbam:
    type: File
    outputSource: nudup/mbam
  nbam:
    type: File
    outputSource: resort/sbam
  cov:
    type: File
    outputSource: extractor/cov
  Bed:
    type: File?
    outputSource: extractor/Bed
  report:
    type: File[]
    outputSource: extractor/report
steps:
  trim:
    run: trim.cwl
    in:
      fq1: fq1
      fq2: fq2
    out:
    - FQ1
    - FQ2
    - report
  trimDiversity:
    run: trimDiversity.cwl
    in:
      fq1: trim/FQ1
      fq2: trim/FQ2
    out:
    - FQ1
    - FQ2
  bismark:
    run: bismark.cwl
    in:
      genome: genome
      fq1: trimDiversity/FQ1
      fq2: trimDiversity/FQ2
      sam:
        valueFrom: $(true)
    out:
    - align
    - report
  stripSam:
    run: stripSam.cwl
    in:
      sam: bismark/align
    out:
    - strip
  nudup:
    run: nudup.cwl
    in:
      index: fq3
      paired:
        valueFrom: $(true)
      out: sample
      sam: stripSam/strip
    out:
    - mbam
    - dbam
    - report
  resort:
    run: resort.cwl
    in:
      bam: nudup/dbam
      obam:
        valueFrom: $(inputs.bam.nameroot)_nsort.bam
    out:
    - sbam
  extractor:
    run: extractor.cwl
    in:
      paired:
        valueFrom: $(true)
      core: threads
      bam: resort/sbam
    out:
    - cov
    - Bed
    - report
