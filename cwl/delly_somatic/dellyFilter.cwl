cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- delly
- filter
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/delly:0.8.7--he03298f_1
inputs:
  filter:
    type: string
    inputBinding:
      prefix: -f
      separate: true
    default: somatic
  outfile:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  samples:
    type: File
    inputBinding:
      prefix: -s
      separate: true
  tbcf:
    type: File
    secondaryFiles: .csi
    inputBinding:
      separate: true
outputs:
  fbcf:
    type: File
    secondaryFiles: .csi
    outputBinding:
      glob: $(inputs.outfile)
