cwlVersion: v1.0
class: CommandLineTool
baseCommand: hisat2
requirements:
- class: DockerRequirement
  dockerPull: biocontainers/hisat2:v2.0.5-1-deb_cv1
- class: InlineJavascriptRequirement
inputs:
  threadN:
    type: int
    inputBinding:
      prefix: -p
      separate: true
  IndexPrefix:
    type: File
    secondaryFiles:
    - $(self.basename + '.1.ht2')
    - $(self.basename + '.2.ht2')
    - $(self.basename + '.3.ht2')
    - $(self.basename + '.4.ht2')
    - $(self.basename + '.5.ht2')
    - $(self.basename + '.6.ht2')
    - $(self.basename + '.7.ht2')
    - $(self.basename + '.8.ht2')
    inputBinding:
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
stdout: output.sam
