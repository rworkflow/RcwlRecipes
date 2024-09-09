cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- java
- -jar
- /opt/varscan/VarScan.jar
- processSomatic
requirements:
- class: DockerRequirement
  dockerPull: mgibio/varscan-cwl:v2.4.2-samtools1.3.1
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.vcf)
inputs:
  vcf:
    type: File
    inputBinding:
      separate: true
outputs:
  somaticHC:
    type: File
    outputBinding:
      glob: $(inputs.vcf.nameroot).Somatic.hc.vcf
  somatic:
    type: File
    outputBinding:
      glob: $(inputs.vcf.nameroot).Somatic.vcf
  germline:
    type: File
    outputBinding:
      glob: $(inputs.vcf.nameroot).Germline.vcf
  germlineHC:
    type: File
    outputBinding:
      glob: $(inputs.vcf.nameroot).Germline.hc.vcf
  LOH:
    type: File
    outputBinding:
      glob: $(inputs.vcf.nameroot).LOH.vcf
  LOHHC:
    type: File
    outputBinding:
      glob: $(inputs.vcf.nameroot).LOH.hc.vcf
