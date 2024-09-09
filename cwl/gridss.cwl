cwlVersion: v1.0
class: CommandLineTool
baseCommand: gridss
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/gridss:2.13.2--h20b1175_1
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.ref)
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 99
      separate: true
  ref:
    type: File
    secondaryFiles:
    - .amb
    - .ann
    - .bwt
    - .pac
    - .sa
    - .fai
    inputBinding:
      prefix: --reference
      separate: true
  vcf:
    type: string
    inputBinding:
      prefix: --output
      separate: true
  assembly:
    type: string?
    inputBinding:
      prefix: --assembly
      separate: true
  threads:
    type: int?
    inputBinding:
      prefix: --threads
      separate: true
  gridss:
    type: File?
    inputBinding:
      prefix: --jar
      separate: true
  steps:
    type: string
    inputBinding:
      prefix: --steps
      separate: true
    default: all
outputs:
  ovcf:
    type: File
    outputBinding:
      glob: $(inputs.vcf)
  abam:
    type: File?
    outputBinding:
      glob: $(inputs.assembly)
