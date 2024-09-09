cwlVersion: v1.0
class: Workflow
requirements:
- class: MultipleInputFeatureRequirement
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
inputs:
  quant:
    type: File[]
  qcolumn:
    type: string
    default: TPM
  qcnames:
    type: string
  gtf:
    type: File
  group1:
    type: string
  group2:
    type: string
  method:
    type: string
    default: empirical
outputs:
  res:
    type: File[]
    outputSource: diffSplice/outFile
steps:
  quantMerge:
    run: quantMerge.cwl
    in:
      files: quant
      columns: qcolumn
      cnames: qcnames
      outfile:
        valueFrom: iso_tpm.txt
    out:
    - outFile
  genEvents:
    run: genEvents.cwl
    in:
      gtf: gtf
      outfile:
        valueFrom: events
    out:
    - outGTF
    - outIOE
  mergeEvents:
    run: mergeEvents.cwl
    in:
      files: genEvents/outIOE
      outfile:
        valueFrom: merged.ioe
    out:
    - out
  psiPerEvent:
    run: psiPerEvent.cwl
    in:
      ioe: mergeEvents/out
      exp: quantMerge/outFile
      outfile:
        valueFrom: events
    out:
    - outFile
  splitEventsG1:
    run: splitEventsG1.cwl
    in:
      files:
        source:
        - psiPerEvent/outFile
        linkMerge: merge_flattened
      outfile:
        valueFrom: group1.psi
      columns: group1
    out:
    - outFile
  splitEventsG2:
    run: splitEventsG2.cwl
    in:
      files:
        source:
        - psiPerEvent/outFile
        linkMerge: merge_flattened
      outfile:
        valueFrom: group2.psi
      columns: group2
    out:
    - outFile
  splitExpG1:
    run: splitExpG1.cwl
    in:
      files:
        source:
        - quantMerge/outFile
        linkMerge: merge_flattened
      outfile:
        valueFrom: group1.tpm
      columns: group1
    out:
    - outFile
  splitExpG2:
    run: splitExpG2.cwl
    in:
      files:
        source:
        - quantMerge/outFile
        linkMerge: merge_flattened
      outfile:
        valueFrom: group2.tpm
      columns: group2
    out:
    - outFile
  diffSplice:
    run: diffSplice.cwl
    in:
      iox: mergeEvents/out
      method: method
      psi:
        source:
        - splitEventsG1/outFile
        - splitEventsG2/outFile
        linkMerge: merge_flattened
      exp:
        source:
        - splitExpG1/outFile
        - splitExpG2/outFile
        linkMerge: merge_flattened
      output:
        valueFrom: diffSplice
    out:
    - outFile
