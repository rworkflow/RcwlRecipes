cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- svaba
- run
requirements:
- class: DockerRequirement
  dockerPull: ken01nn/svaba
arguments:
- -a
- somatic_run
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -t
      separate: true
  nbam:
    type: File
    secondaryFiles: .bai
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
  vcf:
    type: File[]
    outputBinding:
      glob: '*.vcf'
