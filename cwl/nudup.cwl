cwlVersion: v1.0
class: CommandLineTool
baseCommand: nudup.py
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/nudup:2.3.3--py_2
inputs:
  index:
    type: File
    inputBinding:
      prefix: -f
      separate: true
  paired:
    type: boolean?
    inputBinding:
      prefix: '-2'
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  sam:
    type: File
    inputBinding:
      position: 10
      separate: true
outputs:
  mbam:
    type: File
    outputBinding:
      glob: $(inputs.out).sorted.markdup.bam
  dbam:
    type: File
    outputBinding:
      glob: $(inputs.out).sorted.dedup.bam
  report:
    type: File
    outputBinding:
      glob: '*log.txt'
