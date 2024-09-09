cwlVersion: v1.0
class: CommandLineTool
baseCommand: fastqc
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0
arguments:
- --outdir
- ./
inputs:
  seqfile:
    type: File
    inputBinding:
      separate: true
outputs:
  QCfile:
    type: File
    outputBinding:
      glob: '*.zip'
