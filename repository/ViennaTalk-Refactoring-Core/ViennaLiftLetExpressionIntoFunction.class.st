Class {
	#name : #ViennaLiftLetExpressionIntoFunction,
	#superclass : #ViennaRefactoring,
	#instVars : [
		'newName'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaLiftLetExpressionIntoFunction >> arguments [
	^ ViennaNode
		label: 'ExpressionList'
		withAll: (ast first collect: [ :localDef | localDef first third ])
]

{ #category : #operations }
ViennaLiftLetExpressionIntoFunction >> check [
	| params |
	ast label = 'LetExpression'
		ifFalse: [ ^ false ].
	params := Set new: ast first size * 2.
	ast first
		do: [ :localDef | 
			localDef first label = 'FunctionDefinition'
				ifTrue: [ ^ false ].
			localDef first first
				allDescendantsDo: [ :node | 
					node label = 'PatternIdentifier'
						ifTrue: [ params add: node first ] ] ].
	ast first
		do: [ :localDef | 
			localDef first third
				allDescendantsDo: [ :node | 
					(node label = 'LocalName' and: [ params includes: node first ])
						ifTrue: [ ^ false ] ] ].
	ast second variableExpressionNodesDo: [ :node | ^ false ].
	^ true
]

{ #category : #operations }
ViennaLiftLetExpressionIntoFunction >> execute [
	| moduleBody functionDefinitions explicitFunctionDefinition accessFunctionDefinition |
	self newName ifNil: [ ^ self ].
	moduleBody := ast module third.
	functionDefinitions := (moduleBody
		detect: [ :definitionBlock | 
			definitionBlock isViennaNode
				and: [ definitionBlock first isViennaNode
						and: [ definitionBlock first label = 'FunctionDefinitions' ] ] ]
		ifNone: [ nil ]) ifNotNil: #first.
	functionDefinitions
		ifNil: [ functionDefinitions := ViennaNode label: 'FunctionDefinitions'.
			moduleBody
				add: (ViennaNode label: 'DefinitionBlock' with: functionDefinitions) ].
	self
		replaceNode: ast
		with:
			(ViennaNode
				label: 'Apply'
				with: (ViennaNode label: 'LocalName' with: self newName)
				with: self arguments).
	explicitFunctionDefinition := ViennaNode
		label: 'ExplicitFunctionDefinition'
		withAll:
			{self newName.
			(ViennaNode label: 'TypeVariableList').
			self functionType.
			self newName.
			self functionParametersList.
			self functionBody.
			nil.
			nil.
			nil}.
	accessFunctionDefinition := ViennaNode
		label: 'AccessFunctionDefinition'
		with: (ViennaNode label: 'Access')
		with:
			(ViennaNode
				label: 'FunctionDefinition'
				with: explicitFunctionDefinition).
	functionDefinitions add: accessFunctionDefinition.
	^ accessFunctionDefinition
]

{ #category : #accessing }
ViennaLiftLetExpressionIntoFunction >> findNewName [
	(UIManager default
		request: 'name of toplevel function for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaLiftLetExpressionIntoFunction >> functionBody [
	^ ast second
]

{ #category : #accessing }
ViennaLiftLetExpressionIntoFunction >> functionParametersList [
	^ ViennaNode
		label: 'ParametersList'
		with:
			(ViennaNode
				label: 'Parameters'
				withAll: (ast first collect: [ :localDef | localDef first first ]))
]

{ #category : #accessing }
ViennaLiftLetExpressionIntoFunction >> functionType [
	^ ViennaNode
		label: 'PartialFunctionType'
		with:
			((ast first
				collect: [ :localDef | ViennaNode label: 'BasicType' with: 'any' ])
				ifNotEmpty: [ :paramTypes | 
					paramTypes size = 1
						ifTrue: [ paramTypes first ]
						ifFalse: [ ViennaNode label: 'ProductType' withAll: paramTypes ] ]
				ifEmpty: [ ViennaNode label: 'UnitType' ])
		with: (ViennaNode label: 'BasicType' with: 'any')
]

{ #category : #accessing }
ViennaLiftLetExpressionIntoFunction >> name [
	^ 'Lift ' asText , ast source asText allBold
		, ' into a FUNCTION' asText
]

{ #category : #accessing }
ViennaLiftLetExpressionIntoFunction >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaLiftLetExpressionIntoFunction >> newName: aString [
	newName := aString
]

{ #category : #accessing }
ViennaLiftLetExpressionIntoFunction >> sortingOrder [
	^ 2.55
]
