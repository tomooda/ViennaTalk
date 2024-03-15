Class {
	#name : #ViennaExportDefinitionNode,
	#superclass : #ViennaExportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'formatting-interfaces' }
ViennaExportDefinitionNode class >> all [

	^ self exportModuleSignature:
		  ViennaExportModuleSignatureAllNode empty
]

{ #category : #'formatting-interfaces' }
ViennaExportDefinitionNode class >> exportModuleSignature: aViennaExportModuleSignature [

	^ (self new: 1)
		  exportModuleSignature: aViennaExportModuleSignature;
		  yourself
]

{ #category : #private }
ViennaExportDefinitionNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #accessing }
ViennaExportDefinitionNode >> exportModuleSignature [

	^ self at: 1
]

{ #category : #accessing }
ViennaExportDefinitionNode >> exportModuleSignature: aViennaExportModuleSignature [

	self at: 1 put: aViennaExportModuleSignature
]

{ #category : #enumerating }
ViennaExportDefinitionNode >> exportedIdentifiersDo: aBlock [

	self exportModuleSignature exportedIdentifiersDo: aBlock
]

{ #category : #accessing }
ViennaExportDefinitionNode >> exportsIdentifier: aString [

	^ self exportModuleSignature exportsIdentifier: aString
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

{ #category : #typechecking }
ViennaExportDefinitionNode >> maximalType [

	^ self exportModuleSignature typecheck
]

{ #category : #removing }
ViennaExportDefinitionNode >> removeIdentifier: aString [

	self exportModuleSignature removeIdentifier: aString
]
