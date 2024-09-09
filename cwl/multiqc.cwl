cwlVersion: v1.0
class: CommandLineTool
baseCommand: multiqc
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/multiqc:1.11--pyhdfd78af_0
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
