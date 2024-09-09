cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /opt/neusomatic/neusomatic/python/postprocess.py
requirements:
- class: DockerRequirement
  dockerPull: msahraeian/neusomatic
arguments:
- --work
- '.'
inputs:
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: --reference
      separate: true
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: --tumor_bam
      separate: true
  pred:
    type: File
    inputBinding:
      prefix: --pred_vcf
      separate: true
  fcandidates:
    type: File
    inputBinding:
      prefix: --candidates_vcf
      separate: true
  ensemble:
    type: File
    inputBinding:
      prefix: --ensemble_tsv
      separate: true
  ovcf:
    type: string
    inputBinding:
      prefix: --output_vcf
      separate: true
outputs:
  oVcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
