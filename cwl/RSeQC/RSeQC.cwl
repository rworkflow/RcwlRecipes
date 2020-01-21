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
    run: cwl/RSeQC/gtfToGenePred.cwl
    in:
      gtf: gtf
      gPred:
        valueFrom: $(inputs.gtf.nameroot).genePred
    out:
    - genePred
  genePredToBed:
    run: cwl/RSeQC/genePredToBed.cwl
    in:
      genePred: gtfToGenePred/genePred
      Bed:
        valueFrom: $(inputs.genePred.nameroot).bed
    out:
    - bed
  r_distribution:
    run: cwl/RSeQC/r_distribution.cwl
    in:
      bam: bam
      bed: genePredToBed/bed
    out:
    - distOut
  gCoverage:
    run: cwl/RSeQC/gCoverage.cwl
    in:
      bam: bam
      bed: genePredToBed/bed
      prefix:
        valueFrom: $(inputs.bam.nameroot)
    out:
    - gCovPDF
    - gCovTXT
