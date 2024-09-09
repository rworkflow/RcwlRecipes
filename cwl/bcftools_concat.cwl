cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- concat
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.13--h3a49de5_0
inputs:
  ovcf:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  vcfs:
    type: File[]?
    secondaryFiles: tbi?
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
  vfile:
    type: File?
    inputBinding:
      prefix: -f
      separate: true
outputs:
  Fout:
    type: File
    secondaryFiles: .tbi?
    outputBinding:
      glob: $(inputs.ovcf)
