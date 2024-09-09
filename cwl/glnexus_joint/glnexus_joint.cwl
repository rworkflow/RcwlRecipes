cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
inputs:
  config:
    type: string
  bed:
    type: File?
  gvcfs:
    type: File[]
  ovcf:
    type: string
  threads:
    type: int
outputs:
  outVcf:
    type: File
    outputSource: bcf/Fout
steps:
  glnexus:
    run: glnexus.cwl
    in:
      config: config
      threads: threads
      bed: bed
      gvcfs: gvcfs
      ovcf:
        valueFrom: merged.bcf
    out:
    - bcf
  bcf:
    run: bcf.cwl
    in:
      vcf: glnexus/bcf
      fout: ovcf
      otype:
        valueFrom: z
    out:
    - Fout
