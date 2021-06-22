Class {
	#name : #ViennaConvertExpressionIntoValueAndReplaceAll,
	#superclass : #ViennaConvertExpressionIntoValue,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaConvertExpressionIntoValueAndReplaceAll >> execute [
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
	ast module
		allDescendantsDo: [ :n | 
			(ast sameAs: n)
				ifTrue: [ self
						replaceNode: n
						with: (ViennaNode label: 'LocalName' with: self newName) ] ].
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
ViennaConvertExpressionIntoValueAndReplaceAll >> name [
	^ 'convert all occurrences of ' asText , ast source asText allBold
		, ' into a toplevel value definition' asText
]

{ #category : #accessing }
ViennaConvertExpressionIntoValueAndReplaceAll >> sortingOrder [
	^ 2.54
]
