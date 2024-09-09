cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
- class: MultipleInputFeatureRequirement
inputs:
  tbam:
    type: File
  nbam:
    type: File
  ref:
    type: File
    secondaryFiles: .fai
  region:
    type: File
outputs:
  sSnp:
    type: File
    outputSource: somatic/snp
  sIndel:
    type: File
    outputSource: somatic/indel
  sVcf:
    type: File
    outputSource: somaticFilter/outVcf
steps:
  mpileupT:
    run: mpileupT.cwl
    in:
      bam: tbam
      ref: ref
      region: region
    out:
    - pileup
  mpileupN:
    run: mpileupN.cwl
    in:
      bam: nbam
      ref: ref
      region: region
    out:
    - pileup
  somatic:
    run: somatic.cwl
    in:
      npileup: mpileupN/pileup
      tpileup: mpileupT/pileup
      bname:
        valueFrom: $(inputs.tpileup.nameroot)
    out:
    - snp
    - indel
  processSomatic:
    run: processSomatic.cwl
    in:
      vcf: somatic/snp
    out:
    - somaticHC
    - somatic
    - germline
    - germlineHC
    - LOH
    - LOHHC
  somaticFilter:
    run: somaticFilter.cwl
    in:
      vcf: processSomatic/somaticHC
      indel: somatic/indel
      outvcf:
        source:
        - tbam
        - nbam
        valueFrom: $(self[0].nameroot).$(self[1].nameroot).somatic.vcf
    out:
    - outVcf
