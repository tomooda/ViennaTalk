Class {
	#name : #ViennaImportModuleSignatureNode,
	#superclass : #ViennaImportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
	^ aViennaAbstractFormatter
		  join: aViennaAbstractFormatter cr
		  withAll: importSignatures
]

{ #category : #accessing }
ViennaImportModuleSignatureNode >> importSignatures [

	^ self asArray
]

{ #category : #enumerating }
ViennaImportModuleSignatureNode >> importSignaturesDo: aBlock [

	self do: aBlock
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

{ #category : #typechecking }
ViennaImportModuleSignatureNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]

{ #category : #accessing }
ViennaImportModuleSignatureNode >> moduleIdentifier [

	^ parent ifNotNil: #moduleIdentifier
]
