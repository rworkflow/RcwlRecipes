cwlVersion: v1.0
class: Workflow
inputs:
  fastq1:
    type: string
  fastq2:
    type: string
  readGroup:
    type: string
  sampleName:
    type: string
  library:
    type: string
  platunit:
    type: string
  platform:
    type: string
  center:
    type: string
  tmpl1:
    type: File
  wdl1:
    type: File
  tmpl2:
    type: File
  wdl2:
    type: File
  cromwell:
    type: File
outputs:
  bamlog:
    type: File
    outputSource: align/log
  outdir:
    type: Directory
    outputSource: mvOut/OutDir
steps:
  fqJson:
    run: fqJson.cwl
    in:
      tmpl: tmpl1
      fastq1: fastq1
      fastq2: fastq2
      readGroup: readGroup
      sampleName: sampleName
      library: library
      platunit: platunit
      platform: platform
      center: center
    out:
    - jsonOut
  fq2ubam:
    run: fq2ubam.cwl
    in:
      cromwell: cromwell
      wdl: wdl1
      json: fqJson/jsonOut
    out:
    - log
  ubam2bamJson:
    run: ubam2bamJson.cwl
    in:
      fqlog: fq2ubam/log
      template: tmpl2
    out:
    - json
  align:
    run: align.cwl
    in:
      cromwell: cromwell
      wdl: wdl2
      json: ubam2bamJson/json
    out:
    - log
  mvOut:
    run: mvOut.cwl
    in:
      logFile: align/log
    out:
    - OutDir
