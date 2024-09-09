cwlVersion: v1.0
class: CommandLineTool
baseCommand: /usr/local/src/STAR-Fusion/STAR-Fusion
requirements:
- class: DockerRequirement
  dockerPull: trinityctat/starfusion
inputs:
  fq1:
    type: File
    inputBinding:
      prefix: --left_fq
      separate: true
  fq2:
    type: File?
    inputBinding:
      prefix: --right_fq
      separate: true
  genomedir:
    type: Directory
    inputBinding:
      prefix: --genome_lib_dir
      separate: true
  odir:
    type: string
    inputBinding:
      prefix: --output_dir
      separate: true
  cpu:
    type: int
    inputBinding:
      prefix: --CPU
      separate: true
outputs:
  sout:
    type: Directory
    outputBinding:
      glob: $(inputs.odir)
