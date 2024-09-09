cwlVersion: v1.0
class: Workflow
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement
inputs:
  vcf:
    type: File
  sample:
    type: string
  bam:
    type: File
    secondaryFiles: .bai
  ntype:
    type: string
    default: DNA
  ref:
    type: File
    secondaryFiles: .fai
outputs:
  outvcf:
    type: File
    outputSource: readcount_annotator_indel/oVcf
steps:
  decompose:
    run: decompose.cwl
    in:
      ivcf: vcf
      ovcf:
        valueFrom: $(inputs.ivcf.nameroot)_dc.vcf
    out:
    - oVcf
  readcount:
    run: readcount.cwl
    in:
      vcf: decompose/oVcf
      sample: sample
      ref: ref
      bam: bam
    out:
    - snv
    - indel
  readcount_annotator_snv:
    run: readcount_annotator_snv.cwl
    in:
      ivcf: decompose/oVcf
      readcount: readcount/snv
      ntype: ntype
      sample: sample
      ovcf:
        valueFrom: $(inputs.ivcf.nameroot)_snv.vcf
    out:
    - oVcf
  readcount_annotator_indel:
    run: readcount_annotator_indel.cwl
    in:
      ivcf: readcount_annotator_snv/oVcf
      readcount: readcount/indel
      ntype: ntype
      sample: sample
      vtype:
        valueFrom: indel
      ovcf:
        valueFrom: $(inputs.ivcf.nameroot)_indel.vcf
    out:
    - oVcf
