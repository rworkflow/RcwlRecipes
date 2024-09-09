## https://github.com/mskilab-org/JaBbA

p1 <- InputParam(id = "junction", type = "File", position = 1)
p2 <- InputParam(id = "coverage", type = "File", position = 2)
p3 <- InputParam(id = "gurobi", type = "string?",
                 prefix = "--gurobi", position = 3, default="TRUE")
p4 <- InputParam(id = "slack", type = "int?",
                 prefix = "--slack", position  = 4)
p5 <- InputParam(id = "license", type = "File", position = -1)
o1 <- OutputParam(id = "gg", type = "File", glob = "jabba.simple.gg.rds")
o2 <- OutputParam(id = "plot", type = "File", glob = "karyograph.rds.ppfit.png")
o3 <- OutputParam(id = "seg", type = "File", glob = "jabba.seg")
o4 <- OutputParam(id = "report", type = "File", glob = "opt.report.rds")
req1 <- requireDocker("hubentu/jabba")
req2 <- requireEnvVar(list(
    GRB_LICENSE_FILE="$(inputs.license.path)"))
req3 <- requireJS()
jabba <- cwlProcess(baseCommand = "jba",
                    requirements = list(req1, req2, req3),
                    inputs = InputParamList(p1, p2, p3, p4, p5),
                    outputs = OutputParamList(o1, o2, o3, o4))


jabba <- addMeta(
    jabba,
    label = "jabba",
    doc = "JaBbA builds a genome graph based on junctions and read depth from whole genome sequencing, inferring optimal copy numbers for both vertices (DNA segments) and edges (bonds between segments). It can be used for discovering various patterns of structural variations.",
    inputLabels = c("junction","coverage","gurobi","slack","license"),
    inputDocs = c("BND style vcf, bedpe, rds of GrangesList",".wig, .bw, .bedgraph, .bed., .rds of a granges, or .tsv .csv /.txt file that is coercible to a GRanges use --field=FIELD argument so specify which column to use if specific meta field of a multi-column table","use gurobi optimizer instead of CPLEX?","Slack penalty to apply per loose end","license"),
    outputLabels = c("gg","plot","seg","report"),
    outputDocs = c("The out put genome graph with integer copy numbers.","plot illustrates the distribution of the raw segmental mean of the coverage signal, with red dashed vertical lines indicating the grid of integer copy number states","SEG format file of the final segmental copy numbers, compatible with IGV/ABSOLUTE/GISTIC and many more.","This file contains an R data.table object of the convergence statistics of all the sub-problems (identified by 'cl' column)."),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/mskilab-org/JaBbA",
        example = paste()
    )
)
