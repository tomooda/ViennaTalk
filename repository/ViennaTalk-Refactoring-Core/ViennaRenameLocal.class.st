Class {
	#name : #ViennaRenameLocal,
	#superclass : #ViennaRename,
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #operations }
ViennaRenameLocal >> check [

	^ self definitionNode notNil and: [
		  self definitionNode isViennaModuleNode and: [
			  self definitionNode isViennaDocumentNode not ] ]
]

{ #category : #accessing }
ViennaRenameLocal >> construct [
	^ 'local variable'
]

{ #category : #operations }
ViennaRenameLocal >> execute [
	self newName ifNil: [ ^ nil ].
	self
		executeOnDefinition;
		freeOccurrencesOf: self oldName
			in: self definitionNode second
			do: [ :node | self execute: node ].
	^ nil
]

{ #category : #operations }
ViennaRenameLocal >> execute: aViennaNode [
	| selector |
	aViennaNode isViennaNode
		ifFalse: [ ^ self ].
	selector := ('execute' , aViennaNode label , ':') asSymbol.
	(self respondsTo: selector)
		ifTrue: [ self perform: selector with: aViennaNode ]
		ifFalse: [ self refactoringError: aViennaNode ]
]

{ #category : #operations }
ViennaRenameLocal >> executeLocalName: aViennaNode [
	aViennaNode at: 1 put: self newName
]

{ #category : #operations }
ViennaRenameLocal >> executeOldName: aViennaNode [
	aViennaNode at: 1 put: self newName
]

{ #category : #operations }
ViennaRenameLocal >> executeOnBlockStatement: aViennaNode [

	aViennaNode do: [ :statement |
		statement isViennaDclStatementNode ifTrue: [
			statement do: [ :assignmentDefinition |
				assignmentDefinition first = self oldName ifTrue: [
					assignmentDefinition at: 1 put: self newName ] ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnCasesExpressionAlternative: aViennaNode [

	aViennaNode first
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnCasesStatementAlternative: aViennaNode [

	aViennaNode first
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
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
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnExistsExpression: aViennaNode [

	aViennaNode first do: [ :bind |
		bind first
			allDescendantsSuchThat: [ :node |
			node isViennaPatternIdentifierNode: self oldName ]
			do: [ :node | node identifier: self newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnExplicitFunctionDefinition: aViennaNode [

	aViennaNode second
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ].
	aViennaNode fifth
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnExplicitOperationDefinition: aViennaNode [

	aViennaNode fourth
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnForallExpression: aViennaNode [

	aViennaNode first do: [ :bind |
		bind first
			allDescendantsSuchThat: [ :node |
			node isViennaPatternIdentifierNode: self oldName ]
			do: [ :node | node identifier: self newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnImplicitFunctionDefinition: aViennaNode [

	aViennaNode third first ifNotEmpty: [ :patternTypePairList |
		1 to: patternTypePairList size by: 2 do: [ :index |
			(patternTypePairList at: index)
				allDescendantsSuchThat: [ :node |
				node isViennaPatternIdentifierNode: self oldName ]
				do: [ :node | node identifier: self newName ] ] ].
	aViennaNode fourth ifNotEmpty: [ :identifierTypePairList |
		1 to: identifierTypePairList size by: 2 do: [ :index |
			(identifierTypePairList at: index) = self oldName ifTrue: [
				identifierTypePairList at: 1 put: self newName ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnImplicitOperationDefinition: aViennaNode [

	aViennaNode second first ifNotEmpty: [ :patternTypePairList |
		1 to: patternTypePairList size by: 2 do: [ :index |
			(patternTypePairList at: index)
				allDescendantsSuchThat: [ :node |
				node isViennaPatternIdentifierNode: self oldName ]
				do: [ :node | node identifier: self newName ] ] ].
	aViennaNode fourth ifNotEmpty: [ :identifierTypePairList |
		1 to: identifierTypePairList size by: 2 do: [ :index |
			(identifierTypePairList at: index) = self oldName ifTrue: [
				identifierTypePairList at: 1 put: self newName ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnIndexForLoop: aViennaNode [
	aViennaNode first = self oldName
		ifTrue: [ aViennaNode at: 1 put: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnInvariantInitialFunction: aViennaNode [

	aViennaNode first
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnIotaExpression: aViennaNode [

	aViennaNode first first
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnLambdaExpression: aViennaNode [

	aViennaNode first first
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnLetBeExpression: aViennaNode [

	aViennaNode first first
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnLetBeStatement: aViennaNode [

	aViennaNode first first
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnLetExpression: aViennaNode [

	aViennaNode first do: [ :localDef |
		| def |
		def := localDef valueDefinitionOrFunctionDefinition.
		def isViennaValueDefinitionNode ifTrue: [
			def pattern
				allDescendantsSuchThat: [ :node |
				node isViennaPatternIdentifierNode: self oldName ]
				do: [ :node | node identifier: self newName ] ].
		(def isViennaFunctionDefinitionNode and: [
			 def definition identifier = self oldName ]) ifTrue: [
			| functionDefinition |
			functionDefinition := def definition.
			functionDefinition identifier: self newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnLetStatement: aViennaNode [

	aViennaNode first do: [ :localDef |
		| def |
		def := localDef valueDefinitionOrFunctionDefinition.
		def isViennaValueDefinitionNode ifTrue: [
			def pattern
				allDescendantsSuchThat: [ :node |
				node isViennaPatternIdentifierNode: self oldName ]
				do: [ :node | node identifier: self newName ] ].
		(def isViennaFunctionDefinitionNode and: [
			 def definition identifier = self oldName ]) ifTrue: [
			| functionDefinition |
			functionDefinition := def definition.
			functionDefinition identifier: self newName ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnMapComprehension: aViennaNode [

	aViennaNode third do: [ :multiBind |
		multiBind first do: [ :pattern |
			pattern
				allDescendantsSuchThat: [ :node |
				node isViennaPatternIdentifierNode: self oldName ]
				do: [ :node | node identifier: self newName ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnSequenceComprehension: aViennaNode [

	aViennaNode second first
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnSequenceForLoop: aViennaNode [

	aViennaNode first
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnSetComprehension: aViennaNode [

	aViennaNode second do: [ :multiBind |
		multiBind first do: [ :pattern |
			pattern
				allDescendantsSuchThat: [ :node |
				node isViennaPatternIdentifierNode: self oldName ]
				do: [ :node | node identifier: self newName ] ] ]
]

{ #category : #operations }
ViennaRenameLocal >> executeOnSetForLoop: aViennaNode [

	aViennaNode first
		allDescendantsSuchThat: [ :node |
		node isViennaPatternIdentifierNode: self oldName ]
		do: [ :node | node identifier: self newName ]
]

{ #category : #accessing }
ViennaRenameLocal >> findDefinitionNode [
	| node |
	node := self scopeOf: ast.
	[ node ifNil: [ ^ nil ].
	self hasLocalBindingOf: self oldName in: node ]
		whileFalse: [ node := self scopeOf: (node parent ifNil: [ ^ nil ]) ].
	^ node
]

{ #category : #accessing }
ViennaRenameLocal >> findOldName [
	^ ast ifNotEmpty: #first
]

{ #category : #accessing }
ViennaRenameLocal >> sortingOrder [
	^ 1.2
]
