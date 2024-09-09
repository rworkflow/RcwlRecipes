cwlVersion: v1.0
class: Workflow
requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
inputs:
  rnafqs:
    type: File[]
  kallistoIdx:
    type: File
  threads:
    type: int
    default: 16
  svcf:
    type: File
outputs:
  ExpVcf:
    type: File
    secondaryFiles: .tbi
    outputSource: tabixIndex/idx
steps:
  kallistoQuant:
    run: kallistoQuant.cwl
    in:
      fastq: rnafqs
      index: kallistoIdx
      threads: threads
    out:
    - h5
    - tsv
    - info
  cleanExp:
    run: cleanExp.cwl
    in:
      afile: kallistoQuant/tsv
    out:
    - aout
  vcfExpAnn:
    run: vcfExpAnn.cwl
    in:
      ivcf: svcf
      ovcf:
        valueFrom: $(inputs.ivcf.nameroot)_ExpAnn.vcf
      expression: cleanExp/aout
      gtype:
        valueFrom: transcript
      etype:
        valueFrom: kallisto
    out:
    - oVcf
  T2Gene:
    run: T2Gene.cwl
    in:
      kexp: kallistoQuant/tsv
    out:
    - gout
  vcfgExpAnn:
    run: vcfgExpAnn.cwl
    in:
      ivcf: vcfExpAnn/oVcf
      ovcf:
        source:
        - svcf
        valueFrom: $(self[0].nameroot)_gAnn.vcf
      expression: T2Gene/gout
      gtype:
        valueFrom: gene
      etype:
        valueFrom: custom
      idCol:
        valueFrom: gene
      expCol:
        valueFrom: abundance
    out:
    - oVcf
  bgzip:
    run: bgzip.cwl
    in:
      ifile: vcfgExpAnn/oVcf
    out:
    - zfile
  tabixIndex:
    run: tabixIndex.cwl
    in:
      tfile: bgzip/zfile
      type:
        valueFrom: vcf
    out:
    - idx
