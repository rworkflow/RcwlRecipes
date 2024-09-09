cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- lofreq
- viterbi
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/lofreq:2.1.5--py37h916d2e8_4
arguments:
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
    secondaryFiles: .bai
    inputBinding:
      position: 2
      separate: true
  vbam:
    type: string
outputs:
  obam:
    type: File
    outputBinding:
      glob: $(inputs.vbam)
stdout: $(inputs.vbam)
