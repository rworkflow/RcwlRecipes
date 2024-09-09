cwlVersion: v1.0
class: CommandLineTool
baseCommand: table_annovar.pl
requirements:
- class: InlineJavascriptRequirement
- class: DockerRequirement
  dockerPull: bioinfochrustrasbourg/annovar
arguments:
- -vcfinput
inputs:
  vcf:
    type: File
    inputBinding:
      position: 1
      separate: true
  db:
    type: Directory
    inputBinding:
      position: 2
      separate: true
  build:
    type: string
    inputBinding:
      prefix: -buildver
      separate: true
    default: hg19
  aout:
    type: string
    inputBinding:
      prefix: -out
      separate: true
  protocol:
    type: string
    inputBinding:
      prefix: -protocol
      separate: true
    default: refGene,cosmic70
  operation:
    type: string
    inputBinding:
      prefix: -operation
      separate: true
    default: g,f
  nastring:
    type: string
    inputBinding:
      prefix: -nastring
      separate: true
    default: '.'
outputs:
  Aout:
    type: File
    secondaryFiles: $(inputs.aout).$(inputs.build)_multianno.txt
    outputBinding:
      glob: $(inputs.aout).$(inputs.build)_multianno.vcf
