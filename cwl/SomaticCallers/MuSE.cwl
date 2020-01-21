cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- MuSEv1.0rc_submission_c039ffa
- call
requirements:
- class: DockerRequirement
  dockerPull: marghoob/muse:1.0rc_c
- class: ShellCommandRequirement
arguments:
- -O
- output
- valueFrom: ' && '
  position: 5
- valueFrom: MuSEv1.0rc_submission_c039ffa
  position: 6
- valueFrom: sump
  position: 7
- valueFrom: -I
  position: 8
- valueFrom: output.MuSE.txt
  position: 9
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 1
      separate: true
  nbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 2
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      position: 3
      prefix: -f
      separate: true
  region:
    type: File?
    inputBinding:
      position: 4
      prefix: -l
      separate: true
  dbsnp:
    type: File
    secondaryFiles: .tbi
    inputBinding:
      position: 10
      prefix: -D
      separate: true
  vcf:
    type: string
    inputBinding:
      position: 11
      prefix: -O
      separate: true
  exome:
    type: boolean
    inputBinding:
      position: 12
      prefix: -E
      separate: true
    default: true
  genome:
    type: boolean
    inputBinding:
      position: 12
      prefix: -G
      separate: true
    default: false
outputs:
  outVcf:
    type: File
    outputBinding:
      glob: $(inputs.vcf)
