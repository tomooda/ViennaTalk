Class {
	#name : #ViennaFlatDocumentNode,
	#superclass : #ViennaDocumentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> deepFindResolverForIdentifier: aString [

	^ self findResolverForIdentifier: aString
]

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> findResolverForIdentifier: aString [

	^ (self lookupIdentifier: aString) ifNotNil: [ self ]
]

{ #category : #testing }
ViennaFlatDocumentNode >> isViennaFlatDocumnetNode [

	^ true
]

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> lookupIdentifier: aString [

	self toplevelDefinitionsDo: [ :definition |
		(definition bindsIdentifier: aString) ifTrue: [ ^ definition ] ].
	^ nil
]

{ #category : #enumerating }
ViennaFlatDocumentNode >> sectionsDo: aBlock [

	self do: [ :definitionBlock |
		aBlock value: definitionBlock definition ]
]

{ #category : #enumerating }
ViennaFlatDocumentNode >> toplevelDefinitionsDo: aBlock [

	self sectionsDo: [ :section |
		section isViennaStateDefinitionNode
			ifTrue: [ aBlock value: section ]
			ifFalse: [ section do: aBlock ] ]
]
