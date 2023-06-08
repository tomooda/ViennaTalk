Class {
	#name : #ViennaImportModuleSignatureNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaImportModuleSignatureNode >> formatWith: aViennaAbstractFormatter [

	| importSignatures |
	importSignatures := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter join: String cr withAll: importSignatures
]

{ #category : #testing }
ViennaImportModuleSignatureNode >> isViennaImportModuleSignatureNode [

	^ true
]

{ #category : #testing }
ViennaImportModuleSignatureNode >> label [

	^ 'ImportModuleSignature'
]
