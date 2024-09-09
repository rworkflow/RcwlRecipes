cwlVersion: v1.0
class: CommandLineTool
baseCommand: glnexus_cli
requirements:
- class: DockerRequirement
  dockerPull: ghcr.io/dnanexus-rnd/glnexus:v1.4.1
- class: InitialWorkDirRequirement
  listing:
  - entryname: gvcfs
    entry: ${var x='';for(var i=0;i<inputs.gvcfs.length;i++){x+=inputs.gvcfs[i].path+'\n'}return(x)}
    writable: false
- class: InlineJavascriptRequirement
arguments:
- --list
- gvcfs
inputs:
  config:
    type: string
    inputBinding:
      prefix: --config
      separate: true
  bed:
    type: File?
    inputBinding:
      prefix: --bed
      separate: true
  gvcfs:
    type: File[]
  ovcf:
    type: string
  threads:
    type: int
    inputBinding:
      prefix: -t
      separate: true
outputs:
  bcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
stdout: $(inputs.ovcf)
