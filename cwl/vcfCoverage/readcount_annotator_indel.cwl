cwlVersion: v1.0
class: CommandLineTool
baseCommand: vcf-readcount-annotator
requirements:
- class: DockerRequirement
  dockerPull: griffithlab/vatools:3.1.0
inputs:
  ivcf:
    type: File
    inputBinding:
      position: 1
      separate: true
  readcount:
    type: File
    inputBinding:
      position: 2
      separate: true
  ntype:
    type: string
    inputBinding:
      position: 3
      separate: true
    default: DNA
  sample:
    type: string?
    inputBinding:
      prefix: -s
      separate: true
  vtype:
    type: string
    inputBinding:
      prefix: -t
      separate: true
    default: snv
  ovcf:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  oVcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
