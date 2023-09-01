Class {
	#name : #ViennaExtractOperationFromLetStatement,
	#superclass : #ViennaExtract,
	#instVars : [
		'freeIdentifiers'
	],
	#category : #'ViennaTalk-Refactoring-Core'
}

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> arguments [

	^ ViennaExpressionListNode withAll:
		  (ast localDefinitionList collect: [ :localDef |
			   localDef expression ])
		  , (freeIdentifiers collect: [ :identifier |
				   ViennaLocalNameNode identifier: identifier ])
]

{ #category : #operations }
ViennaExtractOperationFromLetStatement >> check [

	| params |
	ast isViennaLetStatementNode ifFalse: [ ^ false ].
	params := ast localDefinitionList uniqueBoundIdentifiers
		          asOrderedCollection.
	ast localDefinitionList do: [ :localDef |
		localDef expression allDescendantsDo: [ :node |
			(node isViennaLocalNameNode and: [
				 params includes: node identifier ]) ifTrue: [ ^ false ] ] ].
	ast statement
		allDescendantsSuchThat: #isViennaReturnStatementNode
		do: [ :node | ^ false ].
	^ true
]

{ #category : #operations }
ViennaExtractOperationFromLetStatement >> execute [

	| module explicitOperationDefinition |
	self newName ifNil: [ ^ self ].
	module := ast module.
	freeIdentifiers := self ast uniqueFreeIdentifiers reject: [
		                   :identifier |
		                   (self ast resolveIdentifier: identifier)
			                   isViennaFieldNode ].
	self replaceNode: ast with: (ViennaCallStatementNode
			 name: (ViennaLocalNameNode identifier: self newName)
			 expressionList: self arguments).
	explicitOperationDefinition := ViennaExplicitOperationDefinitionNode
		                               access: ViennaAccessNode empty
		                               identifier: self newName
		                               type: self operationType
		                               parameters:
		                               self operationParametersList
		                               statement: self statement
		                               pre: nil
		                               post: nil.
	self addOperationDefinition: explicitOperationDefinition in: module.
	^ explicitOperationDefinition
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> findNewName [
	(UIManager default
		request: 'name of operation for ' , self ast source
		initialAnswer: '')
		ifNotNil: [ :ans | ans trim ifNotEmpty: [ :name | ^ name ] ].
	^ nil
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> name [

	^ 'Extract an operation '
	  , (newName ifNil: [ '' ] ifNotNil: [ newName , ' ' ])
	  , 'from let statement ' asText
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> newName [
	^ newName ifNil: [ newName := self findNewName ]
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> newName: aString [
	newName := aString
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> operationParametersList [

	^ ViennaParametersNode withAll:
		  (ast localDefinitionList collect: [ :localDef | localDef pattern ])
		  , (freeIdentifiers collect: [ :identifier |
				   ViennaPatternIdentifierNode identifier: identifier ])
]

{ #category : #'parsers-types' }
ViennaExtractOperationFromLetStatement >> operationType [

	^ ViennaOperationTypeNode
		  argumentType: ((self operationParametersList collect: [ :param |
				    ViennaBasicTypeNode any ])
				   ifNotEmpty: [ :paramTypes |
					   paramTypes size = 1
						   ifTrue: [ paramTypes first ]
						   ifFalse: [ ViennaProductTypeNode withAll: paramTypes ] ]
				   ifEmpty: [ ViennaUnitTypeNode new ])
		  returnType: ViennaUnitTypeNode new
]

{ #category : #accessing }
ViennaExtractOperationFromLetStatement >> sortingOrder [
	^ 2.57
]

{ #category : #'parsers-definitions' }
ViennaExtractOperationFromLetStatement >> statement [

	^ ast second
]
