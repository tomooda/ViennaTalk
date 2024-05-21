Class {
	#name : 'ViennaModuleBodyNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaModuleBodyNode >> boundIdentifiersDo: aBlock [

	self do: [ :node | node boundIdentifiersDo: aBlock ]
]

{ #category : 'pretty printing' }
ViennaModuleBodyNode >> formatWith: aViennaAbstractFormatter [

	| definitionBlocks |
	definitionBlocks := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter empty
	  ++ (aViennaAbstractFormatter keyword: 'definitions')
	  ++ aViennaAbstractFormatter cr
	  ++
	  (aViennaAbstractFormatter join: String cr withAll: definitionBlocks)
]

{ #category : 'private' }
ViennaModuleBodyNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaModuleBodyNode >> isViennaModuleBodyNode [

	^ true
]

{ #category : 'accessing' }
ViennaModuleBodyNode >> label [

	^ 'ModuleBody'
]

{ #category : 'typechecking' }
ViennaModuleBodyNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]

{ #category : 'enumerating' }
ViennaModuleBodyNode >> sectionsDo: aBlock [

	self do: aBlock
]

{ #category : 'accessing' }
ViennaModuleBodyNode >> stateDefinition [

	self sectionsDo: [ :section |
		section isViennaStateDefinitionNode ifTrue: [ ^ section ] ].
	^ nil
]

{ #category : 'enumerating' }
ViennaModuleBodyNode >> toplevelDefinitionsDo: aBlock [

	self sectionsDo: [ :section |
		section isViennaStateDefinitionNode
			ifTrue: [ aBlock value: section ]
			ifFalse: [ section do: aBlock ] ]
]
