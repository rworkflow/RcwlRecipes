cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- dotnet
- /opt/nirvana/Nirvana.dll
requirements:
- class: DockerRequirement
  dockerPull: annotation/nirvana:3.14
arguments:
- -c
- valueFrom: $(inputs.cache.path)/Both
inputs:
  cache:
    type: Directory
  sd:
    type: Directory
    inputBinding:
      prefix: --sd
      separate: true
  ref:
    type: File
    inputBinding:
      prefix: -r
      separate: true
  prefix:
    type: string
    inputBinding:
      prefix: -o
      separate: true
  vcf:
    type: File
    inputBinding:
      prefix: -i
      separate: true
outputs:
  out:
    type: File
    secondaryFiles: .jsi
    outputBinding:
      glob: $(inputs.prefix).json.gz
