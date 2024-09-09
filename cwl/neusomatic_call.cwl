cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /opt/neusomatic/neusomatic/python/call.py
requirements:
- class: DockerRequirement
  dockerPull: msahraeian/neusomatic
arguments:
- --out
- '.'
- --ensemble
- --batch_size
- '100'
inputs:
  candidates:
    type: File[]
    secondaryFiles: .idx
    inputBinding:
      prefix: --candidates_tsv
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: --reference
      separate: true
  checkpoint:
    type: string
    inputBinding:
      prefix: --checkpoint
      separate: true
    default: /opt/neusomatic/neusomatic/models/NeuSomatic_v0.1.4_ensemble_SEQC-WGS-Spike.pth
outputs:
  pred:
    type: File
    outputBinding:
      glob: pred.vcf
