cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- lofreq
- somatic
requirements:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/lofreq:2.1.5--py37h916d2e8_4
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -t
      separate: true
  nbam:
    type: File
    secondaryFiles: .bai
    inputBinding:
      prefix: -n
      separate: true
  ref:
    type: File
    secondaryFiles: .fai
    inputBinding:
      prefix: -f
      separate: true
  region:
    type: File
    inputBinding:
      prefix: -l
      separate: true
  dbsnp:
    type: File
    secondaryFiles: .tbi
    inputBinding:
      prefix: -d
      separate: true
  out:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  threads:
    type: int
    inputBinding:
      prefix: --threads
      separate: true
outputs:
  snp:
    type: File
    secondaryFiles: .tbi
    outputBinding:
      glob: $(inputs.out)somatic_final.snvs.vcf.gz
  snpdb:
    type: File
    secondaryFiles: .tbi
    outputBinding:
      glob: $(inputs.out)somatic_final_minus-dbsnp.snvs.vcf.gz
  indel:
    type: File
    secondaryFiles: .tbi
    outputBinding:
      glob: $(inputs.out)somatic_final.indels.vcf.gz
  indeldb:
    type: File
    secondaryFiles: .tbi
    outputBinding:
      glob: $(inputs.out)somatic_final_minus-dbsnp.indels.vcf.gz
