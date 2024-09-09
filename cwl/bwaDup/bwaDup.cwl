cwlVersion: v1.2
class: Workflow
requirements:
- class: SubworkflowFeatureRequirement
- class: ScatterFeatureRequirement
- class: InlineJavascriptRequirement
- class: MultipleInputFeatureRequirement
- class: StepInputExpressionRequirement
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
  FQ1s:
    type: File[]
  FQ2s:
    type: File[]?
outputs:
  BAM:
    type: File
    outputSource: samtools_index/idx
  matrix:
    type: File
    outputSource: markdup/Mat
  flagstat:
    type: File
    outputSource: samtools_flagstat/flagstat
  stats:
    type: File
    outputSource: samtools_stats/stats
  md5s:
    type: File
    outputSource: md5sum/md5
steps:
  bwaAlign:
    run: bwaAlign.cwl
    in:
      threads: threads
      RG: RG
      Ref: Ref
      FQ1: FQ1s
      FQ2: FQ2s
      outBam: outBam
    out:
    - Bam
    - Idx
    scatter:
    - RG
    - FQ1
    - FQ2
    scatterMethod: dotproduct
  mergeBam:
    run: mergeBam.cwl
    in:
      ibam: bwaAlign/Bam
      obam:
        source:
        - outBam
        valueFrom: $(self).merge.bam
    out:
    - oBam
    when: $(inputs.ibam.length>1)
  markdup:
    run: markdup.cwl
    in:
      ibam:
        source:
        - mergeBam/oBam
        - bwaAlign/Bam
        linkMerge: merge_flattened
        pickValue: first_non_null
        valueFrom: $(self)
      obam: outBam
      matrix:
        source:
        - outBam
        valueFrom: $(self).markdup.txt
    out:
    - mBam
    - Mat
  samtools_index:
    run: samtools_index.cwl
    in:
      bam:
        source:
        - markdup/mBam
        - mergeBam/oBam
        - bwaAlign/Bam
        linkMerge: merge_flattened
        pickValue: first_non_null
        valueFrom: $(self)
    out:
    - idx
  samtools_flagstat:
    run: samtools_flagstat.cwl
    in:
      bam: samtools_index/idx
    out:
    - flagstat
  samtools_stats:
    run: samtools_stats.cwl
    in:
      bam: samtools_index/idx
    out:
    - stats
  md5sum:
    run: md5sum.cwl
    in:
      file: samtools_index/idx
    out:
    - md5
