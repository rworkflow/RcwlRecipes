cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bedtools
- genomecov
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bedtools:2.29.2--hc088bd4_0
inputs:
  bam:
    type: File
    inputBinding:
      prefix: -ibam
      separate: true
  bedgraph:
    type: boolean
    inputBinding:
      prefix: -bg
      separate: true
    default: true
outputs:
  bed:
    type: File
    outputBinding:
      glob: '*.bedgraph'
stdout: $(inputs.bam.nameroot).bedgraph
