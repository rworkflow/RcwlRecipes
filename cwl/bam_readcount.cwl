cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- /usr/bin/python
- /usr/bin/bam_readcount_helper.py
requirements:
- class: DockerRequirement
  dockerPull: mgibio/bam_readcount_helper-cwl:1.1.1
arguments:
- valueFrom: NOPREFIX
  position: 5
- valueFrom: ./
  position: 6
  shellQuote: false
inputs:
  vcf:
    type: File
    inputBinding:
      position: 1
      separate: true
  sample:
    type: string
    inputBinding:
      position: 2
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      position: 3
      separate: true
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 4
      separate: true
outputs:
  snv:
    type: File
    outputBinding:
      glob: $(inputs.sample)_bam_readcount_snv.tsv
  indel:
    type: File
    outputBinding:
      glob: $(inputs.sample)_bam_readcount_indel.tsv
