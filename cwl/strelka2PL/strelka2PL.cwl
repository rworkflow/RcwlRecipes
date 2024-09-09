cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
inputs:
  tbam:
    type: File
    secondaryFiles: .bai
  nbam:
    type: File
    secondaryFiles: .bai
  ref:
    type: File
    secondaryFiles: .fai
  region:
    type: File?
    secondaryFiles: .tbi
  exome:
    type: boolean
    default: true
outputs:
  snvs:
    type: File
    outputSource: strelkaSNV/Fout
  indels:
    type: File
    outputSource: strelkaIndel/Fout
steps:
  manta:
    run: manta.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: ref
      callRegions: region
      exome: exome
    out:
    - somaticSV
    - diploidSV
    - candidateSV
    - candidateSmallIndels
  strelka:
    run: strelka.cwl
    in:
      tbam: tbam
      nbam: nbam
      ref: ref
      callRegions: region
      indelCandidates: manta/candidateSmallIndels
      exome: exome
    out:
    - snvs
    - indels
  strelkaSNV:
    run: strelkaSNV.cwl
    in:
      vcf: strelka/snvs
      filter:
        valueFrom: PASS
      fout:
        source: tbam
        valueFrom: $(self.nameroot)_strelka2.somatic.snvs.vcf
    out:
    - Fout
  strelkaIndel:
    run: strelkaIndel.cwl
    in:
      vcf: strelka/indels
      filter:
        valueFrom: PASS
      fout:
        source: tbam
        valueFrom: $(self.nameroot)_strelka2.somatic.indels.vcf
    out:
    - Fout
