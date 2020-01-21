cwlVersion: v1.0
class: CommandLineTool
baseCommand: /lancet-1.0.7/lancet
requirements:
- class: DockerRequirement
  dockerPull: kfdrc/lancet:1.0.7
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: --tumor
      separate: true
  nbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: --normal
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: --ref
      separate: true
  region:
    type: File
    inputBinding:
      prefix: --bed
      separate: true
  threads:
    type: int
    inputBinding:
      prefix: --num-threads
      separate: true
outputs:
  vcf:
    type: stdout
stdout: $(inputs.tbam.nameroot)_$(inputs.nbam.nameroot).vcf
