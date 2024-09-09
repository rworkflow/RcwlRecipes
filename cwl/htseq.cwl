cwlVersion: v1.0
class: CommandLineTool
baseCommand: htseq-count
requirements:
- class: DockerRequirement
  dockerPull: genomicpariscentre/htseq
arguments:
- --format
- bam
- --mode
- intersection-strict
inputs:
  minaqual:
    type: int
    inputBinding:
      prefix: -a
      separate: true
  stranded:
    type: string
    inputBinding:
      prefix: -s
      separate: true
  bam:
    type: File
    inputBinding:
      separate: true
  gtf:
    type: File
    inputBinding:
      separate: true
outputs:
  out:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).htseq.txt
stdout: $(inputs.bam.nameroot).htseq.txt
