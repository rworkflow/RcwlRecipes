cwlVersion: v1.2
class: CommandLineTool
baseCommand: cnv_facets.R
requirements:
- class: DockerRequirement
  dockerPull: hubentu/facets:0.6.2
inputs:
  tbam:
    type: File?
    secondaryFiles:
    - .bai?
    - ^.bai?
    inputBinding:
      prefix: -t
      separate: true
  nbam:
    type: File?
    secondaryFiles:
    - .bai?
    - ^.bai?
    inputBinding:
      prefix: -n
      separate: true
  vcf:
    type: File?
    secondaryFiles: .tbi
    inputBinding:
      prefix: -vcf
      separate: true
  pileup:
    type: File?
    inputBinding:
      prefix: -p
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  build:
    type: string?
    inputBinding:
      prefix: -g
      separate: true
  targets:
    type: File?
    inputBinding:
      prefix: -T
      separate: true
  cval:
    type: int[]?
    inputBinding:
      prefix: -cv
      separate: true
  nprocs:
    type: int?
    inputBinding:
      prefix: -N
      separate: true
outputs:
  Out:
    type: File[]
    outputBinding:
      glob: $(inputs.out)*
