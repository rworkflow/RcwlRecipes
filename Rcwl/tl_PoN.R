## CreateSomaticPanelOfNormals
p1 <- InputParam(id = "db", type = "Directory", prefix = "gendb://",
                 separate = F, position = 1)
p2 <- InputParam(id = "Ref", prefix = "-R", type = "File",
                 secondaryFiles = c(".fai", "^.dict"), position = 2)
p3 <- InputParam(id = "pon", prefix = "-O", type = "string", position = 3)
p4 <- InputParam(id = "gresource", type = "File?", prefix = "--germline-resource",
                 secondaryFiles = "$(self.nameext == '.gz' ? self.basename+'.tbi' : self.basename+'.idx')",
                 position = 4)

o1 <- OutputParam(id = "pout", type = "File", glob = "$(inputs.pon)",
                  secondaryFiles = ".idx")
req1 <- list(class = "DockerRequirement",
             dockerPull = "broadinstitute/gatk:latest")
## fix bug for lock files on POSIX filesystems
req2 <- list(class = "EnvVarRequirement",
             envDef = list("TILEDB_DISABLE_FILE_LOCKING" = "1"))
req3 <- requireJS()
PoN <- cwlProcess(baseCommand = c("gatk", "CreateSomaticPanelOfNormals"),
                  requirements = list(req1, req2, req3),
                  arguments = list("--min-sample-count", "1", "-V"),
                  inputs = InputParamList(p1, p2, p3, p4),
                  outputs = OutputParamList(o1))


PoN <- addMeta(
    PoN,
    label = "PoN",
    doc = "Create a panel of normals (PoN) containing germline and artifactual sites for use with Mutect2.",
    inputLabels = c("db","Ref","pon","gresource"),
    inputDocs = c("URI used to reference a GenomicsDB instance in GATK workflows.","Reference sequence Default value: null.","Output vcf Required.","Population vcf of germline sequencing containing allele fractions. Default value: null."),
    outputLabels = c("pout"),
    outputDocs = c("Panel of normal output"),
    extensions = list(
        author = "rworkflow team",
        date = "09-08-24",
        url = "https://github.com/broadinstitute/gatk",
        example = paste()
    )
)
