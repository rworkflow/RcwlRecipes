cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- norm
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.13--h3a49de5_0
inputs:
  ovcf:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  vcf:
    type: File
    secondaryFiles: .tbi?
    inputBinding:
      separate: true
  type:
    type: string?
    inputBinding:
      prefix: -O
      separate: true
  dup:
    type: string?
    inputBinding:
      prefix: -d
      separate: true
outputs:
  Fout:
    type: File
    secondaryFiles: .tbi?
    outputBinding:
      glob: $(inputs.ovcf)
