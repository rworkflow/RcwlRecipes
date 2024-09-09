cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /rmats/rmats.py
requirements:
- class: DockerRequirement
  dockerPull: rmats_darts
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
- --od
- '.'
inputs:
  bam1:
    type: File[]
  bam2:
    type: File[]
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
  libType:
    type: string?
    inputBinding:
      prefix: --libType
      separate: true
  varReadLength:
    type: boolean?
    inputBinding:
      prefix: --variable-read-length
      separate: true
  anchorLength:
    type: int?
    inputBinding:
      prefix: --anchorLength
      separate: true
  cstat:
    type: float?
    inputBinding:
      prefix: --cstat
      separate: true
  task:
    type: string?
    inputBinding:
      prefix: --task
      separate: true
  statoff:
    type: boolean?
    inputBinding:
      prefix: --statoff
      separate: true
  pairedStats:
    type: boolean?
    inputBinding:
      prefix: --paired-stats
      separate: true
  novelSS:
    type: boolean?
    inputBinding:
      prefix: --novelSS
      separate: true
  mil:
    type: int?
    inputBinding:
      prefix: --mil
      separate: true
  mel:
    type: int?
    inputBinding:
      prefix: --mel
      separate: true
  fixedEvent:
    type: Directory?
    inputBinding:
      prefix: --fixed-event-set
      separate: true
  darts:
    type: boolean?
    inputBinding:
      prefix: --darts-model
      separate: true
outputs:
  res:
    type: File[]
    outputBinding:
      glob: '*.txt'
  tmpout:
    type: Directory
    outputBinding:
      glob: $(inputs.tmp)
