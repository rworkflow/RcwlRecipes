cwlVersion: v1.0
class: CommandLineTool
baseCommand: STAR
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/star:2.7.3a--0
arguments:
- --outSAMunmapped
- Within
- --readFilesCommand
- zcat
- --outSAMtype
- BAM
- SortedByCoordinate
inputs:
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
  whiteList:
    type: File
    inputBinding:
      prefix: --soloCBwhitelist
      separate: true
  soloType:
    type: string
    inputBinding:
      prefix: --soloType
      separate: true
    default: CB_UMI_Simple
  soloUMIlen:
    type: string
    inputBinding:
      prefix: --soloUMIlen
      separate: true
    default: '12'
  runThreadN:
    type: int
    inputBinding:
      prefix: --runThreadN
      separate: true
    default: 1
  sOut:
    type: string
    inputBinding:
      prefix: --soloOutFileNames
      separate: true
    default: Solo_out
outputs:
  outBam:
    type: File
    outputBinding:
      glob: '*.bam'
  outLog:
    type: File[]
    outputBinding:
      glob: '*.out'
  SJ:
    type: File
    outputBinding:
      glob: '*out.tab'
  Solo:
    type: Directory
    outputBinding:
      glob: $(inputs.sOut)Gene
