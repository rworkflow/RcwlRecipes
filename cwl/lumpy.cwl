cwlVersion: v1.0
class: CommandLineTool
baseCommand: lumpyexpress
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--hdfd78af_3
inputs:
  bam:
    type: File[]
    secondaryFiles: .bai
    inputBinding:
      prefix: -B
      separate: true
      itemSeparator: ','
  split:
    type: File[]
    secondaryFiles: .bai
    inputBinding:
      prefix: -S
      separate: true
      itemSeparator: ','
  discord:
    type: File[]
    secondaryFiles: .bai
    inputBinding:
      prefix: -D
      separate: true
      itemSeparator: ','
  vout:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  vcf:
    type: File
    outputBinding:
      glob: $(inputs.vout)
