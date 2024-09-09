cwlVersion: v1.0
class: CommandLineTool
baseCommand: bowtie-build
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/bowtie:v1.2.2dfsg-4-deb_cv1
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
