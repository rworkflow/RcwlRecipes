cwlVersion: v1.0
class: CommandLineTool
baseCommand: gp_MutSigCV
requirements:
- class: DockerRequirement
  dockerPull: genepattern/docker-mutsigcv:2a
inputs:
  maf:
    type: File
    inputBinding:
      position: 1
      separate: true
  coverage:
    type: File
    inputBinding:
      position: 2
      separate: true
  covar:
    type: File
    inputBinding:
      position: 3
      separate: true
  sig:
    type: string
    inputBinding:
      position: 4
      separate: true
  dict:
    type: File
    inputBinding:
      position: 5
      separate: true
outputs:
  sigout:
    type: File
    outputBinding:
      glob: $(inputs.sig).sig_genes.txt
