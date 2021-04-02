cwlVersion: v1.0
class: CommandLineTool
baseCommand: /usr/local/bin/glnexus_cli
requirements:
- class: DockerRequirement
  dockerPull: quay.io/mlin/glnexus:v1.3.1
inputs:
  config:
    type: string
    inputBinding:
      prefix: --config
      separate: true
  bed:
    type: File?
    inputBinding:
      prefix: --bed
      separate: true
  gvcfs:
    type: File[]
    inputBinding:
      separate: true
  ovcf:
    type: string
outputs:
  bcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
stdout: $(inputs.ovcf)
