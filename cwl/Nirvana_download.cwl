cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- dotnet
- /opt/nirvana/Downloader.dll
requirements:
- class: DockerRequirement
  dockerPull: annotation/nirvana:3.14
arguments:
- -o
- ./
inputs:
  genome:
    type: string
    inputBinding:
      prefix: --ga
      separate: true
outputs:
  data:
    type: Directory[]
    outputBinding:
      glob: '*'
