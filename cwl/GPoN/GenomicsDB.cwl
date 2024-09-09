cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- GenomicsDBImport
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
arguments:
- --merge-input-intervals
inputs:
  vcf:
    type:
      type: array
      items: File
      inputBinding:
        prefix: -V
        separate: true
    secondaryFiles: .idx
    inputBinding:
      separate: true
  Ref:
    type: File
    secondaryFiles:
    - .fai
    - ^.dict
    inputBinding:
      prefix: -R
      separate: true
  db:
    type: string
    inputBinding:
      prefix: --genomicsdb-workspace-path
      separate: true
    default: pon_db
  intervals:
    type: File
    inputBinding:
      prefix: -L
      separate: true
outputs:
  dbout:
    type: Directory
    outputBinding:
      glob: $(inputs.db)
