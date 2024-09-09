cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- gatk
- DepthOfCoverage
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  bam:
    type: File
    secondaryFiles:
    - .bai?
    - ^.bai?
    inputBinding:
      prefix: -I
      separate: true
  prefix:
    type: string
    inputBinding:
      prefix: -O
      separate: true
  region:
    type: File
    inputBinding:
      prefix: -L
      separate: true
  ref:
    type: File
    secondaryFiles:
    - .fai
    - ^.dict
    inputBinding:
      prefix: -R
      separate: true
  ct:
    type:
      type: array
      items: int
      inputBinding:
        prefix: --summary-coverage-threshold
        separate: true
    inputBinding:
      separate: true
    default:
    - 1
    - 10
    - 20
    - 30
outputs:
  out:
    type: File
    outputBinding:
      glob: $(inputs.prefix).sample_summary
