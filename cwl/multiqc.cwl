cwlVersion: v1.0
class: CommandLineTool
baseCommand: multiqc
requirements:
- class: DockerRequirement
  dockerPull: hubentu/rcwl-rnaseq
inputs:
  dir:
    type: Directory
    inputBinding:
      separate: true
outputs:
  qc:
    type: File
    outputBinding:
      glob: '*.html'
  qcDat:
    type: Directory
    outputBinding:
      glob: multiqc_data
