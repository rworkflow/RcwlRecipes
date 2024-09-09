cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- java
- -jar
- /usr/GenomeAnalysisTK.jar
- -T
- ReadBackedPhasing
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk3:3.8-1
inputs:
  vcf:
    type: File
    inputBinding:
      prefix: --variant
      separate: true
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -I
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
  region:
    type: File
    inputBinding:
      prefix: -L
      separate: true
outputs:
  oVcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
