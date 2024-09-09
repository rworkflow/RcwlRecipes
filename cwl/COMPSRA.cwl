cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- java
- -jar
- /opt/COMPSRA.jar
requirements:
- class: DockerRequirement
  dockerPull: hubentu/compsra
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.DB)
    entryname: $('bundle_v1/')
- class: InlineJavascriptRequirement
arguments:
- -qc
- -rb
- '4'
- -rh
- '20'
- -rt
- '20'
- -rr
- '20'
- -rlh
- '8,17'
- -aln
- -mt
- star
- -ann
- -ac
- '1,2,3,4,5,6'
- -out
- '.'
inputs:
  fq:
    type: File
    inputBinding:
      prefix: -in
      separate: true
  adapt:
    type: string
    inputBinding:
      prefix: -ra
      separate: true
  ref:
    type: string
    inputBinding:
      prefix: -ref
      separate: true
    default: hg38
  DB:
    type: Directory
outputs:
  outdir:
    type: Directory
    outputBinding:
      glob: $(inputs.fq.nameroot.split('.')[0])
