cwlVersion: v1.0
class: CommandLineTool
baseCommand: bowtie2-build
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/bowtie2:v2.2.9_cv2
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
