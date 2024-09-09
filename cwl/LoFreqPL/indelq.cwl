cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- lofreq
- indelqual
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/lofreq:2.1.5--py37h916d2e8_4
arguments:
- --dindel
- --verbose
inputs:
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      position: 1
      prefix: -f
      separate: true
  bam:
    type: File
    inputBinding:
      position: 2
      separate: true
  ibam:
    type: string
outputs:
  obam:
    type: File
    outputBinding:
      glob: $(inputs.ibam)
stdout: $(inputs.ibam)
