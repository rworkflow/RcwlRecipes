cwlVersion: v1.0
class: Workflow
requirements:
- class: ScatterFeatureRequirement
- class: SubworkflowFeatureRequirement
- class: StepInputExpressionRequirement
inputs:
  in_seqfiles:
    type: File[]
  in_prefix:
    type: string
  in_genomeDir:
    type: Directory
  in_GTFfile:
    type: File
  in_runThreadN:
    type: int
    default: 1
outputs:
  out_fastqc:
    type: File[]
    outputSource: fastqc/QCfile
  out_BAM:
    type: File
    outputSource: samtools_index/idx
  out_Log:
    type: File
    outputSource: STAR/outLog
  out_Count:
    type: File
    outputSource: STAR/outCount
  out_stat:
    type: File
    outputSource: samtools_flagstat/flagstat
  out_count:
    type: File
    outputSource: featureCounts/Count
  QCout:
    type: File[]
    outputSource: rnaseqc/qcOut
  out_tpm:
    type: File[]
    outputSource: tpm/out
  out_ent:
    type: File[]
    outputSource: tpm/ent
  out_uni:
    type: File[]
    outputSource: tpm/uni
steps:
  fastqc:
    run: fastqc.cwl
    in:
      seqfile: in_seqfiles
    out:
    - QCfile
    scatter: seqfile
  STAR:
    run: STAR.cwl
    in:
      prefix: in_prefix
      genomeDir: in_genomeDir
      sjdbGTFfile: in_GTFfile
      readFilesIn: in_seqfiles
      runThreadN: in_runThreadN
    out:
    - outBAM
    - outLog
    - outCount
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
  collapse_annotation:
    run: collapse_annotation.cwl
    in:
      gtf: in_GTFfile
      out:
        valueFrom: collapse_annotation.gtf
    out:
    - gtfout
  rnaseqc:
    run: rnaseqc.cwl
    in:
      gtf: collapse_annotation/gtfout
      bam: sortBam/sbam
    out:
    - qcOut
  tpm:
    run: tpm.cwl
    in:
      bam: samtools_index/idx
      gtf: in_GTFfile
    out:
    - out
    - ent
    - uni
