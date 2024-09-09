cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bash
- script.sh
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bedops:2.4.39--h7d875b9_1
- class: InitialWorkDirRequirement
  listing:
  - entryname: script.sh
    entry: |2

      gtf=$1
      name=`basename $gtf .gtf`
      awk '{ if ($0 ~ "transcript_id") print $0; else print $0" transcript_id \"\";"; }' $gtf | gtf2bed - > $name.bed
    writable: false
inputs:
  gtf:
    type: File
    inputBinding:
      separate: true
outputs:
  bed:
    type: File
    outputBinding:
      glob: '*.bed'
