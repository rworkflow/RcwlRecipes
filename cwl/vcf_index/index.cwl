cwlVersion: v1.0
class: CommandLineTool
baseCommand: tabix
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/tabix:v1.3.2-2-deb_cv1
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.tfile)
inputs:
  tfile:
    type: File
    inputBinding:
      position: 1
      separate: true
  type:
    type: string
    inputBinding:
      prefix: -p
      separate: true
    default: vcf
outputs:
  idx:
    type: File
    secondaryFiles:
    - .tbi
    outputBinding:
      glob: $(inputs.tfile.basename)
