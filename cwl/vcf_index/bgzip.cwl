cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bgzip
- -c
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/tabix:v1.3.2-2-deb_cv1
inputs:
  ifile:
    type: File
    inputBinding:
      separate: true
outputs:
  zfile:
    type: File
    outputBinding:
      glob: $(inputs.ifile.basename).gz
stdout: $(inputs.ifile.basename).gz
