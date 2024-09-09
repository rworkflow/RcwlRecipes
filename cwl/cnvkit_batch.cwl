cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- cnvkit.py
- batch
requirements:
- class: DockerRequirement
  dockerPull: etal/cnvkit
inputs:
  tbams:
    type: File[]?
    secondaryFiles: .bai
    inputBinding:
      separate: true
  ref:
    type: File?
    secondaryFiles: .fai
    inputBinding:
      prefix: --fasta
      separate: true
  outdir:
    type: string
    inputBinding:
      prefix: --output-dir
      separate: true
  normal:
    type: File[]?
    secondaryFiles: .bai
    inputBinding:
      prefix: --normal
      separate: true
  outref:
    type: string?
    inputBinding:
      prefix: --output-reference
      separate: true
  reference:
    type: File?
    inputBinding:
      prefix: -r
      separate: true
  target:
    type: File?
    inputBinding:
      prefix: --targets
      separate: true
  anti:
    type: File?
    inputBinding:
      prefix: --antitargets
      separate: true
  access:
    type: File?
    inputBinding:
      prefix: --access
      separate: true
  annotate:
    type: File?
    inputBinding:
      prefix: --annotate
      separate: true
  parallel:
    type: int
    inputBinding:
      prefix: -p
      separate: true
    default: 1.0
  diagram:
    type: boolean
    inputBinding:
      prefix: --diagram
      separate: true
    default: true
  scatter:
    type: boolean
    inputBinding:
      prefix: --scatter
      separate: true
    default: true
  method:
    type: string?
    inputBinding:
      prefix: -m
      separate: true
outputs:
  Outdir:
    type: Directory
    outputBinding:
      glob: $(inputs.outdir)
  outRef:
    type: File?
    outputBinding:
      glob: $(inputs.outref)
