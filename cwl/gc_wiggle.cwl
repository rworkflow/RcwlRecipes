cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- sequenza-utils
- gc_wiggle
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/sequenza-utils:3.0.0--py39h67e14b5_5
inputs:
  window:
    type: int
    inputBinding:
      prefix: -w
      separate: true
  ref:
    type: File
    inputBinding:
      prefix: -f
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  wig:
    type: File
    outputBinding:
      glob: $(inputs.out)
