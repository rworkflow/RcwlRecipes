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
arguments:
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
    - $(self.nameroot).dict
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
    secondaryFiles: .idx
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
