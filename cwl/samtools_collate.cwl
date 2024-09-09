cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- collate
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.16.1--h6899075_1
inputs:
  fast:
    type: boolean?
    inputBinding:
      prefix: -f
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  threads:
    type: int?
    inputBinding:
      prefix: --threads
      separate: true
  bam:
    type: File
    inputBinding:
      position: 99
      separate: true
outputs:
  obam:
    type: File
    outputBinding:
      glob: $(inputs.out)
