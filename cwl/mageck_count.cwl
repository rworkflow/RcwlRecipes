cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- mageck
- count
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/mageck:0.5.9.4--py38hed8969a_0
inputs:
  library:
    type: File
    inputBinding:
      prefix: -l
      separate: true
  fastq:
    type: File[]
    inputBinding:
      prefix: --fastq
      separate: true
  samples:
    type: string[]?
    inputBinding:
      prefix: --sample-label
      separate: true
      itemSeparator: ','
  prefix:
    type: string
    inputBinding:
      prefix: -n
      separate: true
  conSGRNA:
    type: File?
    inputBinding:
      prefix: --control-sgrna
      separate: true
outputs:
  counts:
    type: File[]
    outputBinding:
      glob: $(inputs.prefix)*
