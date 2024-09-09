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
  gresource:
    type: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
  pon:
    type: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
  interval:
    type: File
  comvcf:
    type: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
  filter:
    type: string
    default: PASS
  threads:
    type: int
    default: 8
outputs:
  mutect2filterVCF:
    type: File
    outputSource: Mutect2PL/filterVCF
  mutect2passVCF:
    type: File
    outputSource: Mutect2PL/passVCF
  mutect2conTable:
    type: File
    outputSource: Mutect2PL/conTable
  mutect2segment:
    type: File
    outputSource: Mutect2PL/segment
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
  Mutect2PL:
    run: Mutect2PL.cwl
    in:
      tbam: tbam
      nbam: nbam
      Ref: Ref
      normal: normal
      tumor: tumor
      gresource: gresource
      pon: pon
      interval: interval
      comvcf: comvcf
    out:
    - filterVCF
    - passVCF
    - conTable
    - segment
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
      m2: Mutect2PL/filterVCF
      vd: VarDict/outVcf
      mu: MuSE/outVcf
      ss: mantaStrelka/snvs
      si: mantaStrelka/indels
      tid: tumor
      nid: normal
    out:
    - cvcf
