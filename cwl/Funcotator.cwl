cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- Funcotator
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
arguments:
- --remove-filtered-variants
inputs:
  vcf:
    type: File
    inputBinding:
      prefix: -V
      separate: true
  ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
    inputBinding:
      prefix: -R
      separate: true
  outf:
    type: string
    inputBinding:
      prefix: --output-file-format
      separate: true
    default: MAF
  dsource:
    type: Directory
    inputBinding:
      prefix: --data-sources-path
      separate: true
  version:
    type: string
    inputBinding:
      prefix: --ref-version
      separate: true
    default: hg19
  maf:
    type: string
    inputBinding:
      prefix: -O
      separate: true
outputs:
  mout:
    type: File
    outputBinding:
      glob: $(inputs.maf)
