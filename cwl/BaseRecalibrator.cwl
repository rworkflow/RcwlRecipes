cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- BaseRecalibrator
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
- class: InlineJavascriptRequirement
inputs:
  bam:
    type: File
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
  knowSites:
    type:
      type: array
      items: File
      inputBinding:
        prefix: --known-sites
        separate: true
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
    inputBinding:
      separate: true
  recal:
    type: string
    inputBinding:
      prefix: -O
      separate: true
outputs:
  rtable:
    type: File
    outputBinding:
      glob: $(inputs.recal)
