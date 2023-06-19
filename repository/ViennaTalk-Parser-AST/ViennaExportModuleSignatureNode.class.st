Class {
	#name : #ViennaExportModuleSignatureNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaExportModuleSignatureNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #'pretty printing' }
ViennaExportModuleSignatureNode >> formatWith: aViennaAbstractFormatter [

	| exportSignatures |
	exportSignatures := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter join: String cr withAll: exportSignatures
]

{ #category : #testing }
ViennaExportModuleSignatureNode >> isViennaExportModuleSignatureNode [

	^ true
]

{ #category : #accessing }
ViennaExportModuleSignatureNode >> label [

	^ 'ExportModuleSignature'
]
