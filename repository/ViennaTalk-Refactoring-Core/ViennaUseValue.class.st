Class {
	#name : 'ViennaUseValue',
	#superclass : 'ViennaUse',
	#instVars : [
		'values',
		'valuesIndex'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'operations' }
ViennaUseValue >> check [

	^ self values notEmpty
]

{ #category : 'operations' }
ViennaUseValue >> execute [

	| binds expression |
	binds := (self definitionNode pattern uniqueBoundIdentifiers
		          collect: [ :string |
		          string -> (ViennaLocalNameNode identifier: string) ])
		         asDictionary.
	expression := self
		              expressionFromPattern: self definitionNode pattern
		              bindings: binds.
	^ self replaceNode: ast with: expression
]

{ #category : 'operations' }
ViennaUseValue >> findDefinitionNode [

	^ self values
		  ifNotEmpty: [ :vs | self valuesIndex ifNotNil: [ :i | vs at: i ] ]
		  ifEmpty: [ nil ]
]

{ #category : 'accessing' }
ViennaUseValue >> findValues [

	ast ifNil: [ ^ Array new ].
	ast isViennaExpressionNode ifFalse: [ ^ Array new ].
	^ Array streamContents: [ :stream |
		  self valueDefinitionsDo: [ :valueDefinition |
			  (valueDefinition expression ~~ ast and: [
				   valueDefinition expression = ast ]) ifTrue: [
				  stream nextPut: valueDefinition ] ] ]
]

{ #category : 'accessing' }
ViennaUseValue >> findValuesIndex [

	^ UIManager default
		  chooseFrom: (self values collect: #identifier)
		  values: (1 to: self values size)
		  lines: #(  )
		  message: 'Select a value name to use'
		  title: 'Use value name'
]

{ #category : 'accessing' }
ViennaUseValue >> name [

	^ 'Use value name for '
	  , (self shortDescription: self ast source) asText allBold
]

{ #category : 'enumerating' }
ViennaUseValue >> valueDefinitionsDo: aBlock [

	self ast module sectionsDo: [ :section |
		section isViennaValueDefinitionsNode ifTrue: [ section do: aBlock ] ]
]

{ #category : 'accessing' }
ViennaUseValue >> values [

	^ values ifNil: [ values := self findValues ]
]

{ #category : 'accessing' }
ViennaUseValue >> valuesIndex [

	^ valuesIndex ifNil: [ valuesIndex := self findValuesIndex ]
]

{ #category : 'accessing' }
ViennaUseValue >> valuesIndex: anInteger [

	valuesIndex := anInteger
]
