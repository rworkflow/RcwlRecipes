cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- sequenza-utils
- seqz_binning
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py39h67e14b5_5
inputs:
  seqz:
    type: File
    inputBinding:
      prefix: --seqz
      separate: true
  window:
    type: int
    inputBinding:
      prefix: -w
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  seqzs:
    type: File
    outputBinding:
      glob: $(inputs.out)
