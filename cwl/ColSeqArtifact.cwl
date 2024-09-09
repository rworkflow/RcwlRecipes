cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- gatk
- CollectSequencingArtifactMetrics
requirements:
- class: DockerRequirement
  dockerPull: broadinstitute/gatk:latest
inputs:
  bam:
    type: File
    inputBinding:
      prefix: -I
      separate: true
  ref:
    type: File
    inputBinding:
      prefix: -R
      separate: true
  ext:
    type: string
    inputBinding:
      prefix: --FILE_EXTENSION
      separate: true
    default: .txt
  art:
    type: string
    inputBinding:
      prefix: -O
      separate: true
outputs:
  aout:
    type: File
    outputBinding:
      glob: $(inputs.art).pre_adapter_detail_metrics.txt
