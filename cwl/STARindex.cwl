cwlVersion: v1.0
class: CommandLineTool
baseCommand: STAR
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/star:2.7.10a--h9ee0642_0
arguments:
- --runMode
- genomeGenerate
inputs:
  genomeDir:
    type: string
    inputBinding:
      prefix: --genomeDir
      separate: true
    default: STARindex
  genomeFastaFiles:
    type: File
    inputBinding:
      prefix: --genomeFastaFiles
      separate: true
  sjdbGTFfile:
    type: File
    inputBinding:
      prefix: --sjdbGTFfile
      separate: true
  runThreadN:
    type: int
    inputBinding:
      prefix: --runThreadN
      separate: true
    default: 4
outputs:
  outIndex:
    type: Directory
    outputBinding:
      glob: $(inputs.genomeDir)
