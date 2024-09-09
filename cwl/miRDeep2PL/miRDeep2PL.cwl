cwlVersion: v1.0
class: Workflow
requirements:
- class: StepInputExpressionRequirement
- class: InlineJavascriptRequirement
inputs:
  reads:
    type: File
  format:
    type: string
    default: -c
  adapter:
    type: string
  len:
    type: int
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
  miRef:
    type:
    - File
    - string
  miOther:
    type:
    - File
    - string
  precursors:
    type:
    - File
    - string
  species:
    type: string
outputs:
  csvfiles:
    type: File[]
    outputSource: miRDeep2/csvfiles
  htmls:
    type: File[]
    outputSource: miRDeep2/htmls
  bed:
    type: File
    outputSource: miRDeep2/bed
  expression:
    type: Directory
    outputSource: miRDeep2/expression
  mirna_results:
    type: Directory
    outputSource: miRDeep2/mirna_results
  pdfs:
    type: Directory
    outputSource: miRDeep2/pdfs
  preads:
    type: File
    outputSource: Mapper/pReads
  arf:
    type: File
    outputSource: Mapper/Arf
steps:
  Mapper:
    run: Mapper.cwl
    in:
      reads: reads
      format: format
      adapter: adapter
      genome: genome
      len: len
      preads:
        valueFrom: $(inputs.reads.nameroot)_collapsed.fa
      arf:
        valueFrom: $(inputs.reads.nameroot)_collapsed.arf
    out:
    - pReads
    - Arf
  miRDeep2:
    run: miRDeep2.cwl
    in:
      reads: Mapper/pReads
      genome: genome
      mappings: Mapper/Arf
      miRef: miRef
      miOther: miOther
      precursors: precursors
      species: species
    out:
    - csvfiles
    - htmls
    - bed
    - expression
    - mirna_results
    - pdfs
