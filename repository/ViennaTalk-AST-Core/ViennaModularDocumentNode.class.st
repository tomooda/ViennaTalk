Class {
	#name : 'ViennaModularDocumentNode',
	#superclass : 'ViennaDocumentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing-definitions' }
ViennaModularDocumentNode >> deepFindResolverForIdentifier: aString [

	^ nil
]

{ #category : 'accessing-definitions' }
ViennaModularDocumentNode >> findResolverForIdentifier: aString [

	^ nil
]

{ #category : 'testing' }
ViennaModularDocumentNode >> isViennaModularDocumentNode [

	^ true
]

{ #category : 'typechecking' }
ViennaModularDocumentNode >> maximalType [

	self modulesDo: #typecheck.
	^ ViennaType unit
]

{ #category : 'accessing' }
ViennaModularDocumentNode >> moduleNames [

	^ self collect: #identifier
]

{ #category : 'accessing' }
ViennaModularDocumentNode >> modules [

	^ self asArray
]

{ #category : 'accessing' }
ViennaModularDocumentNode >> modulesDo: aBlock [

	self do: aBlock
]
