Class {
	#name : #ViennaRenameLocal,
	#superclass : #ViennaRename,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameLocal >> check [
	^ self definitionNode notNil
]

{ #category : #operations }
ViennaRenameLocal >> executeOnBlockStatement: aViennaNode [
	aViennaNode
		do: [ :statement | 
			statement label = 'DclStatement'
				ifTrue: [ statement
						do: [ :assignmentDefinition | 
							assignmentDefinition first = oldName
								ifTrue: [ assignmentDefinition at: 1 put: newName ] ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnCasesExpressionAlternative: aViennaNode [
	aViennaNode first
		allDescendantsDo: [ :node | 
			(node label = 'PatternIdentifier' and: [ node first = oldName ])
				ifTrue: [ node at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnCasesStatementAlternative: aViennaNode [
	aViennaNode first
		allDescendantsDo: [ :node | 
			(node label = 'PatternIdentifier' and: [ node first = oldName ])
				ifTrue: [ node at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnDefinition [
	| selector |
	selector := ('executeOn' , self definitionNode label , ':') asSymbol.
	(self respondsTo: selector)
		ifTrue: [ self perform: selector with: self definitionNode ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnExists1Expression: aViennaNode [
	aViennaNode first first
		allDescendantsDo: [ :node | 
			(node label = 'PatternIdentifier' and: [ node first = oldName ])
				ifTrue: [ node at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnExistsExpression: aViennaNode [
	aViennaNode first
		do: [ :bind | 
			bind first
				allDescendantsDo: [ :node | 
					(node label = 'PatternIdentifier' and: [ node first = oldName ])
						ifTrue: [ node at: 1 put: newName ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnExplicitFunctionDefinition: aViennaNode [
	aViennaNode second
		do: [ :n | 
			(n label = 'TypeVariableIdentifier' and: [ n first = oldName ])
				ifTrue: [ n at: 1 put: newName ] ].
	aViennaNode fifth
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = oldName ])
				ifTrue: [ n at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnExplicitOperationDefinition: aViennaNode [
	aViennaNode fifth
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = oldName ])
				ifTrue: [ n at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnForallExpression: aViennaNode [
	aViennaNode first
		do: [ :bind | 
			bind first
				allDescendantsDo: [ :node | 
					(node label = 'PatternIdentifier' and: [ node first = oldName ])
						ifTrue: [ node at: 1 put: newName ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnImplicitFunctionDefinition: aViennaNode [
	aViennaNode third first
		ifNotEmpty: [ :patternTypePairList | 
			1 to: patternTypePairList size by: 2 do: [ :index | 
				(patternTypePairList at: index)
					allDescendantsDo: [ :n | 
						(n label = 'PatternIdentifier' and: [ n first = oldName ])
							ifTrue: [ n at: 1 put: newName ] ] ] ].
	aViennaNode fourth
		ifNotEmpty: [ :identifierTypePairList | 
			1 to: identifierTypePairList size by: 2 do: [ :index | 
				(identifierTypePairList at: index) = oldName
					ifTrue: [ identifierTypePairList at: 1 put: newName ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnImplicitOperationDefinition: aViennaNode [
	aViennaNode second first
		ifNotEmpty: [ :patternTypePairList | 
			1 to: patternTypePairList size by: 2 do: [ :index | 
				(patternTypePairList at: index)
					allDescendantsDo: [ :n | 
						(n label = 'PatternIdentifier' and: [ n first = oldName ])
							ifTrue: [ n at: 1 put: newName ] ] ] ].
	aViennaNode fourth
		ifNotEmpty: [ :identifierTypePairList | 
			1 to: identifierTypePairList size by: 2 do: [ :index | 
				(identifierTypePairList at: index) = oldName
					ifTrue: [ identifierTypePairList at: 1 put: newName ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnIndexForLoop: aViennaNode [
	aViennaNode first = oldName
		ifTrue: [ aViennaNode at: 1 put: newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnInvariantInitialFunction: aViennaNode [
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = oldName ])
				ifTrue: [ n at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnIotaExpression: aViennaNode [
	aViennaNode first first
		allDescendantsDo: [ :node | 
			(node label = 'PatternIdentifier' and: [ node first = oldName ])
				ifTrue: [ node at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnLambdaExpression: aViennaNode [
	aViennaNode first first
		allDescendantsDo: [ :node | 
			(node label = 'PatternIdentifier' and: [ node first = oldName ])
				ifTrue: [ node at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnLetBeExpression: aViennaNode [
	aViennaNode first first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = oldName ])
				ifTrue: [ n at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnLetBeStatement: aViennaNode [
	aViennaNode first first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = oldName ])
				ifTrue: [ n at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnLetExpression: aViennaNode [
	aViennaNode first
		do: [ :localDef | 
			| def |
			def := localDef first.
			def label = 'ValueDefinition'
				ifTrue: [ def first
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = oldName ])
								ifTrue: [ n at: 1 put: newName ] ] ].
			(def label = 'FunctionDefinition'
				and: [ def first first = oldName ])
				ifTrue: [ | functionDefinition |
					functionDefinition := def first.
					functionDefinition at: 1 put: newName.
					functionDefinition label = 'ExplicitFunctionDefinition'
						ifTrue: [ functionDefinition at: 4 put: newName ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnLetStatement: aViennaNode [
	aViennaNode first
		do: [ :localDef | 
			| def |
			def := localDef first.
			def label = 'ValueDefinition'
				ifTrue: [ def first
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = oldName ])
								ifTrue: [ n at: 1 put: newName ] ] ].
			(def label = 'FunctionDefinition'
				and: [ def first first = oldName ])
				ifTrue: [ | functionDefinition |
					functionDefinition := def first.
					functionDefinition at: 1 put: newName.
					functionDefinition label = 'ExplicitFunctionDefinition'
						ifTrue: [ functionDefinition at: 4 put: newName ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnMapComprehension: aViennaNode [
	aViennaNode third
		do: [ :multiBind | 
			multiBind first
				do: [ :pattern | 
					pattern
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = oldName ])
								ifTrue: [ n at: 1 put: newName ] ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnSequenceComprehension: aViennaNode [
	aViennaNode second first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = oldName ])
				ifTrue: [ n at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnSequenceForLoop: aViennaNode [
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = oldName ])
				ifTrue: [ n at: 1 put: newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnSetComprehension: aViennaNode [
	aViennaNode second
		do: [ :multiBind | 
			multiBind first
				do: [ :pattern | 
					pattern
						allDescendantsDo: [ :n | 
							(n label = 'PatternIdentifier' and: [ n first = oldName ])
								ifTrue: [ n at: 1 put: newName ] ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnSetForLoop: aViennaNode [
	aViennaNode first
		allDescendantsDo: [ :n | 
			(n label = 'PatternIdentifier' and: [ n first = oldName ])
				ifTrue: [ n at: 1 put: newName ] ]
]

{ #category : #accessing }
ViennaRenameLocal >> findDefinitionNode [
	| node |
	node := self scopeOf: ast.
	[ self hasLocalBindingOf: oldName in: node ]
		whileFalse: [ node := self scopeOf: node parent.
			node ifNil: [ ^ nil ] ].
	^ node
]
