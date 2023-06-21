Class {
	#name : #ViennaModularDocumentNode,
	#superclass : #ViennaDocumentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'accessing-definitions' }
ViennaModularDocumentNode >> deepResolveIdentifier: aString [

	^ nil
]

{ #category : #testing }
ViennaModularDocumentNode >> isViennaModularDocumnetNode [

	^ true
]

{ #category : #'accessing-definitions' }
ViennaModularDocumentNode >> resolveIdentifier: aString [

	^ nil
]
