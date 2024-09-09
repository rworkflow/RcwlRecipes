cwlVersion: v1.0
class: CommandLineTool
baseCommand: fastq-dump
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sra-tools:3.1.0--h9f5acd7_0
- class: InitialWorkDirRequirement
  listing:
  - entryname: .ncbi/user-settings.mkfg
    entry: /LIBS/GUID = '666666'
    writable: false
inputs:
  acc:
    type:
    - string
    - File
    inputBinding:
      position: 99
      separate: true
  split:
    type: boolean
    inputBinding:
      prefix: --split-3
      separate: true
    default: true
  guid:
    type: string?
  gzip:
    type: boolean?
    inputBinding:
      prefix: --gzip
      separate: true
outputs:
  fqs:
    type: File[]
    outputBinding:
      glob: '*'
