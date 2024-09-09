cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- python
- /opt/neusomatic/neusomatic/python/preprocess.py
requirements:
- class: DockerRequirement
  dockerPull: msahraeian/neusomatic
- class: ShellCommandRequirement
arguments:
- --mode
- call
- --work
- '.'
- --scan_alignments_binary
- /opt/neusomatic/neusomatic/bin/scan_alignments
- valueFrom: '&& for i in `ls dataset/*/*tsv*`; do can=`echo $i | sed ''s/\/candidates/_candidates/''`;
    cp $i $can;done'
  position: 10
  shellQuote: false
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: --tumor_bam
      separate: true
  nbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: --normal_bam
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: --reference
      separate: true
  region:
    type: File
    inputBinding:
      prefix: --region_bed
      separate: true
  ensemble:
    type: File
    inputBinding:
      prefix: --ensemble_tsv
      separate: true
  mapq:
    type: int
    inputBinding:
      prefix: --min_mapq
      separate: true
    default: 10
  threads:
    type: int
    inputBinding:
      prefix: --num_threads
      separate: true
    default: 2
outputs:
  candidates:
    type: File[]
    secondaryFiles: .idx
    outputBinding:
      glob: dataset/work*candidates*.tsv
  fcandidates:
    type: File
    outputBinding:
      glob: work_tumor/filtered_candidates.vcf
