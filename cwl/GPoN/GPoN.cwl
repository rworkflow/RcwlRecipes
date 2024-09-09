cwlVersion: v1.0
class: Workflow
requirements:
- class: InlineJavascriptRequirement
inputs:
  nvcf:
    type:
      type: array
      items: File
    secondaryFiles: .idx
  Ref:
    type: File
    secondaryFiles:
    - .fai
    - ^.dict
  interval:
    type: File
  pvcf:
    type: string
  gresource:
    type: File?
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
outputs:
  Pvcf:
    type: File
    outputSource: PoN/pout
steps:
  GenomicsDB:
    run: GenomicsDB.cwl
    in:
      vcf: nvcf
      Ref: Ref
      intervals: interval
    out:
    - dbout
  PoN:
    run: PoN.cwl
    in:
      db: GenomicsDB/dbout
      Ref: Ref
      pon: pvcf
      gresource: gresource
    out:
    - pout
