cwlVersion: v1.0
class: Workflow
requirements:
- class: SubworkflowFeatureRequirement
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
  nbam:
    type: File
    secondaryFiles: .bai
  ref:
    type: File
    secondaryFiles: .fai
  region:
    type: File
  dbsnp:
    type: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
  out:
    type: string
  threads:
    type: int
outputs:
  snp:
    type: File
    outputSource: lofreqCall/snp
  snpdb:
    type: File
    outputSource: lofreqCall/snpdb
  indel:
    type: File
    outputSource: lofreqCall/indel
  indeldb:
    type: File
    outputSource: lofreqCall/indeldb
steps:
  tbamR:
    run: tbamR.cwl
    in:
      ref: ref
      bam: tbam
    out:
    - ibam
  nbamR:
    run: nbamR.cwl
    in:
      ref: ref
      bam: nbam
    out:
    - ibam
  lofreqCall:
    run: lofreqCall.cwl
    in:
      tbam: tbamR/ibam
      nbam: nbamR/ibam
      ref: ref
      region: region
      dbsnp: dbsnp
      out: out
      threads: threads
    out:
    - snp
    - snpdb
    - indel
    - indeldb
