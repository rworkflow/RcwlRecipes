cwlVersion: v1.0
class: CommandLineTool
baseCommand: STAR
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/star:2.7.10a--h9ee0642_0
arguments:
- --outSAMtype
- BAM
- SortedByCoordinate
- --soloUMIfiltering
- MultiGeneUMI
- --soloCBmatchWLtype
- 1MM_multi_pseudocounts
inputs:
  readFilesIn_cdna:
    type: File[]
    inputBinding:
      position: 1
      prefix: --readFilesIn
      separate: true
      itemSeparator: ','
  readFilesIn_cb:
    type: File[]
    inputBinding:
      position: 2
      separate: true
      itemSeparator: ','
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
    default: Droplet
  soloUMIlen:
    type: string
    inputBinding:
      prefix: --soloUMIlen
      separate: true
    default: '12'
  soloCellFilter:
    type: string
    inputBinding:
      prefix: --soloCellFilter
      separate: true
  outSAMattributes:
    type: string[]
    inputBinding:
      prefix: outSAMattributes
      separate: true
    default:
    - NH
    - HI
    - nM
    - AS
    - CR
    - UR
    - CB
    - UB
    - GX
    - GN
    - sS
    - sQ
    - sM
  readFilesCommand:
    type: string
    inputBinding:
      prefix: --readFilesCommand
      separate: true
    default: zcat
  runThreadN:
    type: int
    inputBinding:
      prefix: --runThreadN
      separate: true
    default: 1
outputs:
  outAlign:
    type: File
    outputBinding:
      glob: '*.bam'
  outLog:
    type: File[]
    outputBinding:
      glob: Log*
  SJ:
    type: File
    outputBinding:
      glob: SJ.out.tab
  Solo:
    type: Directory
    outputBinding:
      glob: Solo.out
