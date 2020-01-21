cwlVersion: v1.0
class: CommandLineTool
baseCommand: STAR
requirements:
- class: DockerRequirement
  dockerPull: hubentu/rcwl-rnaseq
arguments:
- --outFilterMultimapNmax
- '3'
- --outSAMunmapped
- Within
- --outFilterMismatchNmax
- '2'
- --outSAMstrandField
- intronMotif
- --readFilesCommand
- zcat
- --outSAMtype
- BAM
- Unsorted
- --twopassMode
- Basic
- --quantMode
- GeneCounts
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
      glob: '*.bam'
  outLog:
    type: File
    outputBinding:
      glob: '*Log.final.out'
  outCount:
    type: File
    outputBinding:
      glob: '*ReadsPerGene.out.tab'
