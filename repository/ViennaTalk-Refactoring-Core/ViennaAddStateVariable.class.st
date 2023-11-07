Class {
	#name : #ViennaAddStateVariable,
	#superclass : #ViennaAdd,
	#instVars : [
		'initialValue'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaAddStateVariable >> execute [

	self containerNode ifNotNil: [ :stateDefinition |
		self newAst ifNotNil: [ :stateField |
			(stateDefinition bindsIdentifier: stateField identifier) ifFalse: [
				stateDefinition fieldList add: self newAst.
				stateDefinition inv ifNotNil: [ :inv |
					| pattern |
					pattern := inv pattern.
					(pattern isViennaRecordPatternNode and: [
						 pattern name identifier = stateDefinition identifier ])
						ifTrue: [
						pattern patternList add: ViennaPatternIdentifierNode anonymous ] ].
				stateDefinition init ifNotNil: [ :initializer |
					initializer expression ifNotNil: [ :eq |
						eq isViennaEqualNode ifTrue: [
							eq expression2 ifNotNil: [ :record |
								record name identifier = stateDefinition identifier ifTrue: [
									self initialValue ifNotNil: [ :value |
										record expressionList add: value ] ] ] ] ] ] ] ] ]
]

{ #category : #accessing }
ViennaAddStateVariable >> findContainerNode [

	^ ast ifNotNil: [
		  ast module ifNotNil: [ :module | module stateDefinition ] ]
]

{ #category : #accessing }
ViennaAddStateVariable >> findInitialValue [

	(UIManager default
		 request: 'Initial value for ' , self newName , '?'
		 initialAnswer: '') ifNotNil: [ :ans |
		ans trim ifNotEmpty: [ :expr |
			| value |
			value := ViennaVDMParser new expression end parse: expr.
			value isPetit2Success ifTrue: [ ^ value ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaAddStateVariable >> findNewName [

	(UIManager default request: self newNameQuery initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaAddStateVariable >> initialValue [

	^ initialValue ifNil: [ initialValue := self findInitialValue ]
]

{ #category : #accessing }
ViennaAddStateVariable >> name [

	^ 'Add a state variable with a type'
]

{ #category : #accessing }
ViennaAddStateVariable >> newNameQuery [

	^ 'a new state variable name'
]

{ #category : #accessing }
ViennaAddStateVariable >> parser [

	^ ViennaVDMParser new stateField end
]

{ #category : #accessing }
ViennaAddStateVariable >> sortingOrder [
	^ 0.08
]

{ #category : #accessing }
ViennaAddStateVariable >> sourceWithNewName: aString [

	^ aString
]
