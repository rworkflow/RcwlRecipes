cwlVersion: v1.2
class: CommandLineTool
baseCommand: lancet
requirements:
- class: DockerRequirement
  dockerPull: hubentu/lancet
inputs:
  tbam:
    type: File
    secondaryFiles:
    - ^.bai?
    - .bai?
    inputBinding:
      prefix: --tumor
      separate: true
  nbam:
    type: File
    secondaryFiles:
    - ^.bai?
    - .bai?
    inputBinding:
      prefix: --normal
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: --ref
      separate: true
  bed:
    type: File?
    inputBinding:
      prefix: --bed
      separate: true
  reg:
    type: string?
    inputBinding:
      prefix: --reg
      separate: true
  threads:
    type: int
    inputBinding:
      prefix: --num-threads
      separate: true
outputs:
  vcf:
    type: File
    outputBinding:
      glob: $(inputs.tbam.namerooot)_lancet.vcf
stdout: $(inputs.tbam.namerooot)_lancet.vcf
