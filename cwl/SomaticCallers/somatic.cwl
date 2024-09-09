cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- java
- -jar
- /opt/varscan/VarScan.jar
- somatic
requirements:
- class: DockerRequirement
  dockerPull: mgibio/varscan-cwl:v2.4.2-samtools1.3.1
inputs:
  npileup:
    type: File
    inputBinding:
      position: 1
      separate: true
  tpileup:
    type: File
    inputBinding:
      position: 2
      separate: true
  bname:
    type: string
    inputBinding:
      position: 3
      separate: true
  vcfout:
    type: boolean
    inputBinding:
      position: 4
      prefix: --output-vcf
      separate: true
    default: true
outputs:
  snp:
    type: File
    outputBinding:
      glob: $(inputs.bname).snp.vcf
  indel:
    type: File
    outputBinding:
      glob: $(inputs.bname).indel.vcf
