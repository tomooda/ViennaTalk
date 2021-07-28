Class {
	#name : #ViennaRemoveOperation,
	#superclass : #ViennaRemove,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRemoveOperation >> check [
	| moduleName shortName |
	ast ifNil: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	moduleName := self definitionNode module first.
	shortName := self definitionNode name.
	(self hasFreeOccurrencesOf: shortName in: self definitionNode module)
		ifTrue: [ ^ false ].
	(self
		hasFreeOccurrencesOf: 'pre_' , shortName
		in: self definitionNode module)
		ifTrue: [ ^ false ].
	(self
		hasFreeOccurrencesOf: 'post' , shortName
		in: self definitionNode module)
		ifTrue: [ ^ false ].
	ast document
		allDescendantsDo: [ :node | 
			(node label = 'GlobalName'
				and: [ node first = moduleName and: [ node second = shortName ] ])
				ifTrue: [ ^ false ] ].
	ast
		modulesDo: [ :module | 
			module second first
				ifNotNil: [ :importDefinitionList | 
					importDefinitionList
						do: [ :importDefinition | 
							importDefinition first = moduleName
								ifTrue: [ importDefinition
										allDescendantsDo: [ :node | 
											(node label = 'OperationImport' and: [ node first = shortName ])
												ifTrue: [ ^ false ] ] ] ] ] ].
	^ true
]

{ #category : #operations }
ViennaRemoveOperation >> execute [
	(self definitionNode
		parentLabelled: 'OperationDefinitions'
		ifAbsent: [ nil ])
		ifNotNil: [ :operationDefinitions | 
			operationDefinitions remove: self definitionNode parent parent.
			operationDefinitions
				ifEmpty: [ operationDefinitions parent parent
						remove: operationDefinitions parent ] ]
]

{ #category : #accessing }
ViennaRemoveOperation >> findDefinitionNode [
	ast ifNil: [ ^ nil ].
	^ ast resolve
		ifNotNil: [ :node | 
			(#('ExplicitOperationDefinition' 'ImplicitOperationDefinition')
				includes: node label)
				ifTrue: [ node ]
				ifFalse: [ nil ] ]
]

{ #category : #accessing }
ViennaRemoveOperation >> sortingOrder [
	^ 1.2
]