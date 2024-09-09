cwlVersion: v1.0
class: CommandLineTool
baseCommand: convert2bed
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bedops:2.4.39--h7d875b9_1
inputs:
  infmt:
    type: string
    inputBinding:
      prefix: --input=
      separate: false
  infile:
    type: File
  outbed:
    type: string
outputs:
  outBed:
    type: File
    outputBinding:
      glob: $(inputs.outbed)
stdin: $(inputs.infile.path)
stdout: $(inputs.outbed)
