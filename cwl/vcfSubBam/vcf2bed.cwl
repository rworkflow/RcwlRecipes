cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- bash
- script.sh
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/bedtools:2.30.0--h7d7f7ad_2
- class: InitialWorkDirRequirement
  listing:
  - entryname: script.sh
    entry: |2

      vcf=$1
      fai=$2
      win=$3

      vn=`basename $vcf .bed`
      awk '{if($0 !~ "^#")print $1"\t"$2-1"\t"$2}' $vcf > vcfbed
      bedtools slop -i vcfbed -b $win -g $fai > $vn.$win.bed
    writable: false
inputs:
  vcf:
    type: File
    inputBinding:
      position: 1
      separate: true
  fai:
    type: File
    inputBinding:
      position: 2
      separate: true
  win:
    type: int
    inputBinding:
      position: 3
      separate: true
outputs:
  bed:
    type: File
    outputBinding:
      glob: '*.bed'
