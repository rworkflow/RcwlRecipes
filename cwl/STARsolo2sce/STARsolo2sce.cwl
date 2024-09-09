cwlVersion: v1.0
class: Workflow
inputs:
  fastq_cdna:
    type: File[]
  fastq_cb:
    type: File[]
  genomeDir:
    type: Directory
  whiteList:
    type: File
  runThreadN:
    type: int
  soloCellFilter:
    type: string
outputs:
  sam:
    type: File
    outputSource: STARsolo/outAlign
  Solo:
    type: Directory
    outputSource: STARsolo/Solo
  sce:
    type: File
    outputSource: counts2sce/outsce
steps:
  STARsolo:
    run: STARsolo.cwl
    in:
      readFilesIn_cdna: fastq_cdna
      readFilesIn_cb: fastq_cb
      genomeDir: genomeDir
      whiteList: whiteList
      soloCellFilter: soloCellFilter
      runThreadN: runThreadN
    out:
    - outAlign
    - outLog
    - SJ
    - Solo
  counts2sce:
    run: counts2sce.cwl
    in:
      dirname: STARsolo/Solo
    out:
    - outsce
