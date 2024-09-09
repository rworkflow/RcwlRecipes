cwlVersion: v1.0
class: CommandLineTool
baseCommand: mapper.pl
requirements:
- class: DockerRequirement
  dockerPull: hubentu/mirdeep2
- class: InlineJavascriptRequirement
arguments:
- valueFrom: -j
  position: 8
- valueFrom: -m
  position: 9
inputs:
  reads:
    type: File
    inputBinding:
      position: 1
      separate: true
  format:
    type: string
    inputBinding:
      position: 2
      separate: true
    default: -c
  adapter:
    type: string
    inputBinding:
      position: 3
      prefix: -k
      separate: true
  len:
    type: int
    inputBinding:
      position: 4
      prefix: -l
      separate: true
    default: 18
  genome:
    type: File
    secondaryFiles:
    - $(self.nameroot + '.1.ebwt')
    - $(self.nameroot + '.2.ebwt')
    - $(self.nameroot + '.3.ebwt')
    - $(self.nameroot + '.4.ebwt')
    - $(self.nameroot + '.rev.1.ebwt')
    - $(self.nameroot + '.rev.2.ebwt')
    inputBinding:
      position: 5
      prefix: -p
      separate: true
      valueFrom: $(self.dirname + '/' + self.nameroot)
  preads:
    type: string
    inputBinding:
      position: 6
      prefix: -s
      separate: true
  arf:
    type: string
    inputBinding:
      position: 7
      prefix: -t
      separate: true
outputs:
  pReads:
    type: File
    outputBinding:
      glob: $(inputs.preads)
  Arf:
    type: File
    outputBinding:
      glob: $(inputs.arf)
