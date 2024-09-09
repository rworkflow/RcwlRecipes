cwlVersion: v1.0
class: CommandLineTool
baseCommand: vep
requirements:
- class: DockerRequirement
  dockerPull: hubentu/ensembl-vep-plugins
hints:
  cwltool:LoadListingRequirement:
    loadListing: no_listing
arguments:
- --format
- vcf
- --vcf
- --symbol
- --terms
- SO
- --tsl
- --hgvs
- --offline
- --dir_plugins
- /opt/vep/src/VEP_plugins
- --plugin
- Downstream
- --plugin
- Wildtype
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
outputs:
  oVcf:
    type: File
    outputBinding:
      glob: $(inputs.ovcf)
$namespaces:
  cwltool: http://commonwl.org/cwltool#
