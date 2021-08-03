Class {
	#name : #ViennaExtractValue,
	#superclass : #ViennaExtract,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaExtractValue >> check [
	ast isExpressionNode
		ifFalse: [ ^ false ].
	(#('LocalName' 'GlobalName' 'OldName') includes: ast label)
		ifTrue: [ ^ false ].
	ast variableExpressionNodesDo: [ :node | ^ false ].
	ast parent label = 'ValueDefinition'
		ifTrue: [ ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractValue >> execute [
	| moduleBody valueDefinitions valueDefinition accessValueDefinition |
	self newName ifNil: [ ^ nil ].
	moduleBody := ast module third.
	valueDefinitions := (moduleBody
		detect: [ :definitionBlock | 
			definitionBlock isViennaNode
				and: [ definitionBlock first isViennaNode
						and: [ definitionBlock first label = 'ValueDefinitions' ] ] ]
		ifNone: [ nil ]) ifNotNil: #first.
	valueDefinitions
		ifNil: [ valueDefinitions := ViennaNode label: 'ValueDefinitions'.
			moduleBody
				add: (ViennaNode label: 'DefinitionBlock' with: valueDefinitions) ].
	self
		replaceNode: ast
		with: (ViennaNode label: 'LocalName' with: self newName).
	valueDefinition := ViennaNode
		label: 'ValueDefinition'
		withAll:
			{(ViennaNode label: 'PatternIdentifier' with: self newName).
			nil.
			ast}.
	accessValueDefinition := ViennaNode
		label: 'AccessValueDefinition'
		with: (ViennaNode label: 'Access')
		with: valueDefinition.
	valueDefinitions add: accessValueDefinition.
	^ accessValueDefinition
]

{ #category : #accessing }
ViennaExtractValue >> findNewName [
	(UIManager default
		request: 'name of toplevel value for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractValue >> name [
	^ 'Extract value definition from ' asText
		, (self shortDescription: ast source) asText allBold
]

{ #category : #accessing }
ViennaExtractValue >> sortingOrder [
	^ 2.53
]
