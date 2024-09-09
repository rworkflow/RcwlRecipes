cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- -e
- args <- commandArgs(TRUE);bam <- args[1];intervals <- args[2];tmpl3 <- args[3];json1
  <- jsonlite::fromJSON(tmpl3);json1$HaplotypeCallerGvcf_GATK4.input_bam <- bam;json1$HaplotypeCallerGvcf_GATK4.input_bam_index
  <- sub('.bam', '.bai', bam);json1$HaplotypeCallerGvcf_GATK4.scattered_calling_intervals_list
  <- intervals;cat(jsonlite::toJSON(json1, pretty = TRUE, auto_unbox = T))
inputs:
  bam:
    type: string
    inputBinding:
      separate: true
  intervals:
    type: string
    inputBinding:
      separate: true
  tmpl:
    type: File
    inputBinding:
      separate: true
outputs:
  json:
    type: File
    outputBinding:
      glob: tmpl3.json
stdout: tmpl3.json
