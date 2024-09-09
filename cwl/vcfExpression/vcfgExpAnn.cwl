cwlVersion: v1.0
class: CommandLineTool
baseCommand: vcf-expression-annotator
requirements:
- class: DockerRequirement
  dockerPull: griffithlab/vatools:3.1.0
arguments:
- --ignore-transcript-version
inputs:
  ivcf:
    type: File
    inputBinding:
      position: 1
      separate: true
  expression:
    type: File
    inputBinding:
      position: 2
      separate: true
  etype:
    type: string
    inputBinding:
      position: 3
      separate: true
    default: kallisto
  gtype:
    type: string
    inputBinding:
      position: 4
      separate: true
    default: transcript
  idCol:
    type: string?
    inputBinding:
      prefix: -i
      separate: true
  expCol:
    type: string?
    inputBinding:
      prefix: -e
      separate: true
  sample:
    type: string?
    inputBinding:
      prefix: -s
      separate: true
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
