cwlVersion: v1.0
class: CommandLineTool
requirements:
- class: DockerRequirement
  dockerPull: guigolab/ggsashimi
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.bamDir)
inputs:
  tsv:
    type: File
    inputBinding:
      prefix: -b
      separate: true
  bamDir:
    doc: The bam files in the input tsv should be relative to this directory
    type: Directory
  coord:
    type: string
    inputBinding:
      prefix: -c
      separate: true
  gtf:
    type: File
    inputBinding:
      prefix: -g
      separate: true
  Cfactor:
    type: int?
    inputBinding:
      prefix: -C
      separate: true
    default: 3
  overlay:
    type: int?
    inputBinding:
      prefix: -O
      separate: true
    default: 3
  oprefix:
    type: string
    inputBinding:
      prefix: -o
      separate: true
    default: sashimi
  alpha:
    type: float
    inputBinding:
      prefix: --alpha
      separate: true
    default: 0.25
outputs:
  plot:
    type: File
    outputBinding:
      glob: $(inputs.oprefix).pdf
