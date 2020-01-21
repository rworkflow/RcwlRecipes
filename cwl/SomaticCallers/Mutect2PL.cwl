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
    - $(self.nameroot).dict
  normal:
    type: string
  tumor:
    type: string
  gresource:
    type: File
    secondaryFiles: .idx
  pon:
    type: File
    secondaryFiles: .idx
  interval:
    type: File
  comvcf:
    type: File
    secondaryFiles: .idx
  artMode:
    type:
      type: array
      items: string
      inputBinding:
        separate: true
    default:
    - G/T
    - C/T
  filter:
    type: string
    default: PASS
outputs:
  filterVCF:
    type: File
    outputSource: FilterOBias/fout
  passVCF:
    type: File
    outputSource: bcfview/Fout
  conTable:
    type: File
    outputSource: CalculateContamination/cout
  artTable:
    type: File
    outputSource: ColSeqArtifact/aout
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
      out:
        source:
        - normal
        - tumor
        valueFrom: $(self[0]).$(self[1])
    out:
    - vout
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
        valueFrom: $(self[0]).contamination.table
    out:
    - cout
  FilterMutectCalls:
    run: FilterMutectCalls.cwl
    in:
      vcf: Mutect2/vout
      cont: CalculateContamination/cout
      ref: Ref
      fvcf:
        source:
        - normal
        - tumor
        valueFrom: $(self[0]).$(self[1]).ctfiltered.vcf
    out:
    - fout
  ColSeqArtifact:
    run: ColSeqArtifact.cwl
    in:
      bam: tbam
      ref: Ref
      art:
        valueFrom: $(inputs.bam.nameroot).art
    out:
    - aout
  FilterOBias:
    run: FilterOBias.cwl
    in:
      vcf: FilterMutectCalls/fout
      art: ColSeqArtifact/aout
      mode: artMode
      avcf:
        source:
        - normal
        - tumor
        valueFrom: $(self[0]).$(self[1]).ctfiltered.obfiltered.vcf
    out:
    - fout
  bcfview:
    run: bcfview.cwl
    in:
      vcf: FilterOBias/fout
      filter: filter
      fout:
        valueFrom: $(inputs.vcf.nameroot).PASS.vcf
    out:
    - Fout
