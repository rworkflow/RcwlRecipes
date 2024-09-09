cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- HaplotypeCaller
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -I
      separate: true
  interval:
    type: File
    inputBinding:
      prefix: -L
      separate: true
  ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
    inputBinding:
      prefix: -R
      separate: true
  gout:
    type: string
    inputBinding:
      prefix: -O
      separate: true
  emit:
    type: string
    inputBinding:
      prefix: -ERC
      separate: true
    default: GVCF
  downsampling:
    type: int
    inputBinding:
      prefix: --max-reads-per-alignment-start
      separate: true
    default: 50
outputs:
  gvcf:
    type: File
    secondaryFiles: .idx
    outputBinding:
      glob: $(inputs.gout)
