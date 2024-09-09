cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bwa
- mem
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/bwa:v0.7.17-3-deb_cv1
inputs:
  threads:
    type: int
    inputBinding:
      position: 1
      prefix: -t
      separate: true
  RG:
    type: string?
    inputBinding:
      position: 2
      prefix: -R
      separate: true
  Ref:
    type: File
    secondaryFiles:
    - .amb
    - .ann
    - .bwt
    - .pac
    - .sa
    inputBinding:
      position: 3
      separate: true
  FQ1:
    type: File
    inputBinding:
      position: 4
      separate: true
  FQ2:
    type: File?
    inputBinding:
      position: 5
      separate: true
outputs:
  sam:
    type: File
    outputBinding:
      glob: '*.sam'
stdout: bwaOutput.sam
