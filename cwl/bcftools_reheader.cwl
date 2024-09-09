cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bcftools
- reheader
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.13--h3a49de5_0
inputs:
  fai:
    type: File?
    inputBinding:
      prefix: -f
      separate: true
  header:
    type: File?
    inputBinding:
      prefix: -h
      separate: true
  samples:
    type: File?
    inputBinding:
      prefix: -s
      separate: true
  vcf:
    type: File
    inputBinding:
      separate: true
  output:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  outvcf:
    type: File
    outputBinding:
      glob: $(inputs.output)
