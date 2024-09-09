cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- Rscript
- -e
- args <- commandArgs(TRUE); fqlog <- args[1]; tmpl <- args[2]; log1 <- readLines(fqlog);
  startn <- grep('Final Outputs:', log1)+1; endn <- grep('}$', log1)[1]; ubamOut <-
  jsonlite::fromJSON(log1[startn:endn]); sampleName <- sub('.list', '', basename(ubamOut$ConvertPairedFastQsToUnmappedBamWf.unmapped_bam_list));
  json1 <- jsonlite::fromJSON(tmpl); json1$PreProcessingForVariantDiscovery_GATK4.sample_name
  <- sampleName; json1$PreProcessingForVariantDiscovery_GATK4.flowcell_unmapped_bams_list
  <- ubamOut$ConvertPairedFastQsToUnmappedBamWf.unmapped_bam_list; cat(jsonlite::toJSON(json1,
  pretty = TRUE, auto_unbox = T))
inputs:
  fqlog:
    type: File
    inputBinding:
      position: 1
      separate: true
  template:
    type: File
    inputBinding:
      position: 2
      separate: true
outputs:
  json:
    type: File
    outputBinding:
      glob: temp2.json
stdout: temp2.json
