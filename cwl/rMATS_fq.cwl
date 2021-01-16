cwlVersion: v1.0
class: CommandLineTool
requirements:
- class: DockerRequirement
  dockerPull: xinglab/rmats
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entryname: fq1
    entry: ${var x='';for(var i=0;i<inputs.fq1.length;i++){x+=inputs.fq1[i].path+','}return(x)}
    writable: false
  - entryname: fq2
    entry: ${var x='';for(var i=0;i<inputs.fq2.length;i++){x+=inputs.fq2[i].path+','}return(x)}
    writable: false
arguments:
- --s1
- fq1
- --s2
- fq2
- --od
- '.'
inputs:
  fq1:
    type: File[]?
  fq2:
    type: File[]?
  type:
    type: string
    inputBinding:
      prefix: -t
      separate: true
    default: paired
  readLength:
    type: int
    inputBinding:
      prefix: --readLength
      separate: true
  gtf:
    type: File
    inputBinding:
      prefix: --gtf
      separate: true
  threads:
    type: int?
    inputBinding:
      prefix: --nthread
      separate: true
    default: 1
  tstat:
    type: int?
    inputBinding:
      prefix: --tstat
      separate: true
  tmp:
    type: string
    inputBinding:
      prefix: --tmp
      separate: true
    default: tmp
outputs:
  res:
    type: File[]
    outputBinding:
      glob: '*.txt'
