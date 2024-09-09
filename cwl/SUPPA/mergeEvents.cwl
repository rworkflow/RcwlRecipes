cwlVersion: v1.0
class: CommandLineTool
baseCommand: awk
arguments:
- FNR==1 && NR!=1 { while (/^<header>/) getline; } 1 {print}
inputs:
  files:
    type: File[]
    inputBinding:
      separate: true
  outfile:
    type: string
    default: merged.txt
outputs:
  out:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
stdout: $(inputs.outfile)
