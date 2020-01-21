cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- GetPileupSummaries
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  bam:
    type: File
    inputBinding:
      prefix: -I
      separate: true
  vcf:
    type: File
    secondaryFiles: .idx
    inputBinding:
      prefix: -V
      separate: true
  interval:
    type: File
    secondaryFiles: .idx
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
