cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- GenotypeGVCFs
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  variant:
    type: File
    secondaryFiles: .idx
    inputBinding:
      prefix: -V
      separate: true
  ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
    inputBinding:
      prefix: -R
      separate: true
  vout:
    type: string
    inputBinding:
      prefix: -O
      separate: true
outputs:
  vcf:
    type: File
    secondaryFiles: .idx
    outputBinding:
      glob: $(inputs.vout)
