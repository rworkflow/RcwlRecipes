cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- view
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.16.1--h6899075_1
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 99
      separate: true
  bed:
    type: File?
    inputBinding:
      position: 1
      prefix: -L
      separate: true
  obam:
    type: string
    inputBinding:
      position: 2
      prefix: -o
      separate: true
  region:
    type: string?
    inputBinding:
      position: 100
      separate: true
  outb:
    type: boolean?
    inputBinding:
      prefix: -b
      separate: true
  exFlag:
    type: int?
    inputBinding:
      prefix: -F
      separate: true
  reqFlag:
    type: int?
    inputBinding:
      prefix: -f
      separate: true
  qname:
    type: File?
    inputBinding:
      prefix: -N
      separate: true
  threads:
    type: int?
    inputBinding:
      prefix: --threads
      separate: true
  mapq:
    type: int?
    inputBinding:
      prefix: -q
      separate: true
outputs:
  oBam:
    type: File
    outputBinding:
      glob: $(inputs.obam)
