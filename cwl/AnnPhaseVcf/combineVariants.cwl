cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- java
- -jar
- /usr/GenomeAnalysisTK.jar
- -T
- CombineVariants
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk3:3.8-1
arguments:
- --assumeIdenticalSamples
inputs:
  variants:
    type:
      type: array
      items: File
      inputBinding:
        prefix: --variant
        separate: true
    inputBinding:
      separate: true
  ref:
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
      prefix: -o
      separate: true
outputs:
  oVcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
