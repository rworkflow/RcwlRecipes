cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- pvacseq
- run
requirements:
- class: DockerRequirement
  dockerPull: griffithlab/pvactools
inputs:
  ivcf:
    type: File
    secondaryFiles: .tbi
    inputBinding:
      position: 1
      separate: true
  sample:
    type: string
    inputBinding:
      position: 2
      separate: true
  allele:
    type: string[]
    inputBinding:
      position: 3
      separate: true
      itemSeparator: ','
  algorithms:
    type: string[]
    inputBinding:
      position: 4
      separate: true
  outdir:
    type: string
    inputBinding:
      position: 5
      separate: true
    default: pvacseq_out
  length:
    type: string
    inputBinding:
      position: 6
      prefix: -e
      separate: true
    default: '8,9,10,11'
  phasedVcf:
    type: File?
    secondaryFiles: .tbi
    inputBinding:
      position: 7
      prefix: -p
      separate: true
outputs:
  Out:
    type: Directory
    outputBinding:
      glob: $(inputs.outdir)
