cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- delly
- call
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/delly:0.8.7--he03298f_1
inputs:
  exclude:
    type: File?
    inputBinding:
      prefix: -x
      separate: true
  genome:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: -g
      separate: true
  outfile:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  bcf:
    type: File?
    secondaryFiles: .csi
    inputBinding:
      prefix: -v
      separate: true
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 5
      separate: true
  nbam:
    type: File?
    secondaryFiles: .bai
    inputBinding:
      position: 6
      separate: true
outputs:
  outbcf:
    type: File
    secondaryFiles: .csi
    outputBinding:
      glob: $(inputs.outfile)
