cwlVersion: v1.0
class: Workflow
inputs:
  nvcf:
    type:
      type: array
      items: File
      inputBinding:
        separate: true
    secondaryFiles: .idx
  Ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
  interval:
    type: File
  pvcf:
    type: string
  gresource:
    type: File?
    secondaryFiles: .idx
outputs:
  Pvcf:
    type: File
    outputSource: PoN/pout
steps:
  GenomicsDB:
    run: cwl/GPoN/GenomicsDB.cwl
    in:
      vcf: nvcf
      Ref: Ref
      intervals: interval
    out:
    - dbout
  PoN:
    run: cwl/GPoN/PoN.cwl
    in:
      db: GenomicsDB/dbout
      Ref: Ref
      pon: pvcf
      gresource: gresource
    out:
    - pout
