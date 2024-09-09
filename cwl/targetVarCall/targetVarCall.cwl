cwlVersion: v1.0
class: Workflow
requirements:
- class: SubworkflowFeatureRequirement
- class: StepInputExpressionRequirement
- class: InlineJavascriptRequirement
inputs:
  Sample:
    type: string
  RG:
    type: string
  threads:
    type: int
  Ref:
    type: File
    secondaryFiles:
    - .amb
    - .ann
    - .bwt
    - .pac
    - .sa
    - .fai
    - $(self.nameroot).dict
  FQ1:
    type: File
  FQ2:
    type: File
  knowSites:
    type:
      type: array
      items: File
    secondaryFiles: .idx
  bed:
    type: File
  downsampling:
    type: int
    default: 0
outputs:
  BAM:
    type: File
    outputSource: BaseRecal/rcBam
  flagstat:
    type: File
    outputSource: BaseRecal/flagstat
  stats:
    type: File
    outputSource: BaseRecal/stats
  gVCF:
    type: File
    outputSource: HaplotypeCaller/gvcf
  VCF:
    type: File
    outputSource: GenotypeGVCFs/vcf
steps:
  bwaAlign:
    run: bwaAlign.cwl
    in:
      threads: threads
      RG: RG
      Ref: Ref
      FQ1: FQ1
      FQ2: FQ2
    out:
    - Bam
    - Idx
  BaseRecal:
    run: BaseRecal.cwl
    in:
      bam: bwaAlign/Idx
      ref: Ref
      knowSites: knowSites
      oBam:
        source: Sample
        valueFrom: $(self).bam
    out:
    - rcBam
    - flagstat
    - stats
  bedtolist:
    run: bedtolist.cwl
    in:
      bed: bed
      SD:
        source: Ref
        valueFrom: $(self.secondaryFiles[6])
      out:
        valueFrom: $(inputs.bed.nameroot).list
    out:
    - intval
  HaplotypeCaller:
    run: HaplotypeCaller.cwl
    in:
      bam: BaseRecal/rcBam
      interval: bedtolist/intval
      ref: Ref
      gout:
        source: Sample
        valueFrom: $(self).g.vcf
      downsampling: downsampling
    out:
    - gvcf
  GenotypeGVCFs:
    run: GenotypeGVCFs.cwl
    in:
      variant: HaplotypeCaller/gvcf
      ref: Ref
      vout:
        source: Sample
        valueFrom: $(self).vcf
    out:
    - vcf
