cwlVersion: v1.0
class: CommandLineTool
baseCommand: configManta.py
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/manta:1.6.0--h9ee0642_1
- class: ShellCommandRequirement
arguments:
- --runDir
- mantaRunDir
- valueFrom: ' && '
  position: 5
  shellQuote: false
- valueFrom: mantaRunDir/runWorkflow.py
  position: 6
- valueFrom: -m
  position: 7
- valueFrom: local
  position: 8
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 1
      prefix: --tumorBam
      separate: true
  nbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 2
      prefix: --normalBam
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      position: 3
      prefix: --referenceFasta
      separate: true
  callRegions:
    type: File?
    secondaryFiles: .tbi
    inputBinding:
      position: 4
      prefix: --callRegions
      separate: true
  exome:
    type: boolean
    inputBinding:
      prefix: --exome
      separate: true
    default: true
outputs:
  somaticSV:
    type: File
    secondaryFiles: .tbi
    outputBinding:
      glob: mantaRunDir/results/variants/somaticSV.vcf.gz
  diploidSV:
    type: File
    secondaryFiles: .tbi
    outputBinding:
      glob: mantaRunDir/results/variants/diploidSV.vcf.gz
  candidateSV:
    type: File
    secondaryFiles: .tbi
    outputBinding:
      glob: mantaRunDir/results/variants/candidateSV.vcf.gz
  candidateSmallIndels:
    type: File
    secondaryFiles: .tbi
    outputBinding:
      glob: mantaRunDir/results/variants/candidateSmallIndels.vcf.gz
