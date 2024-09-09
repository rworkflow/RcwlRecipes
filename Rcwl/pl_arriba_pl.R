#' @include tl_STAR.R
arguments(STAR) <- list("--outFilterMultimapNmax 50",
"--peOverlapNbasesMin 10",
"--alignSplicedMateMapLminOverLmate 0.5",
"--alignSJstitchMismatchNmax 5 -1 5 5",
"--chimSegmentMin 10",
"--chimOutType WithinBAM HardClip",
"--chimJunctionOverhangMin 10",
"--chimScoreDropMax 30",
"--chimScoreJunctionNonGTAG 0",
"--chimScoreSeparation 1",
"--chimSegmentReadGapMax 3",
"--chimMultimapNmax 50",
"--outSAMtype BAM Unsorted",
"--outSAMunmapped Within",
"--outBAMcompression 0 ")
STAR@outputs <- OutputParamList(STAR@outputs[[1]])

#' @include tl_arriba.R
s1 <- cwlStep(id = "STAR", run = STAR)
s2 <- cwlStep(id = "arriba", run = arriba,
              In = list(align = "STAR/outBAM",
                        gtf = "STAR_sjdbGTFfile"))

o1 <- OutputParam(id = "Fout", type = "File", outputSource = "arriba/fout")
o2 <- OutputParam(id = "FOut", type = "File", outputSource = "arriba/fOut")
o3 <- OutputParam(id = "bam", type = "File", outputSource = "STAR/outBAM")

arriba_pl <- cwlWorkflow(inputs = stepInputs(list(s1, s2)),
                         outputs = OutputParamList(o1, o2, o3))
arriba_pl <- arriba_pl + s1 + s2
