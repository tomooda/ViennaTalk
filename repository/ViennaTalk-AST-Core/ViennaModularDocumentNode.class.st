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

{ #category : 'accessing' }
ViennaModularDocumentNode >> ensureModuleNamed: aString [

	^ (self moduleNamed: aString) ifNil: [
		  self add: (ViennaModuleNode identifier: aString) ]
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

{ #category : 'enumerating' }
ViennaModularDocumentNode >> modulesDo: aBlock [

	self do: aBlock
]

{ #category : 'enumerating' }
ViennaModularDocumentNode >> namedTracesDo: aBlock [

	self modulesDo: [ :module | module namedTracesDo: aBlock ]
]

{ #category : 'enumerating' }
ViennaModularDocumentNode >> testModulesDo: aBlock [

	self modulesDo: [ :module |
		(module identifier endsWith: 'Test') ifTrue: [ aBlock value: module ] ]
]

{ #category : 'enumerating' }
ViennaModularDocumentNode >> testOperationsDo: aBlock [

	self testModulesDo: [ :module | module testOperationsDo: aBlock ]
]

{ #category : 'enumerating' }
ViennaModularDocumentNode >> toplevelDefinitionsDo: aBlock [

	self modulesDo: [ :moduleNode |
		moduleNode toplevelDefinitionsDo: aBlock ]
]
