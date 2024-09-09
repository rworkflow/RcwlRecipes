cwlVersion: v1.0
class: Workflow
inputs:
  bam:
    type: string
  intervals:
    type: string
  cromwell:
    type: File
  wdl:
    type: File
  tmpl:
    type: File
outputs:
  hclog:
    type: File
    outputSource: HC/log
  outdir:
    type: Directory
    outputSource: mvOut/OutDir
steps:
  hapJson:
    run: hapJson.cwl
    in:
      bam: bam
      intervals: intervals
      tmpl: tmpl
    out:
    - json
  HC:
    run: HC.cwl
    in:
      cromwell: cromwell
      wdl: wdl
      json: hapJson/json
    out:
    - log
  mvOut:
    run: mvOut.cwl
    in:
      logFile: HC/log
    out:
    - OutDir
