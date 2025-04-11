Class {
	#name : 'ViennaFlatDocumentNode',
	#superclass : 'ViennaDocumentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing-definitions' }
ViennaFlatDocumentNode >> addFunctionDefinition: aViennaNode [

	(self detect: #isViennaFunctionDefinitionsNode ifNone: [
		 | section |
		 section := ViennaFunctionDefinitionsNode empty.
		 self add: section.
		 section ]) add: aViennaNode
]

{ #category : 'accessing-definitions' }
ViennaFlatDocumentNode >> addOperationDefinition: aViennaNode [

	(self detect: #isViennaOperationDefinitionsNode ifNone: [
		 | section |
		 section := ViennaOperationDefinitionsNode empty.
		 self add: section.
		 section ]) add: aViennaNode
]

{ #category : 'accessing-definitions' }
ViennaFlatDocumentNode >> addTypeDefinition: aViennaNode [

	(self detect: #isViennaTypeDefinitionsNode ifNone: [
		 | section |
		 section := ViennaTypeDefinitionsNode empty.
		 self add: section.
		 section ]) add: aViennaNode
]

{ #category : 'accessing-definitions' }
ViennaFlatDocumentNode >> addValueDefinition: aViennaNode [

	(self detect: #isViennaValueDefinitionsNode ifNone: [
		 | section |
		 section := ViennaValueDefinitionsNode empty.
		 self add: section.
		 section ]) add: aViennaNode
]

{ #category : 'converting' }
ViennaFlatDocumentNode >> asModularDocument [

	^ ViennaModularDocumentNode withAll: (ViennaModuleNode
			   identifier: 'DEFAULT'
			   moduleBody:
			   (ViennaModuleBodyNode withAll: (self collect: #copyFragment)))
]

{ #category : 'accessing-definitions' }
ViennaFlatDocumentNode >> deepFindResolverForIdentifier: aString [

	^ self findResolverForIdentifier: aString
]

{ #category : 'accessing-definitions' }
ViennaFlatDocumentNode >> definitionOfLocalName: aString [

	(aString beginsWith: 'pre_') ifTrue: [
		| name |
		name := aString copyFrom: 'pre_' size + 1 to: aString size.
		self toplevelDefinitionsDo: [ :def |
			((def isViennaFunctionDefinitionNode: name) or: [
				 def isViennaOperationDefinitionNode: name ]) ifTrue: [
				^ def preFunction ] ] ].
	(aString beginsWith: 'post_') ifTrue: [
		| name |
		name := aString copyFrom: 'post_' size + 1 to: aString size.
		self toplevelDefinitionsDo: [ :def |
			((def isViennaFunctionDefinitionNode: name) or: [
				 def isViennaOperationDefinitionNode: name ]) ifTrue: [
				^ def postFunction ] ] ].

	self sectionsDo: [ :section |
		section isViennaStateDefinitionNode
			ifTrue: [
				section identifier = aString ifTrue: [ ^ section ].
				section fieldList do: [ :field |
					field identifier = aString ifTrue: [ ^ field ] ] ]
			ifFalse: [
				section do: [ :def |
					(def isViennaTypeSynonymNode: aString) ifTrue: [ ^ def ].
					(def isViennaRecordTypeDefinitionNode: aString) ifTrue: [ ^ def ].
					def isViennaValueDefinitionNode ifTrue: [
						def pattern
							allDescendantsSuchThat: [ :n |
							n isViennaPatternIdentifierNode: aString ]
							do: [ :n | ^ n ] ].
					(def isViennaFunctionDefinitionNode: aString) ifTrue: [ ^ def ].
					(def isViennaOperationDefinitionNode: aString) ifTrue: [ ^ def ] ] ] ].
	^ nil
]

{ #category : 'accessing-definitions' }
ViennaFlatDocumentNode >> findResolverForIdentifier: aString [

	^ (self lookupIdentifier: aString) ifNotNil: [ self ]
]

{ #category : 'testing' }
ViennaFlatDocumentNode >> hasStateDefinition [

	     ^ self anySatisfy: #isViennaStateDefinitionNode
]

{ #category : 'testing' }
ViennaFlatDocumentNode >> isViennaFlatDocumentNode [

	^ true
]

{ #category : 'accessing-definitions' }
ViennaFlatDocumentNode >> lookupIdentifier: aString [

	self toplevelDefinitionsDo: [ :definition |
		(definition bindsIdentifier: aString) ifTrue: [
			definition isViennaStateDefinitionNode ifTrue: [
				definition fieldsDo: [ :field |
					field identifier = aString ifTrue: [ ^ field ] ] ].
			((aString beginsWith: 'pre_') and: [
				 definition isFunctionDefinition or: [
					 definition isOperationDefinition ] ]) ifTrue: [
				^ definition preFunction ].
			((aString beginsWith: 'post_') and: [
				 definition isFunctionDefinition or: [
					 definition isOperationDefinition ] ]) ifTrue: [
				^ definition postFunction ].
			^ definition ] ].
	^ nil
]

{ #category : 'typechecking' }
ViennaFlatDocumentNode >> maximalType [

	self sectionsDo: #typecheck.
	^ ViennaType unit
]

{ #category : 'accessing' }
ViennaFlatDocumentNode >> moduleOrFlatDocument [

	^ self
]

{ #category : 'enumerating' }
ViennaFlatDocumentNode >> sectionsDo: aBlock [

	self do: aBlock
]

{ #category : 'accessing-definitions' }
ViennaFlatDocumentNode >> stateDefinition [

	self sectionsDo: [ :section |
		section isViennaStateDefinitionNode ifTrue: [ ^ section ] ].
	^ nil
]

{ #category : 'accessing-definitions' }
ViennaFlatDocumentNode >> stateDefinitionIfAbsentPut: errorBlock [

	^ self stateDefinition ifNil: [
		  | def |
		  def := errorBlock value.
		  self add: def.
		  def ]
]

{ #category : 'enumerating' }
ViennaFlatDocumentNode >> toplevelDefinitionsDo: aBlock [

	self sectionsDo: [ :section |
		section isViennaStateDefinitionNode
			ifTrue: [ aBlock value: section ]
			ifFalse: [ section do: aBlock ] ]
]
