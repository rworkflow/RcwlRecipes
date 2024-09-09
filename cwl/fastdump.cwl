cwlVersion: v1.0
class: CommandLineTool
baseCommand: fastq-dump
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sra-tools:2.11.0--pl5321h314213e_2
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
outputs:
  fqs:
    type: File[]
    outputBinding:
      glob: '*.fastq'
