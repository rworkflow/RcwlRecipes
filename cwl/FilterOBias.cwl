cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- FilterByOrientationBias
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  vcf:
    type: File
    inputBinding:
      prefix: -V
      separate: true
  art:
    type: File
    inputBinding:
      prefix: -P
      separate: true
  mode:
    type:
      type: array
      items: string
      inputBinding:
        prefix: --artifact-modes
        separate: true
    inputBinding:
      separate: true
  avcf:
    type: string
    inputBinding:
      prefix: -O
      separate: true
outputs:
  fout:
    type: File
    outputBinding:
      glob: $(inputs.avcf)
