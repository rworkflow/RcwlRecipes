cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- java
- -jar
- /usr/GenomeAnalysisTK.jar
- -T
- DepthOfCoverage
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk3:3.8-1
arguments:
- -omitBaseOutput
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -I
      separate: true
  prefix:
    type: string
    inputBinding:
      prefix: -o
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
    - $(self.nameroot).dict
    inputBinding:
      prefix: -R
      separate: true
  ct:
    type:
      type: array
      items: int
      inputBinding:
        prefix: -ct
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
