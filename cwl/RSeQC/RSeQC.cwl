cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
inputs:
  bam:
    type: File
    secondaryFiles: .bai
  gtf:
    type: File
outputs:
  distribution:
    type: File
    outputSource: r_distribution/distOut
  gCovP:
    type: File
    outputSource: gCoverage/gCovPDF
  gCovT:
    type: File
    outputSource: gCoverage/gCovTXT
steps:
  gtfToGenePred:
    run: gtfToGenePred.cwl
    in:
      gtf: gtf
      gPred:
        valueFrom: $(inputs.gtf.nameroot).genePred
    out:
    - genePred
  genePredToBed:
    run: genePredToBed.cwl
    in:
      genePred: gtfToGenePred/genePred
      Bed:
        valueFrom: $(inputs.genePred.nameroot).bed
    out:
    - bed
  r_distribution:
    run: r_distribution.cwl
    in:
      bam: bam
      bed: genePredToBed/bed
    out:
    - distOut
  gCoverage:
    run: gCoverage.cwl
    in:
      bam: bam
      bed: genePredToBed/bed
      prefix:
        valueFrom: $(inputs.bam.nameroot)
    out:
    - gCovPDF
    - gCovTXT
