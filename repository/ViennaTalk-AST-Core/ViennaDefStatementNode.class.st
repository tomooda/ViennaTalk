Class {
	#name : #ViennaDefStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaDefStatementNode class >> equalDefinitionList: aViennaEqualDefinitionListNode statement: aViennaStatementNode [

	^ (self new: 2)
		  equalDefinitionList: aViennaEqualDefinitionListNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaDefStatementNode >> definitionOfLocalName: aString [

	self equalDefinitionList reverseDo: [ :equalDefinition |
		equalDefinition first
			allDescendantsSuchThat: [ :n |
			n isViennaPatternIdentifierNode: aString ]
			do: [ :n | ^ n ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'accessing-definitions' }
ViennaDefStatementNode >> definitionOfLocalName: aString for: aViennaNode [

	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaDefStatementNode >> equalDefinitionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaDefStatementNode >> equalDefinitionList: aViennaEqualDefinitionListNode [

	^ self at: 1 put: aViennaEqualDefinitionListNode
]

{ #category : #'accessing-definitions' }
ViennaDefStatementNode >> findResolverForIdentifier: aString [

	^ (self equalDefinitionList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaDefStatementNode >> formatWith: aViennaAbstractFormatter [

	| equalDefinitionList statement |
	equalDefinitionList := aViennaAbstractFormatter format:
		                       self equalDefinitionList.
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'def')
				   insertCrIfNeeded: equalDefinitionList)
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'in')
				   insertCrIfNeeded: statement)
]

{ #category : #private }
ViennaDefStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self equalDefinitionList freeIdentifiersExcept: aSet do: aBlock.
	self statement
		freeIdentifiersExcept:
		aSet , self equalDefinitionList uniqueBoundIdentifiers
		do: aBlock
]

{ #category : #testing }
ViennaDefStatementNode >> isViennaDefStatementNode [

	^ true
]

{ #category : #accessing }
ViennaDefStatementNode >> label [

	^ 'DefStatement'
]

{ #category : #'accessing-definitions' }
ViennaDefStatementNode >> lookupIdentifier: aString [

	self equalDefinitionList do: [ :equalDefinition |
		(equalDefinition bindsIdentifier: aString) ifTrue: [
			^ equalDefinition ] ].
	^ nil
]

{ #category : #typechecking }
ViennaDefStatementNode >> maximalType [

	self equalDefinitionList do: [ :equalDef | equalDef typecheck ].
	^ self statement typecheck
]

{ #category : #accessing }
ViennaDefStatementNode >> statement [

	^ self at: 2
]

{ #category : #accessing }
ViennaDefStatementNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]
