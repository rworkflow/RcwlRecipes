cwlVersion: v1.0
class: CommandLineTool
requirements:
- class: DockerRequirement
  dockerPull: xinglab/rmats
- class: InlineJavascriptRequirement
- class: InitialWorkDirRequirement
  listing:
  - entryname: bam1
    entry: ${var x='';for(var i=0;i<inputs.bam1.length;i++){x+=inputs.bam1[i].path+','}return(x)}
    writable: false
  - entryname: bam2
    entry: ${var x='';for(var i=0;i<inputs.bam2.length;i++){x+=inputs.bam2[i].path+','}return(x)}
    writable: false
arguments:
- --b1
- bam1
- --b2
- bam2
inputs:
  bam1:
    type: File[]?
  bam2:
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
  od:
    type: string?
    inputBinding:
      prefix: --od
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
