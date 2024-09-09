cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- java
- -jar
- /opt/varscan/VarScan.jar
- somaticFilter
requirements:
- class: DockerRequirement
  dockerPull: mgibio/varscan-cwl:v2.4.2-samtools1.3.1
inputs:
  vcf:
    type: File
    inputBinding:
      position: 1
      separate: true
  indel:
    type: File
    inputBinding:
      position: 2
      prefix: --indel-file
      separate: true
  outvcf:
    type: string
    inputBinding:
      position: 3
      prefix: --output-file
      separate: true
outputs:
  outVcf:
    type: File
    outputBinding:
      glob: $(inputs.outvcf)
