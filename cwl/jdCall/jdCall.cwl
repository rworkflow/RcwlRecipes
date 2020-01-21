cwlVersion: v1.0
class: Workflow
inputs:
  sampleName:
    type: string
  gvcf:
    type: string
  callsetName:
    type: string
  intervals:
    type: string
  unpadded_intervals:
    type: string
  tmpl:
    type: File
  cromwell:
    type: File
  wdl:
    type: File
outputs:
  hclog:
    type: File
    outputSource: JD/log
  outdir:
    type: Directory
    outputSource: mvOut/OutDir
steps:
  jdJson:
    run: cwl/jdCall/jdJson.cwl
    in:
      sampleName: sampleName
      gvcf: gvcf
      callsetName: callsetName
      intervals: intervals
      unpadded_intervals: unpadded_intervals
      tmpl: tmpl
    out:
    - json
  JD:
    run: cwl/jdCall/JD.cwl
    in:
      cromwell: cromwell
      wdl: wdl
      json: jdJson/json
    out:
    - log
  mvOut:
    run: cwl/jdCall/mvOut.cwl
    in:
      logFile: JD/log
    out:
    - OutDir
