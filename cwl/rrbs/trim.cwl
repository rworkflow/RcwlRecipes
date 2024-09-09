cwlVersion: v1.0
class: CommandLineTool
baseCommand: trim_galore
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/trim-galore:0.6.7--hdfd78af_0
arguments:
- -o
- ./
inputs:
  fq1:
    type: File
    inputBinding:
      position: 9
      separate: true
  fq2:
    type: File?
    inputBinding:
      position: 10
      separate: true
  a1:
    type: string
    inputBinding:
      prefix: -a
      separate: true
    default: AGATCGGAAGAGC
  a2:
    type: string?
    inputBinding:
      prefix: -a2
      separate: true
    default: AAATCAAAAAAAC
  paired:
    type: boolean
    inputBinding:
      prefix: --paired
      separate: true
    default: true
outputs:
  FQ1:
    type: File
    outputBinding:
      glob: '*_1.fq.gz'
  FQ2:
    type: File
    outputBinding:
      glob: '*_2.fq.gz'
  report:
    type: File[]
    outputBinding:
      glob: '*.txt'
