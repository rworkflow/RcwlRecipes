cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- CombineGVCFs
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  vcfs:
    type:
      type: array
      items: File
      inputBinding:
        prefix: --variant
        separate: true
    secondaryFiles: .tbi
    inputBinding:
      separate: true
  Ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
    inputBinding:
      prefix: -R
      separate: true
  ovcf:
    type: string
    inputBinding:
      prefix: -O
      separate: true
outputs:
  vcf:
    type: File
    secondaryFiles: .idx
    outputBinding:
      glob: $(inputs.ovcf)
