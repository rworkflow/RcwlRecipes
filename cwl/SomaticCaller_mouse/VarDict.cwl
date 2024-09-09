cwlVersion: v1.0
class: CommandLineTool
baseCommand: vardict-java
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/vardict-java:1.8.2--hdfd78af_1
- class: ShellCommandRequirement
arguments:
- valueFrom: -b
  position: 5
- valueFrom: $(inputs.tbam.path)|$(inputs.nbam.path)
  position: 6
- valueFrom: -f
  position: 7
- valueFrom: $(inputs.af)
  position: 8
- -c
- '1'
- -S
- '2'
- -E
- '3'
- -g
- '4'
- valueFrom: ' | '
  position: 9
  shellQuote: false
- valueFrom: testsomatic.R
  position: 10
- valueFrom: ' | '
  position: 11
  shellQuote: false
- valueFrom: var2vcf_paired.pl
  position: 12
- valueFrom: -N
  position: 13
- valueFrom: TUMOR|NORMAL
  position: 14
- valueFrom: -f
  position: 15
- valueFrom: $(inputs.af)
  position: 16
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
  nbam:
    type: File
    secondaryFiles: .bai
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      position: 2
      prefix: -G
      separate: true
  region:
    type: File
    inputBinding:
      position: 1
      separate: true
  af:
    type: string
    default: '0.01'
  vcf:
    type: string
  threads:
    type: int
    inputBinding:
      position: 4
      prefix: -th
      separate: true
    default: 1
outputs:
  outVcf:
    type: File
    outputBinding:
      glob: $(inputs.vcf)
stdout: $(inputs.vcf)
