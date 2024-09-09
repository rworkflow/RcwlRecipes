cwlVersion: v1.0
class: CommandLineTool
baseCommand: STAR
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/star:2.7.9a--h9ee0642_0
arguments:
- --outSAMattrRGline
- '-'
- --alignIntronMax
- '1000000'
- --alignIntronMin
- '20'
- --alignMatesGapMax
- '1000000'
- --alignSJDBoverhangMin
- '1'
- --alignSJoverhangMin
- '8'
- --alignSoftClipAtReferenceEnds
- 'Yes'
- --chimJunctionOverhangMin
- '15'
- --chimMainSegmentMultNmax
- '1'
- --chimOutType
- Junctions
- WithinBAM
- SoftClip
- --chimSegmentMin
- '15'
- --genomeLoad
- NoSharedMemory
- --limitSjdbInsertNsj
- '1200000'
- --outFilterIntronMotifs
- None
- --outFilterMatchNminOverLread
- '0.33'
- --outFilterMismatchNmax
- '999'
- --outFilterMismatchNoverLmax
- '0.1'
- --outFilterMultimapNmax
- '20'
- --outFilterScoreMinOverLread
- '0.33'
- --outFilterType
- BySJout
- --outSAMattributes
- NH
- HI
- AS
- nM
- NM
- ch
- --outSAMstrandField
- intronMotif
- --outSAMtype
- BAM
- Unsorted
- --outSAMunmapped
- Within
- --quantMode
- GeneCounts
- --readFilesCommand
- zcat
- --twopassMode
- Basic
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
outputs:
  outBAM:
    type: File
    outputBinding:
      glob: '*Aligned.out.bam'
  outLog:
    type: File
    outputBinding:
      glob: '*Log.final.out'
  outCount:
    type: File
    outputBinding:
      glob: '*ReadsPerGene.out.tab'
  junction:
    type: File
    outputBinding:
      glob: '*Chimeric.out.junction'
