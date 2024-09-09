cwlVersion: v1.2
class: CommandLineTool
requirements:
- class: DockerRequirement
  dockerPull: hubentu/somatic_combiner
inputs:
  vardict:
    type: File?
    inputBinding:
      prefix: -D
      separate: true
  lofreqSNV:
    type: File?
    secondaryFiles: .tbi
    inputBinding:
      prefix: -l
      separate: true
  lofreqIndel:
    type: File?
    secondaryFiles: .tbi
    inputBinding:
      prefix: -L
      separate: true
  mutect:
    type: File?
    secondaryFiles: .tbi
    inputBinding:
      prefix: -m
      separate: true
  mutect2:
    type: File?
    secondaryFiles:
      pattern: .tbi
      required: false
    inputBinding:
      prefix: -M
      separate: true
  strelkaSNV:
    type: File?
    secondaryFiles: .tbi
    inputBinding:
      prefix: -s
      separate: true
  strelkaIndel:
    type: File?
    secondaryFiles: .tbi
    inputBinding:
      prefix: -S
      separate: true
  muse:
    type: File?
    inputBinding:
      prefix: -u
      separate: true
  varscanSNV:
    type: File?
    inputBinding:
      prefix: -v
      separate: true
  varscanIndel:
    type: File?
    inputBinding:
      prefix: -V
      separate: true
  outvcf:
    type: string
    inputBinding:
      prefix: -o
      separate: true
outputs:
  ovcf:
    type: File
    outputBinding:
      glob: $(inputs.outvcf)
