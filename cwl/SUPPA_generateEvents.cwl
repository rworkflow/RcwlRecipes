cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /opt/SUPPA/suppa.py
- generateEvents
requirements:
- class: DockerRequirement
  dockerPull: hubentu/suppa
- class: ShellCommandRequirement
inputs:
  gtf:
    type: File
    inputBinding:
      prefix: -i
      separate: true
  outfile:
    type: string
    inputBinding:
      prefix: -o
      separate: true
    default: event
  events:
    type: string
    inputBinding:
      prefix: -e
      separate: true
      shellQuote: false
    default: SE SS MX RI FL
  format:
    type: string
    inputBinding:
      prefix: -f
      separate: true
    default: ioe
outputs:
  outGTF:
    type: File[]
    outputBinding:
      glob: $(inputs.outfile)_*_strict.gtf
  outIOE:
    type: File[]
    outputBinding:
      glob: $(inputs.outfile)_*_strict.ioe
