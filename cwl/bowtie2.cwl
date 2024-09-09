cwlVersion: v1.0
class: CommandLineTool
baseCommand: bowtie2
requirements:
- class: InlineJavascriptRequirement
- class: DockerRequirement
  dockerPull: biocontainers/bowtie2:v2.2.9_cv2
arguments:
- -S
- output.sam
inputs:
  threadN:
    type: int
    inputBinding:
      prefix: -p
      separate: true
  IndexPrefix:
    type: File
    secondaryFiles:
    - $(self.basename + '.1.bt2')
    - $(self.basename + '.2.bt2')
    - $(self.basename + '.3.bt2')
    - $(self.basename + '.4.bt2')
    - $(self.basename + '.rev.1.bt2')
    - $(self.basename + '.rev.2.bt2')
    inputBinding:
      position: 2
      prefix: -x
      separate: true
      valueFrom: $(self.dirname + '/' + self.basename)
  fq1:
    type: File
    inputBinding:
      prefix: '-1'
      separate: true
  fq2:
    type: File
    inputBinding:
      prefix: '-2'
      separate: true
outputs:
  sam:
    type: File
    outputBinding:
      glob: '*.sam'
