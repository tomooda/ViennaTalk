Class {
	#name : #ViennaImportModuleSignatureAllNode,
	#superclass : #ViennaImportComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaImportModuleSignatureAllNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaImportModuleSignatureAllNode >> formatWith: aViennaAbstractFormatter [

	^ 'all'
]

{ #category : #testing }
ViennaImportModuleSignatureAllNode >> isViennaImportModuleSignatureAllNode [

	^ true
]

{ #category : #testing }
ViennaImportModuleSignatureAllNode >> label [

	^ 'ImportModuleSignatureAll'
]
