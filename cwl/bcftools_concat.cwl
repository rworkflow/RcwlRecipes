cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bcftools
- concat
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/bcftools:v1.5_cv3
arguments:
- -a
inputs:
  ovcf:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  vcfs:
    type: File[]
    secondaryFiles: .tbi
    inputBinding:
      separate: true
outputs:
  Fout:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
