cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bcftools
- view
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.13--h3a49de5_0
inputs:
  vcf:
    type: File
    inputBinding:
      separate: true
  filter:
    type: string?
    inputBinding:
      prefix: -f
      separate: true
  fout:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  otype:
    type: string?
    inputBinding:
      prefix: -O
      separate: true
    default: v
  sample:
    type: string?
    inputBinding:
      prefix: -s
      separate: true
  samplefile:
    type: File?
    inputBinding:
      prefix: -S
      separate: true
  genotype:
    type: string?
    inputBinding:
      prefix: -g
      separate: true
  include:
    type: string?
    inputBinding:
      prefix: -i
      separate: true
  exclude:
    type: string?
    inputBinding:
      prefix: -e
      separate: true
outputs:
  Fout:
    type: File
    outputBinding:
      glob: $(inputs.fout)
