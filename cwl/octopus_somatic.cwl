cwlVersion: v1.2
class: CommandLineTool
baseCommand: octopus
requirements:
- class: DockerRequirement
  dockerPull: dancooke/octopus
arguments:
- --forest
- /opt/octopus/resources/forests/germline.v0.7.4.forest
- --somatic-forest
- /opt/octopus/resources/forests/somatic.v0.7.4.forest
inputs:
  bams:
    type: File[]
    secondaryFiles:
    - .bai?
    - ^.bai?
    inputBinding:
      prefix: -I
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: -R
      separate: true
  normal:
    type: string
    inputBinding:
      prefix: -N
      separate: true
  ovcf:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  region:
    type: File?
    inputBinding:
      prefix: -t
      separate: true
  error:
    type: string?
    inputBinding:
      prefix: --sequence-error-model
      separate: true
  threads:
    type: int?
    inputBinding:
      prefix: --threads
      separate: true
  expFreq:
    type: float?
    inputBinding:
      prefix: --min-expected-somatic-frequency
      separate: true
  creFreq:
    type: float?
    inputBinding:
      prefix: --min-credible-somatic-frequency
      separate: true
  annotation:
    type: string[]?
    inputBinding:
      prefix: --annotations
      separate: true
outputs:
  oVcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
