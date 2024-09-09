cwlVersion: v1.0
class: CommandLineTool
baseCommand: hisat2-build
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/hisat2:v2.0.5-1-deb_cv1
inputs:
  ref:
    type: File
    inputBinding:
      position: 1
      separate: true
  outPrefix:
    type: string
    inputBinding:
      position: 2
      separate: true
outputs:
  idx:
    type: File[]
    outputBinding:
      glob: $(inputs.outPrefix).*
