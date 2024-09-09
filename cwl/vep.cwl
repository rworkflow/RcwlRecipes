cwlVersion: v1.0
class: CommandLineTool
baseCommand: vep
requirements:
- class: DockerRequirement
  dockerPull: ensemblorg/ensembl-vep
hints:
  cwltool:LoadListingRequirement:
    loadListing: no_listing
arguments:
- --format
- vcf
- --vcf
- --cache
- --symbol
- --offline
inputs:
  ivcf:
    type: File
    inputBinding:
      prefix: --input_file
      separate: true
  ovcf:
    type: string
    inputBinding:
      prefix: --output_file
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: --fasta
      separate: true
  cacheDir:
    type: Directory
    inputBinding:
      prefix: --dir_cache
      separate: true
  version:
    type: string
    inputBinding:
      prefix: --cache_version
      separate: true
  merged:
    type: boolean?
    inputBinding:
      prefix: --merged
      separate: true
  species:
    type: string?
    inputBinding:
      prefix: --species
      separate: true
outputs:
  oVcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
$namespaces:
  cwltool: http://commonwl.org/cwltool#
