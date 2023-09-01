Class {
	#name : #ViennaFlatDocumentNode,
	#superclass : #ViennaDocumentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> addFunctionDefinition: aViennaNode [

	(self detect: #isViennaFunctionDefinitionsNode ifNone: [
		 | section |
		 section := ViennaFunctionDefinitionsNode empty.
		 self add: section.
		 section ]) add: aViennaNode
]

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> addOperationDefinition: aViennaNode [

	(self detect: #isViennaOperationDefinitionsNode ifNone: [
		 | section |
		 section := ViennaOperationDefinitionsNode empty.
		 self add: section.
		 section ]) add: aViennaNode
]

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> addTypeDefinition: aViennaNode [

	(self detect: #isViennaTypeDefinitionsNode ifNone: [
		 | section |
		 section := ViennaTypeDefinitionsNode empty.
		 self add: section.
		 section ]) add: aViennaNode
]

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> addValueDefinition: aViennaNode [

	(self detect: #isViennaValueDefinitionsNode ifNone: [
		 | section |
		 section := ViennaValueDefinitionsNode empty.
		 self add: section.
		 section ]) add: aViennaNode
]

{ #category : #converting }
ViennaFlatDocumentNode >> asModularDocument [

	^ ViennaModularDocumentNode withAll: (ViennaModuleNode
			   identifier: 'DEFAULT'
			   moduleBody:
			   (ViennaModuleBodyNode withAll: (self collect: #copyFragment)))
]

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> deepFindResolverForIdentifier: aString [

	^ self findResolverForIdentifier: aString
]

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> findResolverForIdentifier: aString [

	^ (self lookupIdentifier: aString) ifNotNil: [ self ]
]

{ #category : #testing }
ViennaFlatDocumentNode >> isViennaFlatDocumentNode [

	^ true
]

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> lookupIdentifier: aString [

	self toplevelDefinitionsDo: [ :definition |
		(definition bindsIdentifier: aString) ifTrue: [
			definition isViennaStateDefinitionNode ifTrue: [
				definition fieldsDo: [ :field |
					field identifier = aString ifTrue: [ ^ field ] ] ].
			^ definition ] ].
	^ nil
]

{ #category : #accessing }
ViennaFlatDocumentNode >> moduleOrFlatDocument [

	^ self
]

{ #category : #enumerating }
ViennaFlatDocumentNode >> sectionsDo: aBlock [

	self do: aBlock
]

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> stateDefinition [

	self sectionsDo: [ :section |
		section isViennaStateDefinitionNode ifTrue: [ ^ section ] ].
	^ nil
]

{ #category : #'accessing-definitions' }
ViennaFlatDocumentNode >> stateDefinitionIfAbsentPut: errorBlock [

	^ self stateDefinition ifNil: [
		  | def |
		  def := errorBlock value.
		  self add: def.
		  def ]
]

{ #category : #enumerating }
ViennaFlatDocumentNode >> toplevelDefinitionsDo: aBlock [

	self sectionsDo: [ :section |
		section isViennaStateDefinitionNode
			ifTrue: [ aBlock value: section ]
			ifFalse: [ section do: aBlock ] ]
]
