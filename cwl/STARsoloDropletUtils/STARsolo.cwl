cwlVersion: v1.0
class: CommandLineTool
baseCommand: STAR
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/star:2.7.5a--0
arguments:
- --readFilesCommand
- zcat
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
outputs:
  outAlign:
    type: File
    outputBinding:
      glob: '*.sam'
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
