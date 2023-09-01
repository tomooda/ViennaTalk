Class {
	#name : #ViennaModularDocumentNode,
	#superclass : #ViennaDocumentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'accessing-definitions' }
ViennaModularDocumentNode >> deepFindResolverForIdentifier: aString [

	^ nil
]

{ #category : #'accessing-definitions' }
ViennaModularDocumentNode >> findResolverForIdentifier: aString [

	^ nil
]

{ #category : #testing }
ViennaModularDocumentNode >> isViennaModularDocumentNode [

	^ true
]

{ #category : #accessing }
ViennaModularDocumentNode >> modules [

	^ self asArray
]

{ #category : #accessing }
ViennaModularDocumentNode >> modulesDo: aBlock [

	self do: aBlock
]
