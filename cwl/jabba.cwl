cwlVersion: v1.0
class: CommandLineTool
baseCommand: jba
requirements:
- class: DockerRequirement
  dockerPull: hubentu/jabba
- class: EnvVarRequirement
  envDef:
    GRB_LICENSE_FILE: $(inputs.license.path)
- class: InlineJavascriptRequirement
inputs:
  junction:
    type: File
    inputBinding:
      position: 1
      separate: true
  coverage:
    type: File
    inputBinding:
      position: 2
      separate: true
  gurobi:
    type: string?
    inputBinding:
      position: 3
      prefix: --gurobi
      separate: true
    default: 'TRUE'
  slack:
    type: int?
    inputBinding:
      position: 4
      prefix: --slack
      separate: true
  license:
    type: File
outputs:
  gg:
    type: File
    outputBinding:
      glob: jabba.simple.gg.rds
  plot:
    type: File
    outputBinding:
      glob: karyograph.rds.ppfit.png
  seg:
    type: File
    outputBinding:
      glob: jabba.seg
  report:
    type: File
    outputBinding:
      glob: opt.report.rds
