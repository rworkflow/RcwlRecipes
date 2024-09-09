cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bcftools
- concat
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bcftools:1.13--h3a49de5_0
- class: InitialWorkDirRequirement
  listing:
  - entryname: gvcfs
    entry: "${var x='';for(var i=0;i<inputs.gvcfs.length;i++){x+=inputs.gvcfs[i].path+'\t'}return(x)}"
    writable: false
arguments:
- -f
- gvcfs
inputs:
  ovcf:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  gvcfs:
    type: File[]
  type:
    type: string?
    inputBinding:
      prefix: -O
      separate: true
  overlap:
    type: boolean?
    inputBinding:
      prefix: -a
      separate: true
outputs:
  Fout:
    type: File
    secondaryFiles: .tbi?
    outputBinding:
      glob: $(inputs.ovcf)
