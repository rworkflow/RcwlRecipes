cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- CreateSomaticPanelOfNormals
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
- class: EnvVarRequirement
  envDef:
    TILEDB_DISABLE_FILE_LOCKING: '1'
- class: InlineJavascriptRequirement
arguments:
- --min-sample-count
- '1'
- -V
inputs:
  db:
    type: Directory
    inputBinding:
      position: 1
      prefix: gendb://
      separate: false
  Ref:
    type: File
    secondaryFiles:
    - .fai
    - ^.dict
    inputBinding:
      position: 2
      prefix: -R
      separate: true
  pon:
    type: string
    inputBinding:
      position: 3
      prefix: -O
      separate: true
  gresource:
    type: File?
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
    inputBinding:
      position: 4
      prefix: --germline-resource
      separate: true
outputs:
  pout:
    type: File
    secondaryFiles: .idx
    outputBinding:
      glob: $(inputs.pon)
