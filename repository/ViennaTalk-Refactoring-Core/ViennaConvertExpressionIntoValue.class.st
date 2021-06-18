Class {
	#name : #ViennaConvertExpressionIntoValue,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'newName'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaConvertExpressionIntoValue >> check [
	ast isExpressionNode
		ifFalse: [ ^ false ].
	(#('LocalName' 'GlobalName' 'OldName') includes: ast label)
		ifTrue: [ ^ false ].
	ast variableExpressionNodesDo: [ :node | ^ false ].
	^ true
]

{ #category : #operations }
ViennaConvertExpressionIntoValue >> execute [
	| moduleBody valueDefinitions valueDefinition accessValueDefinition |
	self newName ifNil: [ ^ self ].
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
	valueDefinitions add: accessValueDefinition
]

{ #category : #accessing }
ViennaConvertExpressionIntoValue >> findNewName [
	(UIManager default
		request: 'name of toplevel value for ' , self ast source
		initialAnswer: 'value')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaConvertExpressionIntoValue >> name [
	^ 'convert ' asText , ast source asText allBold
		, ' into a toplevel value definition' asText
]

{ #category : #accessing }
ViennaConvertExpressionIntoValue >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaConvertExpressionIntoValue >> newName: anObject [
	newName := anObject
]
