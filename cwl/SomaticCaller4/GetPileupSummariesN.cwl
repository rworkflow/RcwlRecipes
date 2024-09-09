cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- GetPileupSummaries
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
- class: InlineJavascriptRequirement
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -I
      separate: true
  vcf:
    type: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
    inputBinding:
      prefix: -V
      separate: true
  interval:
    type: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
    inputBinding:
      prefix: -L
      separate: true
  pileup:
    type: string
    inputBinding:
      prefix: -O
      separate: true
outputs:
  pout:
    type: File
    outputBinding:
      glob: $(inputs.pileup)
