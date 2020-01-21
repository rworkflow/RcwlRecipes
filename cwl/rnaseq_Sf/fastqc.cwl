cwlVersion: v1.0
class: CommandLineTool
baseCommand: fastqc
requirements:
- class: DockerRequirement
  dockerPull: hubentu/rcwl-rnaseq
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
