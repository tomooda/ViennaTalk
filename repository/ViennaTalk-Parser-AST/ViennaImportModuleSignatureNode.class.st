Class {
	#name : #ViennaImportModuleSignatureNode,
	#superclass : #ViennaImportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaImportModuleSignatureNode >> boundIdentifiersDo: aBlock [

	self do: [ :importSignature |
		importSignature boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaImportModuleSignatureNode >> formatWith: aViennaAbstractFormatter [

	| importSignatures |
	importSignatures := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter join: String cr withAll: importSignatures
]

{ #category : #enumerating }
ViennaImportModuleSignatureNode >> importsDo: aBlock [

	self do: [ :importSignature | importSignature importsDo: aBlock ]
]

{ #category : #testing }
ViennaImportModuleSignatureNode >> isViennaImportModuleSignatureNode [

	^ true
]

{ #category : #testing }
ViennaImportModuleSignatureNode >> label [

	^ 'ImportModuleSignature'
]

{ #category : #accessing }
ViennaImportModuleSignatureNode >> moduleIdentifier [

	^ parent ifNotNil: #moduleIdentifier
]
