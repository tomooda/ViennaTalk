Class {
	#name : #ViennaExportDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'formatting-interfaces' }
ViennaExportDefinitionNode class >> exportModuleSignature: aViennaExportModuleSignature [

	^ (self new: 1)
		  exportModuleSignature: aViennaExportModuleSignature;
		  yourself
]

{ #category : #accessing }
ViennaExportDefinitionNode >> exportModuleSignature [

	^ self at: 1
]

{ #category : #accessing }
ViennaExportDefinitionNode >> exportModuleSignature: aViennaExportModuleSignature [

	self at: 1 put: aViennaExportModuleSignature
]

{ #category : #'pretty printing' }
ViennaExportDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| exportSig |
	exportSig := aViennaAbstractFormatter format:
		             self exportModuleSignature.
	^ aViennaAbstractFormatter
		  indentString: 'exports'
		  insertCrIfNeeded: exportSig
]

{ #category : #testing }
ViennaExportDefinitionNode >> isViennaExportDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaExportDefinitionNode >> label [

	^ 'ExportDefinition'
]
