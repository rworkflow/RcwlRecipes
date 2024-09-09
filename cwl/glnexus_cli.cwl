cwlVersion: v1.0
class: CommandLineTool
baseCommand: glnexus_cli
requirements:
- class: DockerRequirement
  dockerPull: ghcr.io/dnanexus-rnd/glnexus:v1.4.1
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
  threads:
    type: int
    inputBinding:
      prefix: -t
      separate: true
outputs:
  bcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
stdout: $(inputs.ovcf)
