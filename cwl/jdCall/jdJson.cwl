cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- -e
- args <- commandArgs(TRUE);splitList <- function(s)as.list(unlist(strsplit(s, split
  = ',')));sampleName <- args[1];gvcf <- args[2];callsetName <- args[3];intervals
  <- args[4];unpadded_intervals <- args[5];tmpl4 <- args[6];json1 <- jsonlite::fromJSON(tmpl4,
  simplifyVector=FALSE);json1$JointGenotyping.sample_names <- splitList(sampleName);json1$JointGenotyping.input_gvcfs
  <- splitList(gvcf);json1$JointGenotyping.input_gvcfs_indices <- splitList(gsub('gz',
  'gz.tbi', gvcf));json1$JointGenotyping.callset_name <- callsetName;json1$JointGenotyping.eval_interval_list
  <- intervals;json1$JointGenotyping.unpadded_intervals_file <- unpadded_intervals;cat(jsonlite::toJSON(json1,
  pretty = TRUE, auto_unbox = T))
inputs:
  sampleName:
    type: string
    inputBinding:
      position: 1
      separate: true
  gvcf:
    type: string
    inputBinding:
      position: 2
      separate: true
  callsetName:
    type: string
    inputBinding:
      position: 3
      separate: true
  intervals:
    type: string
    inputBinding:
      position: 4
      separate: true
  unpadded_intervals:
    type: string
    inputBinding:
      position: 5
      separate: true
  tmpl:
    type: File
    inputBinding:
      position: 6
      separate: true
outputs:
  json:
    type: File
    outputBinding:
      glob: tmpl4.json
stdout: tmpl4.json
