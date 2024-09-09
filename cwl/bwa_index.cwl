cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bwa
- index
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/bwa:v0.7.17-3-deb_cv1
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.Ref)
- class: InlineJavascriptRequirement
arguments:
- -a
- bwtsw
inputs:
  Ref:
    type: File
    inputBinding:
      separate: true
      valueFrom: $(self.basename)
outputs:
  idx:
    type: File
    secondaryFiles:
    - $(inputs.Ref.basename + '.amb')
    - $(inputs.Ref.basename + '.ann')
    - $(inputs.Ref.basename + '.bwt')
    - $(inputs.Ref.basename + '.pac')
    - $(inputs.Ref.basename + '.sa')
    outputBinding:
      glob: $(inputs.Ref.basename)
