cwlVersion: v1.0
class: Workflow
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement
- class: MultipleInputFeatureRequirement
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
  nbam:
    type: File
    secondaryFiles: .bai
  Ref:
    type: File
    secondaryFiles:
    - .fai
    - ^.dict
  normal:
    type: string
  tumor:
    type: string
  dbsnp:
    type: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
  interval:
    type: File
  threads:
    type: int
    default: 8.0
outputs:
  mutect2out:
    type: File
    outputSource: Mutect2/vout
  MuSEout:
    type: File
    outputSource: MuSE/outVcf
  strelka2snv:
    type: File
    outputSource: mantaStrelka/snvs
  strelka2indel:
    type: File
    outputSource: mantaStrelka/indels
  VarDictout:
    type: File
    outputSource: VarDict/outVcf
  combineVcf:
    type: File
    outputSource: combine/cvcf
steps:
  Mutect2:
    run: Mutect2.cwl
    in:
      tbam: tbam
      nbam: nbam
      Ref: Ref
      normal: normal
      out:
        source:
        - tumor
        - normal
        valueFrom: $(self[0])_$(self[1])_mutect2.vcf
      threads: threads
      interval: interval
    out:
    - vout
    - F1r2
  MuSE:
    run: MuSE.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: Ref
      region: interval
      dbsnp: dbsnp
      vcf:
        source:
        - tumor
        - normal
        valueFrom: $(self[0])_$(self[1])_MuSE.vcf
    out:
    - outVcf
  bgzip:
    run: bgzip.cwl
    in:
      ifile: interval
    out:
    - zfile
  tabixIndex:
    run: tabixIndex.cwl
    in:
      tfile: bgzip/zfile
      type:
        valueFrom: bed
    out:
    - idx
  mantaStrelka:
    run: mantaStrelka.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: Ref
      region: tabixIndex/idx
    out:
    - snvs
    - indels
    - somaticSV
    - diploidSV
  VarDict:
    run: VarDict.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: Ref
      region: interval
      threads: threads
      vcf:
        source:
        - tumor
        - normal
        valueFrom: $(self[0])_$(self[1])_VarDict.vcf
      af:
        valueFrom: '0.05'
    out:
    - outVcf
  combine:
    run: combine.cwl
    in:
      m2: Mutect2/vout
      vd: VarDict/outVcf
      mu: MuSE/outVcf
      ss: mantaStrelka/snvs
      si: mantaStrelka/indels
      tid: tumor
      nid: normal
    out:
    - cvcf
