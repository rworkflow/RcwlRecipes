cwlVersion: v1.0
class: CommandLineTool
baseCommand: /opt/VarDictJava/bin/VarDict
requirements:
- class: DockerRequirement
  dockerPull: msahraeian/vardictjava:1.8.2
- class: ShellCommandRequirement
arguments:
- valueFrom: -b
  position: 2
- valueFrom: $(inputs.tbam.path)|$(inputs.nbam.path)
  position: 3
- valueFrom: -f
  position: 4
- valueFrom: $(inputs.af)
  position: 5
- -c
- '1'
- -S
- '2'
- -E
- '3'
- -g
- '4'
- valueFrom: ' | '
  position: 6
- valueFrom: /opt/VarDictJava/bin/testsomatic.R
  position: 7
- valueFrom: ' | '
  position: 8
- valueFrom: /opt/VarDictJava/bin/var2vcf_paired.pl
  position: 9
- valueFrom: -N
  position: 10
- valueFrom: TUMOR|NORMAL
  position: 11
- valueFrom: -f
  position: 12
- valueFrom: $(inputs.af)
  position: 13
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
      position: 1
      prefix: -G
      separate: true
  region:
    type: File
    inputBinding:
      separate: true
  af:
    type: float
    default: 0.05
  vcf:
    type: string
outputs:
  outVcf:
    type: stdout
stdout: $(inputs.vcf)
