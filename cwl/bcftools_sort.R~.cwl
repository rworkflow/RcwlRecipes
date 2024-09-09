cwlVersion: v1.1
class: CommandLineTool
baseCommand:
- bcftools
- concat
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/bcftools:v1.5_cv3
inputs:
  ovcf:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  vcfs:
    type: File[]
    secondaryFiles:
      pattern: .tbi
      required: false
    inputBinding:
      separate: true
  type:
    type: string?
    inputBinding:
      prefix: -O
      separate: true
  overlap:
    type: boolean?
    inputBinding:
      prefix: -a
      separate: true
outputs:
  Fout:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
