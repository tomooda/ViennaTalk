Class {
	#name : 'ViennaLetStatementNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaLetStatementNode class >> localDefinitionList: aViennaLocalDefinitionListNode body: aViennaStatementNode [

	^ self
		  localDefinitionList: aViennaLocalDefinitionListNode
		  statement: aViennaStatementNode
]

{ #category : 'instance creation' }
ViennaLetStatementNode class >> localDefinitionList: aViennaLocalDefinitionListNode statement: aViennaStatementNode [

	^ (self new: 2)
		  localDefinitionList: aViennaLocalDefinitionListNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : 'accessing' }
ViennaLetStatementNode >> body [

	^ self statement
]

{ #category : 'accessing' }
ViennaLetStatementNode >> body: aViennaStatementNode [

	^ self statement: aViennaStatementNode
]

{ #category : 'accessing-definitions' }
ViennaLetStatementNode >> definitionOfLocalName: aString [

	self localDefinitionList do: [ :def |
		def isViennaValueDefinitionNode ifTrue: [
			def pattern
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ n ] ].
		(def isViennaFunctionDefinitionNode: aString) ifTrue: [ ^ def ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing-definitions' }
ViennaLetStatementNode >> findResolverForIdentifier: aString [

	^ (self localDefinitionList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaLetStatementNode >> formatWith: aViennaAbstractFormatter [

	| localDefinitionList statement |
	localDefinitionList := aViennaAbstractFormatter format:
		                       self localDefinitionList.
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'let')
				   insertCrIfNeeded: localDefinitionList)
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'in')
				   insertCrIfNeeded: statement)
]

{ #category : 'private' }
ViennaLetStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet
	                    , self localDefinitionList uniqueBoundIdentifiers.
	self localDefinitionList
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock.
	self statement freeIdentifiersExcept: boundIdentifiers do: aBlock
]

{ #category : 'testing' }
ViennaLetStatementNode >> hasScope [

	^ true
]

{ #category : 'testing' }
ViennaLetStatementNode >> isViennaLetStatementNode [

	^ true
]

{ #category : 'accessing' }
ViennaLetStatementNode >> label [

	^ 'LetStatement'
]

{ #category : 'accessing' }
ViennaLetStatementNode >> localDefinitionList [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaLetStatementNode >> localDefinitionList: aViennaLocalDefinitionListNode [

	self at: 1 put: aViennaLocalDefinitionListNode
]

{ #category : 'enumerating' }
ViennaLetStatementNode >> localDefinitionsDo: aBlock [

	self localDefinitionList do: aBlock
]

{ #category : 'accessing-definitions' }
ViennaLetStatementNode >> lookupIdentifier: aString [

	self localDefinitionList do: [ :localDefinition |
		(localDefinition bindsIdentifier: aString) ifTrue: [
			^ localDefinition ] ].
	^ nil
]

{ #category : 'typechecking' }
ViennaLetStatementNode >> maximalType [

	self localDefinitionList typecheck.
	^ self body typecheck
]

{ #category : 'accessing' }
ViennaLetStatementNode >> statement [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaLetStatementNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]
