cwlVersion: v1.0
class: CommandLineTool
baseCommand: deduplicate_bismark
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bismark:0.23.1--hdfd78af_0
inputs:
  bam:
    type: File
    inputBinding:
      position: 99
      separate: true
  format:
    type: boolean?
    inputBinding:
      prefix: --bam
      separate: true
  paired:
    type: boolean?
    inputBinding:
      prefix: --paired
      separate: true
  outdir:
    type: string?
    inputBinding:
      prefix: --output_dir
      separate: true
outputs:
  dbam:
    type: File
    outputBinding:
      glob: '*.deduplicated.bam'
