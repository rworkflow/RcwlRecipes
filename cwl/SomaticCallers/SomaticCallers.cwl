cwlVersion: v1.0
class: Workflow
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement
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
    default: 8.0
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
  SomaticSniperout:
    type: File
    outputSource: SomaticSniper/outVcf
  VarDictout:
    type: File
    outputSource: VarDict/outVcf
  VarScanSnp:
    type: File
    outputSource: VarScanPL/sSnp
  VarScanIndel:
    type: File
    outputSource: VarScanPL/sIndel
  VarScansVcf:
    type: File
    outputSource: VarScanPL/sVcf
  mergeTSVout:
    type: File
    outputSource: mergeTSV/tsv
  WrapperSNV:
    type: File
    outputSource: Wrapper/conSNV
  WrapperINDEL:
    type: File
    outputSource: Wrapper/conINDEL
  WrapperESNV:
    type: File
    outputSource: Wrapper/EnsSNV
  WrapperEINDEL:
    type: File
    outputSource: Wrapper/EnsINDEL
  neusomaticVCF:
    type: File
    outputSource: neusomaticPL/outVcf
steps:
  Mutect2PL:
    run: Mutect2PL.cwl
    in:
      tbam: tbam
      nbam: nbam
      Ref: Ref
      normal:
        valueFrom: $(inputs.nbam.nameroot.split('_')[0])
      tumor:
        valueFrom: $(inputs.tbam.nameroot.split('_')[0])
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
        valueFrom: $(inputs.tbam.nameroot.split('_')[0])_MuSE.vcf
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
  SomaticSniper:
    run: SomaticSniper.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: Ref
      vcf:
        valueFrom: $(inputs.tbam.nameroot.split('_')[0])_SomaticSniper.vcf
    out:
    - outVcf
  VarDict:
    run: VarDict.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: Ref
      region: interval
      vcf:
        valueFrom: $(inputs.tbam.nameroot.split('_')[0])_VarDict.vcf
    out:
    - outVcf
  VarScanPL:
    run: VarScanPL.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: Ref
      region: interval
    out:
    - sSnp
    - sIndel
    - sVcf
  Wrapper:
    run: Wrapper.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: Ref
      region: interval
      dbsnp: dbsnp
      mutect2: Mutect2PL/filterVCF
      varscanSnv: VarScanPL/sSnp
      varscanIndel: VarScanPL/sIndel
      sniper: SomaticSniper/outVcf
      vardict: VarDict/outVcf
      muse: MuSE/outVcf
      strelkaSnv: mantaStrelka/snvs
      strelkaIndel: mantaStrelka/indels
    out:
    - conSNV
    - conINDEL
    - EnsSNV
    - EnsINDEL
  mergeTSV:
    run: mergeTSV.cwl
    in:
      esnv: Wrapper/EnsSNV
      eindel: Wrapper/EnsINDEL
    out:
    - tsv
  neusomaticPL:
    run: neusomaticPL.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: Ref
      region: interval
      ensemble: mergeTSV/tsv
      threads: threads
      ovcf:
        valueFrom: $(inputs.tbam.nameroot.split('_')[0])_neusomatic.vcf
    out:
    - outVcf
