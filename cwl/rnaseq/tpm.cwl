cwlVersion: v1.0
class: CommandLineTool
baseCommand: TPMCalculator
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/tpmcalculator:0.0.4--hf393df8_3
inputs:
  bam:
    type: File
    inputBinding:
      prefix: -b
      separate: true
  gtf:
    type: File
    inputBinding:
      prefix: -g
      separate: true
  paired:
    type: boolean?
    inputBinding:
      prefix: -p
      separate: true
    default: true
  all:
    type: boolean?
    inputBinding:
      prefix: -a
      separate: true
    default: true
outputs:
  out:
    type: File[]
    outputBinding:
      glob: '*.out'
  ent:
    type: File[]?
    outputBinding:
      glob: '*.ent'
  uni:
    type: File[]?
    outputBinding:
      glob: '*.uni'
