cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- fastq
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.16.1--h6899075_1
inputs:
  fq1:
    type: string
    inputBinding:
      prefix: '-1'
      separate: true
  fq2:
    type: string?
    inputBinding:
      prefix: '-2'
      separate: true
  fq0:
    type: string?
    inputBinding:
      prefix: '-0'
      separate: true
  bam:
    type: File
    inputBinding:
      position: 99
      separate: true
  threads:
    type: int?
    inputBinding:
      prefix: --threads
      separate: true
outputs:
  FQ1:
    type: File
    outputBinding:
      glob: $(inputs.fq1)
  FQ2:
    type: File?
    outputBinding:
      glob: $(inputs.fq2)
  FQ0:
    type: File?
    outputBinding:
      glob: $(inputs.fq0)
