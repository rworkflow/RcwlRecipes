cwlVersion: v1.0
class: CommandLineTool
baseCommand: /software/SVE/scripts/auto.py
requirements:
- class: DockerRequirement
  dockerPull: timothyjamesbecker/sve
inputs:
  fqs:
    type: File[]
    inputBinding:
      prefix: -f
      separate: true
      itemSeparator: ','
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: -r
      separate: true
  outdir:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  threads:
    type: int
    inputBinding:
      prefix: -T
      separate: true
    default: 4
outputs:
  outs:
    type: Directory
    outputBinding:
      glob: $(inputs.outdir)
