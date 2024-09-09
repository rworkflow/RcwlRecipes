cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
- class: MultipleInputFeatureRequirement
- class: InlineJavascriptRequirement
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
  nbam:
    type: File
    secondaryFiles: .bai
  outbcf:
    type: string
  exclude:
    type: File?
  genome:
    type: File
    secondaryFiles: .fai
outputs:
  bcf:
    type: File
    outputSource: dellyFilter/fbcf
steps:
  dellyCall:
    run: dellyCall.cwl
    in:
      exclude: exclude
      genome: genome
      outfile: outbcf
      tbam: tbam
      nbam: nbam
    out:
    - outbcf
  listSample:
    run: listSample.cwl
    in:
      vcf: dellyCall/outbcf
      out:
        valueFrom: sample.txt
      listSample:
        valueFrom: $(true)
    out:
    - qout
  echo:
    run: echo.cwl
    in:
      sth:
        valueFrom: |-
          tumor
          control
    out:
    - out
  fpaste:
    run: fpaste.cwl
    in:
      files:
        source:
        - listSample/qout
        - echo/out
        linkMerge: merge_flattened
    out:
    - out
  dellyFilter:
    run: dellyFilter.cwl
    in:
      outfile: outbcf
      tbcf: dellyCall/outbcf
      samples: fpaste/out
    out:
    - fbcf
