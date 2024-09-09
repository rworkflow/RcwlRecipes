cwlVersion: v1.0
class: CommandLineTool
baseCommand: STAR
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/star:2.7.9a--h9ee0642_0
arguments:
- --outSAMunmapped
- Within
- --outSAMstrandField
- intronMotif
- --outSAMtype
- BAM
- SortedByCoordinate
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
  outLog:
    type: File
    outputBinding:
      glob: '*Log.final.out'
  outCount:
    type: File
    outputBinding:
      glob: '*ReadsPerGene.out.tab'
