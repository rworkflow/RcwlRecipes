cwlVersion: v1.0
class: CommandLineTool
baseCommand: /software/SVE/scripts/variant_processor.py
requirements:
- class: DockerRequirement
  dockerPull: timothyjamesbecker/sve
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -b
      separate: true
  ref:
    type: File
    secondaryFiles:
    - .fai
    - $(self.nameroot).dict
    inputBinding:
      prefix: -r
      separate: true
  outdir:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  tools:
    type: string
    inputBinding:
      prefix: -s
      separate: true
    default: breakdancer,cnmops,gatk_haplo,delly,lumpy,cnvnator,breakseq,tigra,genome_strip,hydra
outputs:
  outs:
    type: Directory
    outputBinding:
      glob: $(inputs.outdir)
