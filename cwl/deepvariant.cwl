cwlVersion: v1.0
class: CommandLineTool
baseCommand: /opt/deepvariant/bin/run_deepvariant
requirements:
- class: DockerRequirement
  dockerPull: google/deepvariant
inputs:
  bam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: --reads=
      separate: false
  model:
    type: string
    inputBinding:
      prefix: --model_type=
      separate: false
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: --ref=
      separate: false
  regions:
    type:
    - File?
    - string?
    inputBinding:
      prefix: --regions
      separate: true
  outVcf:
    type: string
    inputBinding:
      prefix: --output_vcf=
      separate: false
  outGVcf:
    type: string?
    inputBinding:
      prefix: --output_gvcf=
      separate: false
  intermediate:
    type: string?
    inputBinding:
      prefix: --intermediate_results_dir
      separate: true
  cores:
    type: int?
    inputBinding:
      prefix: --num_shards=
      separate: false
outputs:
  vcf:
    type: File
    secondaryFiles: .tbi
    outputBinding:
      glob: $(inputs.outVcf)
  gvcf:
    type: File?
    secondaryFiles: .tbi
    outputBinding:
      glob: $(inputs.outGVcf)
  report:
    type: File
    outputBinding:
      glob: '*.html'
  intdir:
    type: Directory?
    outputBinding:
      glob: $(inputs.intermediate)
