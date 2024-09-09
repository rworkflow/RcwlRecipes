cwlVersion: v1.0
class: CommandLineTool
baseCommand: /opt/somatic-sniper/build/bin/bam-somaticsniper
requirements:
- class: DockerRequirement
  dockerPull: lethalfang/somaticsniper:1.0.5.0-2
arguments:
- -q
- '10'
- -F
- vcf
inputs:
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      position: 1
      prefix: -f
      separate: true
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 2
      separate: true
  nbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 3
      separate: true
  vcf:
    type: string
    inputBinding:
      position: 4
      separate: true
outputs:
  outVcf:
    type: File
    outputBinding:
      glob: $(inputs.vcf)
