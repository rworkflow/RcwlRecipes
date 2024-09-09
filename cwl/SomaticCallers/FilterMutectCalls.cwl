cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- FilterMutectCalls
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  vcf:
    type: File
    secondaryFiles:
    - .idx
    - .stats
    inputBinding:
      prefix: -V
      separate: true
  cont:
    type: File
    inputBinding:
      prefix: --contamination-table
      separate: true
  seg:
    type: File
    inputBinding:
      prefix: --tumor-segmentation
      separate: true
  lro:
    type: File
    inputBinding:
      prefix: --ob-priors
      separate: true
  fvcf:
    type: string
    inputBinding:
      prefix: -O
      separate: true
  ref:
    type: File
    secondaryFiles:
    - .fai
    - ^.dict
    inputBinding:
      prefix: -R
      separate: true
outputs:
  fout:
    type: File
    outputBinding:
      glob: $(inputs.fvcf)
