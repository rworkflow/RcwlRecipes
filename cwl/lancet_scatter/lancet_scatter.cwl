cwlVersion: v1.2
class: Workflow
requirements:
- class: ScatterFeatureRequirement
- class: StepInputExpressionRequirement
- class: InlineJavascriptRequirement
inputs:
  tbam:
    type: File
    secondaryFiles:
    - ^.bai?
    - .bai?
  nbam:
    type: File
    secondaryFiles:
    - ^.bai?
    - .bai?
  ref:
    type: File
    secondaryFiles: .fai
  bed:
    type: File[]
  threads:
    type: int
outputs:
  ovcf:
    type: File
    outputSource: mergeVcf/Fout
steps:
  lancet_bed:
    run: lancet_bed.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: ref
      bed: bed
      threads: threads
    out:
    - vcf
    scatter: bed
    scatterMethod: dotproduct
  mergeVcf:
    run: mergeVcf.cwl
    in:
      ovcf:
        source:
        - tbam
        valueFrom: $(self.nameroot)_lancet.vcf
      vcfs: lancet_bed/vcf
    out:
    - Fout
