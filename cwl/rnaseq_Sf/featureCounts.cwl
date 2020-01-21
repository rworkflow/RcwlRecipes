cwlVersion: v1.0
class: CommandLineTool
baseCommand: featureCounts
requirements:
- class: DockerRequirement
  dockerPull: hubentu/rcwl-rnaseq
inputs:
  gtf:
    type: File
    inputBinding:
      prefix: -a
      separate: true
  count:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  bam:
    type: File
    inputBinding:
      separate: true
outputs:
  Count:
    type: File
    secondaryFiles: .summary
    outputBinding:
      glob: $(inputs.count)
