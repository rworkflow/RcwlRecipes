cwlVersion: v1.0
class: CommandLineTool
baseCommand: blastn
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/blast:v2.2.31_cv2
inputs:
  ThreadN:
    type: int
    inputBinding:
      prefix: -num_threads
      separate: true
  Ref:
    type: File
    secondaryFiles:
    - .nhr
    - .nin
    - .nsq
    inputBinding:
      prefix: -db
      separate: true
  Query:
    type: File
    inputBinding:
      prefix: -query
      separate: true
  IdenPerc:
    type: int
    inputBinding:
      prefix: -perc_identity
      separate: true
  WordSize:
    type: int
    inputBinding:
      prefix: -word_size
      separate: true
  Evalue:
    type: float
    inputBinding:
      prefix: -evalue
      separate: true
  OutFormat:
    type: int
    inputBinding:
      prefix: -outfmt
      separate: true
  OutFile:
    type: string
    inputBinding:
      prefix: -out
      separate: true
outputs:
  Output:
    type: File
    outputBinding:
      glob: $(inputs.OutFile)
