cwlVersion: v1.0
class: Workflow
requirements:
- class: MultipleInputFeatureRequirement
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
inputs:
  in_fq1:
    type: File
  in_fq2:
    type: File
  in_prefix:
    type: string
  in_genomeDir:
    type: Directory
  in_GTFfile:
    type: File
  in_runThreadN:
    type: int
    default: 1
  salmon_index:
    type: Directory
outputs:
  out_BAM:
    type: File
    outputSource: samtools_index/idx
  out_Log:
    type: File
    outputSource: STAR/outLog
  out_junction:
    type: File
    outputSource: STAR/junction
  out_stat:
    type: File
    outputSource: samtools_flagstat/flagstat
  out_count:
    type: File
    outputSource: featureCounts/Count
  out_salmon:
    type: Directory
    outputSource: salmon/out1
  out_rdist:
    type: File
    outputSource: r_distribution/distOut
steps:
  STAR:
    run: STAR.cwl
    in:
      prefix:
        source: in_prefix
        valueFrom: $(self)_
      genomeDir: in_genomeDir
      sjdbGTFfile: in_GTFfile
      readFilesIn:
        source:
        - in_fq1
        - in_fq2
        linkMerge: merge_flattened
      runThreadN: in_runThreadN
    out:
    - outBAM
    - outLog
    - outCount
    - junction
  sortBam:
    run: sortBam.cwl
    in:
      bam: STAR/outBAM
    out:
    - sbam
  samtools_index:
    run: samtools_index.cwl
    in:
      bam: sortBam/sbam
    out:
    - idx
  samtools_flagstat:
    run: samtools_flagstat.cwl
    in:
      bam: sortBam/sbam
    out:
    - flagstat
  featureCounts:
    run: featureCounts.cwl
    in:
      gtf: in_GTFfile
      bam: samtools_index/idx
      count:
        valueFrom: $(inputs.bam.nameroot).featureCounts.txt
    out:
    - Count
  gtfToGenePred:
    run: gtfToGenePred.cwl
    in:
      gtf: in_GTFfile
      gPred:
        valueFrom: $(inputs.gtf.nameroot).genePred
    out:
    - genePred
  genePredToBed:
    run: genePredToBed.cwl
    in:
      genePred: gtfToGenePred/genePred
      Bed:
        valueFrom: $(inputs.genePred.nameroot).bed
    out:
    - bed
  r_distribution:
    run: r_distribution.cwl
    in:
      bam: samtools_index/idx
      bed: genePredToBed/bed
    out:
    - distOut
  salmon:
    run: salmon.cwl
    in:
      threadN: in_runThreadN
      ref: salmon_index
      fq1: in_fq1
      fq2: in_fq2
      outPrefix:
        source: in_prefix
        valueFrom: $(self)_salmon
    out:
    - out1
