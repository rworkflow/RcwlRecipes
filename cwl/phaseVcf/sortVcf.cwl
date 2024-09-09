cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- java
- -jar
- /usr/picard/picard.jar
- SortVcf
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/picard
inputs:
  vcf:
    type: File
    inputBinding:
      prefix: I=
      separate: false
  ovcf:
    type: string
    inputBinding:
      prefix: O=
      separate: false
  dict:
    type: File?
    inputBinding:
      prefix: SD=
      separate: false
outputs:
  oVcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
