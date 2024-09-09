cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- svaba
- run
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/svaba:1.1.0--h7d7f7ad_2
- class: InlineJavascriptRequirement
inputs:
  tbam:
    type: File
    secondaryFiles:
    - .bai?
    - ^.bai?
    inputBinding:
      prefix: -t
      separate: true
  nbam:
    type: File
    secondaryFiles:
    - .bai?
    - ^.bai?
    inputBinding:
      prefix: -n
      separate: true
  target:
    type: File?
    inputBinding:
      prefix: -k
      separate: true
  dbsnp:
    type: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
    inputBinding:
      prefix: -D
      separate: true
  ref:
    type: File
    secondaryFiles:
    - .amb
    - .ann
    - .bwt
    - .pac
    - .sa
    - .fai
    inputBinding:
      prefix: -G
      separate: true
  cores:
    type: int
    inputBinding:
      prefix: -p
      separate: true
    default: 4
  prefix:
    type: string
    inputBinding:
      prefix: -a
      separate: true
outputs:
  raw:
    type: File
    outputBinding:
      glob: '*.bps.txt.gz'
  contig:
    type: File
    outputBinding:
      glob: '*.contigs.bam'
  discordants:
    type: File
    outputBinding:
      glob: '*.discordant.txt.gz'
  log:
    type: File
    outputBinding:
      glob: '*.log'
  align:
    type: File
    outputBinding:
      glob: '*.alignments.txt.gz'
  uvcf:
    type: File[]
    outputBinding:
      glob: '*unfiltered.*'
  svcf:
    type: File[]
    outputBinding:
      glob: '*svaba.somatic*'
  gvcf:
    type: File[]
    outputBinding:
      glob: '*svaba.germline*'
