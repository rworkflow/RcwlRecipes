cwlVersion: v1.0
class: CommandLineTool
baseCommand: makeblastdb
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/blast:v2.2.31_cv2
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.Ref)
- class: InlineJavascriptRequirement
arguments:
- -dbtype
- nucl
inputs:
  Ref:
    type: File
    inputBinding:
      prefix: -in
      separate: true
      valueFrom: $(self.basename)
outputs:
  idx:
    type: File
    secondaryFiles:
    - $(inputs.Ref.basename + '.nhr')
    - $(inputs.Ref.basename + '.nin')
    - $(inputs.Ref.basename + '.nsq')
    outputBinding:
      glob: $(inputs.Ref.basename)
