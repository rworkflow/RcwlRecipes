cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- java
- -jar
- /usr/GenomeAnalysisTK.jar
- -T
- MuTect2
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk3:3.8-1
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -I:tumor
      separate: true
  nbam:
    type: File?
    secondaryFiles: .bai
    inputBinding:
      prefix: -I:normal
      separate: true
  Ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
    inputBinding:
      prefix: -R
      separate: true
  dbSNP:
    type: File?
    secondaryFiles: .idx
    inputBinding:
      prefix: --dbsnp
      separate: true
  cosmic:
    type: File?
    secondaryFiles: .idx
    inputBinding:
      prefix: --cosmic
      separate: true
  interval:
    type: File?
    inputBinding:
      prefix: -L
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  nct:
    type: int?
    inputBinding:
      prefix: -nct
      separate: true
outputs:
  vout:
    type: File
    secondaryFiles: .idx
    outputBinding:
      glob: $(inputs.out)
