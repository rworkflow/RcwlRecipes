cwlVersion: v1.0
class: Workflow
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
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
    type: int?
outputs:
  filterVCF:
    type: File
    outputSource: FilterMutectCalls/fout
  passVCF:
    type: File
    outputSource: bcfview/Fout
  conTable:
    type: File
    outputSource: CalculateContamination/Cout
  segment:
    type: File
    outputSource: CalculateContamination/Seg
steps:
  Mutect2:
    run: Mutect2.cwl
    in:
      tbam: tbam
      nbam: nbam
      Ref: Ref
      normal: normal
      germline: gresource
      pon: pon
      interval: interval
      threads: threads
      out:
        source:
        - normal
        - tumor
        valueFrom: $(self[0]).$(self[1])
    out:
    - vout
    - F1r2
  GetPileupSummariesT:
    run: GetPileupSummariesT.cwl
    in:
      bam: tbam
      vcf: comvcf
      interval: comvcf
      pileup:
        valueFrom: $(inputs.bam.nameroot).ptable
    out:
    - pout
  GetPileupSummariesN:
    run: GetPileupSummariesN.cwl
    in:
      bam: nbam
      vcf: comvcf
      interval: comvcf
      pileup:
        valueFrom: $(inputs.bam.nameroot).ptable
    out:
    - pout
  CalculateContamination:
    run: CalculateContamination.cwl
    in:
      ttable: GetPileupSummariesT/pout
      ntable: GetPileupSummariesN/pout
      cont:
        source:
        - tumor
        valueFrom: $(self).contamination.table
      seg:
        source:
        - tumor
        valueFrom: $(self).segments
    out:
    - Cout
    - Seg
  LearnReadOrientationModel:
    run: LearnReadOrientationModel.cwl
    in:
      f1r2: Mutect2/F1r2
    out:
    - rofile
  FilterMutectCalls:
    run: FilterMutectCalls.cwl
    in:
      vcf: Mutect2/vout
      cont: CalculateContamination/Cout
      seg: CalculateContamination/Seg
      lro: LearnReadOrientationModel/rofile
      ref: Ref
      fvcf:
        source:
        - normal
        - tumor
        valueFrom: $(self[0]).$(self[1]).filtered.vcf
    out:
    - fout
  bcfview:
    run: bcfview.cwl
    in:
      vcf: FilterMutectCalls/fout
      filter: filter
      fout:
        valueFrom: $(inputs.vcf.nameroot).PASS.vcf
    out:
    - Fout
