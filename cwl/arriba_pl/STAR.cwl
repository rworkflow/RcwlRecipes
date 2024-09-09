cwlVersion: v1.0
class: CommandLineTool
baseCommand: STAR
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/star:2.7.9a--h9ee0642_0
arguments:
- --outFilterMultimapNmax 50
- --peOverlapNbasesMin 10
- --alignSplicedMateMapLminOverLmate 0.5
- --alignSJstitchMismatchNmax 5 -1 5 5
- --chimSegmentMin 10
- --chimOutType WithinBAM HardClip
- --chimJunctionOverhangMin 10
- --chimScoreDropMax 30
- --chimScoreJunctionNonGTAG 0
- --chimScoreSeparation 1
- --chimSegmentReadGapMax 3
- --chimMultimapNmax 50
- --outSAMtype BAM Unsorted
- --outSAMunmapped Within
- '--outBAMcompression 0 '
inputs:
  prefix:
    type: string
    inputBinding:
      prefix: --outFileNamePrefix
      separate: true
  readFilesIn:
    type: File[]
    inputBinding:
      prefix: --readFilesIn
      separate: true
  genomeDir:
    type: Directory
    inputBinding:
      prefix: --genomeDir
      separate: true
  sjdbGTFfile:
    type: File
    inputBinding:
      prefix: --sjdbGTFfile
      separate: true
  runThreadN:
    type: int
    inputBinding:
      prefix: --runThreadN
      separate: true
    default: 1
  readFileCommand:
    type: string
    inputBinding:
      prefix: --readFilesCommand
      separate: true
    default: zcat
outputs:
  outBAM:
    type: File
    outputBinding:
      glob: '*.bam'
