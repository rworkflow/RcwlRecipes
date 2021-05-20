cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bcftools
- sort
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/bcftools:v1.5_cv3
inputs:
  ovcf:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  vcf:
    type: File
    inputBinding:
      separate: true
  type:
    type: string?
    inputBinding:
      prefix: -O
      separate: true
outputs:
  Fout:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
