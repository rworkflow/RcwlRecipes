cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- bash
- /home/polysolver/scripts/shell_call_hla_type
requirements:
- class: DockerRequirement
  dockerPull: sachet/polysolver:v4
arguments:
- valueFrom: $(runtime.outdir)
  position: 7
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      position: 1
      separate: true
  race:
    type: string
    inputBinding:
      position: 2
      separate: true
    default: Unknown
  includeFreq:
    type: int
    inputBinding:
      position: 3
      separate: true
    default: 1
  build:
    type: string
    inputBinding:
      position: 4
      separate: true
    default: hg19
  format:
    type: string
    inputBinding:
      position: 5
      separate: true
    default: STDFQ
  insertCalc:
    type: int
    inputBinding:
      position: 6
      separate: true
    default: 0
outputs:
  hla:
    type: File
    outputBinding:
      glob: '*.hla.txt'
