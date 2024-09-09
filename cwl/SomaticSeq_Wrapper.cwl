cwlVersion: v1.0
class: CommandLineTool
baseCommand: /opt/somaticseq/SomaticSeq.Wrapper.sh
requirements:
- class: DockerRequirement
  dockerPull: lethalfang/somaticseq:2.7.2
arguments:
- --output-dir
- '.'
- --gatk
- /opt/GATK/GenomeAnalysisTK.jar
inputs:
  ref:
    type: File
    secondaryFiles:
    - .fai
    - ^.dict
    inputBinding:
      prefix: --genome-reference
      separate: true
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: --tumor-bam
      separate: true
  nbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: --normal-bam
      separate: true
  mutect2:
    type: File?
    inputBinding:
      prefix: --mutect2
      separate: true
  varscanSnv:
    type: File?
    inputBinding:
      prefix: --varscan-snv
      separate: true
  varscanIndel:
    type: File?
    inputBinding:
      prefix: --varscan-indel
      separate: true
  sniper:
    type: File?
    inputBinding:
      prefix: --sniper
      separate: true
  vardict:
    type: File?
    inputBinding:
      prefix: --vardict
      separate: true
  muse:
    type: File?
    inputBinding:
      prefix: --muse
      separate: true
  strelkaSnv:
    type: File?
    inputBinding:
      prefix: --strelka-snv
      separate: true
  strelkaIndel:
    type: File?
    inputBinding:
      prefix: --strelka-indel
      separate: true
  lofreqSnv:
    type: File?
    inputBinding:
      prefix: --lofreq-snv
      separate: true
  lofreqIndel:
    type: File?
    inputBinding:
      prefix: --lofreq-indel
      separate: true
  region:
    type: File?
    inputBinding:
      prefix: --inclusion-region
      separate: true
  dbsnp:
    type: File
    secondaryFiles: '$(self.nameext == ''.gz'' ? self.basename+''.tbi'' : self.basename+''.idx'')'
    inputBinding:
      prefix: --dbsnp
      separate: true
outputs:
  conSNV:
    type: File
    outputBinding:
      glob: Consensus.sSNV.vcf
  conINDEL:
    type: File
    outputBinding:
      glob: Consensus.sINDEL.vcf
  EnsSNV:
    type: File
    outputBinding:
      glob: Ensemble.sSNV.tsv
  EnsINDEL:
    type: File
    outputBinding:
      glob: Ensemble.sINDEL.tsv
