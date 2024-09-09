cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- -e
- args <- commandArgs(TRUE); splitList <- function(s)as.list(unlist(strsplit(s, split
  = ','))); template <- args[1]; input1 <- jsonlite::fromJSON(template, simplifyVector=FALSE);
  input1$ConvertPairedFastQsToUnmappedBamWf.readgroup_name <- splitList(args[2]);
  input1$ConvertPairedFastQsToUnmappedBamWf.sample_name <- splitList(args[3]); input1$ConvertPairedFastQsToUnmappedBamWf.fastq_1
  <- splitList(args[4]); input1$ConvertPairedFastQsToUnmappedBamWf.fastq_2 <- splitList(args[5]);
  input1$ConvertPairedFastQsToUnmappedBamWf.ubam_list_name <- splitList(args[3])[[1]][1];
  input1$ConvertPairedFastQsToUnmappedBamWf.library_name <- splitList(args[6]); input1$ConvertPairedFastQsToUnmappedBamWf.platform_unit
  <- splitList(args[7]); input1$ConvertPairedFastQsToUnmappedBamWf.run_date <- list(rep(as.character(Sys.Date()),
  lengths(splitList(args[2])))); input1$ConvertPairedFastQsToUnmappedBamWf.platform_name
  <- splitList(args[8]); input1$ConvertPairedFastQsToUnmappedBamWf.sequencing_center
  <- splitList(args[9]); cat(jsonlite::toJSON(input1, pretty = TRUE, auto_unbox =
  T))
inputs:
  tmpl:
    type: File
    inputBinding:
      position: 1
      separate: true
  fastq1:
    type: string
    inputBinding:
      position: 4
      separate: true
  fastq2:
    type: string
    inputBinding:
      position: 5
      separate: true
  readGroup:
    type: string
    inputBinding:
      position: 2
      separate: true
  sampleName:
    type: string
    inputBinding:
      position: 3
      separate: true
  library:
    type: string
    inputBinding:
      position: 6
      separate: true
  platunit:
    type: string
    inputBinding:
      position: 7
      separate: true
  platform:
    type: string
    inputBinding:
      position: 8
      separate: true
  center:
    type: string
    inputBinding:
      position: 9
      separate: true
outputs:
  jsonOut:
    type: File
    outputBinding:
      glob: tmpl1.json
stdout: tmpl1.json
