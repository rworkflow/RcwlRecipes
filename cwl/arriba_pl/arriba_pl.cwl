cwlVersion: v1.0
class: Workflow
inputs:
  STAR_sjdbGTFfile:
    type: File
outputs:
  Fout:
    type: File
    outputSource: arriba/fout
  FOut:
    type: File
    outputSource: arriba/fOut
  bam:
    type: File
    outputSource: STAR/outBAM
steps:
  STAR:
    run: STAR.cwl
    out:
    - outBAM
  arriba:
    run: arriba.cwl
    in:
      align: STAR/outBAM
      gtf: STAR_sjdbGTFfile
    out:
    - fout
    - fOut
