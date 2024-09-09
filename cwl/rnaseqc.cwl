cwlVersion: v1.0
class: CommandLineTool
baseCommand: rnaseqc
requirements:
- class: DockerRequirement
  dockerPull: gcr.io/broad-cga-aarong-gtex/rnaseqc:latest
inputs:
  gtf:
    type: File
    inputBinding:
      position: 1
      separate: true
  bam:
    type: File
    inputBinding:
      position: 2
      separate: true
  bed:
    type: File?
    inputBinding:
      prefix: --bed
      separate: true
  out:
    type: string?
    inputBinding:
      position: 9
      separate: true
    default: '.'
outputs:
  qcOut:
    type: File[]
    outputBinding:
      glob: $(inputs.bam.nameroot)*
