Class {
	#name : #ViennaRefactoring,
	#superclass : #Object,
	#instVars : [
		'ast'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #testing }
ViennaRefactoring class >> isAbstract [
	^ self = ViennaRefactoring
]

{ #category : #utilities }
ViennaRefactoring class >> on: aViennaNode do: aBlock [
	self
		allSubclassesDo: [ :class | 
			class isAbstract
				ifFalse: [ | refactoring |
					refactoring := class new ast: aViennaNode.
					refactoring check
						ifTrue: [ aBlock value: refactoring ] ] ]
]

{ #category : #accessing }
ViennaRefactoring >> ast [
	^ ast
]

{ #category : #accessing }
ViennaRefactoring >> ast: aViennaNode [
	ast := aViennaNode
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString in: aViennaNode do: aBlock [
	| selector |
	aViennaNode isViennaNode
		ifFalse: [ ^ self ].
	selector := ('bindingOf:in' , aViennaNode label , ':do:')
		asSymbol.
	(self respondsTo: selector)
		ifTrue: [ self
				perform: selector
				with: aString
				with: aViennaNode
				with: aBlock ]
		ifFalse: [ aViennaNode
				do: [ :node | self bindingOf: aString in: node do: aBlock ] ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inAssignmentDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inError: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inExplicitFunctionDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inExplicitOperationDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inImplicitFunctionDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inImplicitOperationDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inIndexForLoop: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inPatternIdentifier: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inRecordTypeDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inStateDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode second
		do: [ :field | 
			field first = aString
				ifTrue: [ aBlock value: field ] ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inTypeDefinition: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> bindingOf: aString inTypeVariableIdentifier: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ].
	aViennaNode
		do: [ :node | self bindingOf: aString in: node do: aBlock ]
]

{ #category : #operations }
ViennaRefactoring >> check [
	^ self subclassResponsibility
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> directScopeNodeLabels [
	^ #('IndexForLoop') asSet
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> enclosingScopeNodeLabels [
	^ #('Document' 'Module' 'ExplicitFunctionDefinition' 'ImplicitFunctionDefinition' 'ExplicitOperationDefinition' 'ImplicitOperationDefinition' 'CasesExpressionAlternative' 'CasesStatementAlternative' 'LetExpression' 'LetStatement' 'LetBeExpression' 'LetBeStatement' 'SequenceComprehension' 'SetComprehension' 'MapComprehension' 'ForallExpression' 'ExistsExpression' 'Exists1Expression' 'IotaExpression' 'LambdaExpression' 'InvariantInitialFunction' 'SequenceForLoop' 'SetForLoop' 'BlockStatement')
		asSet
]

{ #category : #operations }
ViennaRefactoring >> execute [
	^ self subclassResponsibility
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString in: aViennaNode do: aBlock [
	| selector |
	aViennaNode isViennaNode
		ifFalse: [ ^ self ].
	selector := ('freeOccurrencesOf:in' , aViennaNode label , ':do:')
		asSymbol.
	(self respondsTo: selector)
		ifTrue: [ self
				perform: selector
				with: aString
				with: aViennaNode
				with: aBlock ]
		ifFalse: [ aViennaNode
				do: [ :node | self freeOccurrencesOf: aString in: node do: aBlock ] ]
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inBlockStatement: aViennaNode do: aBlock [
	aViennaNode first label = 'DclStatement'
		ifTrue: [ self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
			aViennaNode first
				do: [ :dclDef | 
					dclDef first = aString
						ifTrue: [ ^ self ] ].
			2 to: aViennaNode size do:
				[ :index | self freeOccurrencesOf: aString in: (aViennaNode at: index) do: aBlock ] ].
	aViennaNode
		do: [ :node | self freeOccurrencesOf: aString in: node do: aBlock ]
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inCasesAlternative: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inCasesExpressionAlternative: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inCasesAlternative: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inCasesStatementAlternative: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inCasesAlternative: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inDef: aViennaNode do: aBlock [
	aViennaNode first
		do: [ :equalDefinition | 
			self freeOccurrencesOf: aString in: equalDefinition do: aBlock.
			equalDefinition first
				allDescendantsDo: [ :n | 
					(n label = 'PatternIdentifier' and: [ n first = aString ])
						ifTrue: [ ^ self ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inDefExpression: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inDef: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inDefStatement: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inDef: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inExists1Expression: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inSingleQuantifierExpression: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inExistsExpression: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inFullQuantifierExpression: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inExplicitFunctionDefinition: aViennaNode do: aBlock [
	aViennaNode second
		do: [ :n | 
			(n label = 'TypeVariableIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fourth do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fifth do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode ninth do: aBlock.
	aViennaNode fifth
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode sixth do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode seventh do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode eighth do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inExplicitOperationDefinition: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fourth do: aBlock.
	aViennaNode fifth
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode fifth do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode sixth do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode seventh do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inForallExpression: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inFullQuantifierExpression: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inFullQuantifierExpression: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first
		do: [ :multiBind | 
			multiBind first
				do: [ :pattern | 
					pattern
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = aString ])
								ifTrue: [ ^ self ] ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inFunctionImport: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inImplicitFunctionDefinition: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fourth do: aBlock.
	aViennaNode third first
		ifNotEmpty: [ :patternTypePairList | 
			1 to: patternTypePairList size by: 2 do: [ :index | 
				(patternTypePairList at: index)
					allDescendantsDo: [ :n | 
						(n label = 'PatternIdentifier' and: [ n first = aString ])
							ifTrue: [ ^ self ] ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode fifth do: aBlock.
	aViennaNode fourth
		ifNotEmpty: [ :identifierTypePairList | 
			1 to: identifierTypePairList size by: 2 do: [ :index | 
				(identifierTypePairList at: index) = aString
					ifTrue: [ ^ self ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode sixth do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inImplicitOperationDefinition: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock.
	self
		freeOccurrencesOf: aString
		in: aViennaNode fourth first
		do: aBlock.
	self
		freeOccurrencesOf: aString
		in: aViennaNode fourth fourth
		do: aBlock.
	aViennaNode second first
		ifNotEmpty: [ :patternTypePairList | 
			1 to: patternTypePairList size by: 2 do: [ :index | 
				(patternTypePairList at: index)
					allDescendantsDo: [ :n | 
						(n label = 'PatternIdentifier' and: [ n first = aString ])
							ifTrue: [ ^ self ] ] ] ].
	self
		freeOccurrencesOf: aString
		in: aViennaNode fourth second
		do: aBlock.
	aViennaNode fourth
		ifNotEmpty: [ :identifierTypePairList | 
			1 to: identifierTypePairList size by: 2 do: [ :index | 
				(identifierTypePairList at: index) = aString
					ifTrue: [ ^ self ] ] ].
	self
		freeOccurrencesOf: aString
		in: aViennaNode fourth third
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inIndexForLoop: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fourth do: aBlock.
	aViennaNode first = aString
		ifTrue: [ ^ self ].
	self freeOccurrencesOf: aString in: aViennaNode fifth do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inInvariantInitialFunction: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inIotaExpression: aViennaNode do: aBlock [
	^ self
		freeOccurrencesOf: aString
		inSingleQuantifierExpression: aViennaNode
		do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLambdaExpression: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first
		do: [ :bind | 
			bind first
				allDescendantsDo: [ :node | 
					(node label = 'PatternIdentifier' and: [ node first = aString ])
						ifTrue: [ ^ self ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLet: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first
		do: [ :localDef | 
			| def |
			def := localDef first.
			def label = 'ValueDefinition'
				ifTrue: [ def first
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = aString ])
								ifTrue: [ ^ self ] ] ].
			(def label = 'FunctionDefinition'
				and: [ def first first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetBe: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode first first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetBeExpression: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inLetBe: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetBeStatement: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inLetBe: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetExpression: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inLet: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLetStatement: aViennaNode do: aBlock [
	^ self freeOccurrencesOf: aString inLet: aViennaNode do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inLocalName: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ]
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inMapComprehension: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock.
	aViennaNode third
		do: [ :multiBind | 
			multiBind first
				do: [ :pattern | 
					pattern
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = aString ])
								ifTrue: [ ^ self ] ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode fourth do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inOldName: aViennaNode do: aBlock [
	aViennaNode first = aString
		ifTrue: [ aBlock value: aViennaNode ]
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inOperationImport: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSequenceComprehension: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode second first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSequenceForLoop: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSetComprehension: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode second
		do: [ :multiBind | 
			multiBind first
				do: [ :pattern | 
					pattern
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = aString ])
								ifTrue: [ ^ self ] ] ] ].
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSetForLoop: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock.
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode third do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inSingleQuantifierExpression: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	aViennaNode first first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = aString ])
				ifTrue: [ ^ self ] ].
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inTypeImport: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock
]

{ #category : #'visiting-free occurrences' }
ViennaRefactoring >> freeOccurrencesOf: aString inValueImport: aViennaNode do: aBlock [
	self freeOccurrencesOf: aString in: aViennaNode first do: aBlock.
	self freeOccurrencesOf: aString in: aViennaNode second do: aBlock
]

{ #category : #'visiting-bindings' }
ViennaRefactoring >> hasLocalBindingOf: aString in: aViennaNode [
	self bindingOf: aString in: aViennaNode do: [ :n | ^ true ].
	^ false
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeBy: aViennaNode do: aBlock [
	| selector |
	aViennaNode isViennaNode
		ifFalse: [ ^ self ].
	selector := ('localScopeBy' , aViennaNode label , ':do:') asSymbol.
	(self respondsTo: selector)
		ifTrue: [ self perform: selector with: aViennaNode with: aBlock ]
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByBlockStatement: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByCasesExpressionAlternative: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByCasesStatementAlternative: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByDefExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByDefStatement: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByExists1Expression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByExistsExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByExplicitFunctionDefinition: aViennaNode do: aBlock [
	aBlock value: aViennaNode sixth.
	aBlock value: aViennaNode seventh.
	aBlock value: aViennaNode eighth
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByExplicitOperationDefinition: aViennaNode do: aBlock [
	aBlock value: aViennaNode fifth first.
	aBlock value: aViennaNode sixth.
	aBlock value: aViennaNode seventh
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByForallExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByImplicitFunctionDefinition: aViennaNode do: aBlock [
	aBlock value: aViennaNode fifth.
	aBlock value: aViennaNode sixth
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByImplicitOperationDefinition: aViennaNode do: aBlock [
	aBlock value: aViennaNode fourth second.
	aBlock value: aViennaNode fourth third.
	aBlock value: aViennaNode fourth fourth
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByIndexForLoopDefinition: aViennaNode do: aBlock [
	aBlock value: aViennaNode fifth
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByInvariantInitialFunction: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByIotaExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByLambdaExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode second
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByLetBeExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByLetBeStatement: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByLetExpression: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByLetStatement: aViennaNode do: aBlock [
	aBlock value: aViennaNode
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeByMapComprehension: aViennaNode do: aBlock [
	aBlock value: aViennaNode first.
	aBlock value: aViennaNode second.
	aBlock value: aViennaNode fourth
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeBySequenceComprehension: aViennaNode do: aBlock [
	aBlock value: aViennaNode first.
	aBlock value: aViennaNode third
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeBySequenceForLoop: aViennaNode do: aBlock [
	aBlock value: aViennaNode third
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeBySetComprehension: aViennaNode do: aBlock [
	aBlock value: aViennaNode first.
	aBlock value: aViennaNode third
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> localScopeBySetForLoop: aViennaNode do: aBlock [
	aBlock value: aViennaNode third
]

{ #category : #accessing }
ViennaRefactoring >> name [
	^ self subclassResponsibility
]

{ #category : #'visiting-labels' }
ViennaRefactoring >> patternIdentifiersWith: aString in: aViennaNode do: aBlock [
	(aViennaNode label = 'PatternIdentifier'
		and: [ aViennaNode first = aString ])
		ifTrue: [ aBlock cull: aViennaNode ].
	aViennaNode
		allDescendantsDo: [ :node | 
			(node label = 'PatternIdentifier' and: [ node first = aString ])
				ifTrue: [ aBlock cull: node ] ]
]

{ #category : #signaling }
ViennaRefactoring >> refactoringError: aViennaNode [
	^ (ViennaRefactoringError refactoring: self node: aViennaNode) signal
]

{ #category : #'visiting-manipulations' }
ViennaRefactoring >> replaceNode: aViennaNode with: anotherViennaNode [
	| parent |
	parent := aViennaNode parent.
	1 to: parent size do: [ :index | 
		(parent at: index) == aViennaNode
			ifTrue: [ parent at: index put: anotherViennaNode ] ]
]

{ #category : #'visiting-scopes' }
ViennaRefactoring >> scopeOf: aViennaNode [
	| scopingNodeLabels node |
	scopingNodeLabels := self enclosingScopeNodeLabels.
	(self directScopeNodeLabels includes: aViennaNode label)
		ifTrue: [ ^ aViennaNode ].
	node := aViennaNode parent ifNil: [ ^ aViennaNode ].
	[ scopingNodeLabels includes: node label ]
		whileFalse: [ (node := node parent) ifNil: [ ^ node ] ].
	^ node
]
