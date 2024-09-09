cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bcftools
- query
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.13--h3a49de5_0
inputs:
  exclude:
    type: string?
    inputBinding:
      prefix: -e
      separate: true
  format:
    type: string?
    inputBinding:
      prefix: -f
      separate: true
  header:
    type: boolean?
    inputBinding:
      prefix: -H
      separate: true
  include:
    type: string?
    inputBinding:
      prefix: -i
      separate: true
  listSample:
    type: boolean?
    inputBinding:
      prefix: -l
      separate: true
  region:
    type: string?
    inputBinding:
      prefix: -r
      separate: true
  regionFile:
    type: File?
    inputBinding:
      prefix: -R
      separate: true
  sample:
    type: string?
    inputBinding:
      prefix: -s
      separate: true
  sampleFile:
    type: File?
    inputBinding:
      prefix: -S
      separate: true
  target:
    type: string?
    inputBinding:
      prefix: -t
      separate: true
  targetFile:
    type: File?
    inputBinding:
      prefix: -T
      separate: true
  uTags:
    type: boolean?
    inputBinding:
      prefix: -u
      separate: true
  vcfList:
    type: File?
    inputBinding:
      prefix: -v
      separate: true
  vcf:
    type: File?
    inputBinding:
      position: 20
      separate: true
  out:
    type: string
outputs:
  qout:
    type: File
    outputBinding:
      glob: $(inputs.out)
stdout: $(inputs.out)
