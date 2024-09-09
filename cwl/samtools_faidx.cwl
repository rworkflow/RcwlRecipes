cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- samtools
- faidx
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.15--h1170115_1
inputs:
  fa:
    type: File
    secondaryFiles: .fai
    inputBinding:
      separate: true
  region:
    type: string
    inputBinding:
      position: 1
      separate: true
outputs:
  fout:
    type: File
    outputBinding:
      glob: $(inputs.fa.nameroot)_$(inputs.region).fa
stdout: $(inputs.fa.nameroot)_$(inputs.region).fa
