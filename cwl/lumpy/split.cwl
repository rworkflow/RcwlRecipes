cwlVersion: v1.0
class: CommandLineTool
baseCommand: extractSplitReads_BwaMem
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--hdfd78af_3
inputs:
  sam:
    type: File
    inputBinding:
      prefix: -i
      separate: true
outputs:
  splitReads:
    type: File
    outputBinding:
      glob: $(inputs.sam.nameroot).splitReads.sam
stdout: $(inputs.sam.nameroot).splitReads.sam
