Class {
	#name : #ViennaLetStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLetStatementNode class >> localDefinitionList: aViennaLocalDefinitionListNode statement: aViennaStatementNode [

	^ (self new: 2)
		  localDefinitionList: aViennaLocalDefinitionListNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #accessing }
ViennaLetStatementNode >> body [

	^ self statement
]

{ #category : #accessing }
ViennaLetStatementNode >> body: aViennaStatementNode [

	^ self statement: aViennaStatementNode
]

{ #category : #'accessing-definitions' }
ViennaLetStatementNode >> definitionOfLocalName: aString [

	self localDefinitionList do: [ :localDef |
		| def |
		def := localDef first.
		def isViennaValueDefinitionNode ifTrue: [
			def pattern
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ n ] ].
		(def isViennaFunctionDefinitionNode: aString) ifTrue: [
			^ def definition ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'pretty printing' }
ViennaLetStatementNode >> formatWith: aViennaAbstractFormatter [

	| localDefinitionList statement |
	localDefinitionList := aViennaAbstractFormatter format:
		                       self localDefinitionList.
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   indentString: 'let'
				   insertCrIfNeeded: localDefinitionList)
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: 'in'
				   insertCrIfNeeded: statement)
]

{ #category : #testing }
ViennaLetStatementNode >> isViennaLetStatementNode [

	^ true
]

{ #category : #accessing }
ViennaLetStatementNode >> label [

	^ 'LetStatement'
]

{ #category : #accessing }
ViennaLetStatementNode >> localDefinitionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaLetStatementNode >> localDefinitionList: aViennaLocalDefinitionListNode [

	self at: 1 put: aViennaLocalDefinitionListNode
]

{ #category : #accessing }
ViennaLetStatementNode >> statement [

	^ self at: 2
]

{ #category : #accessing }
ViennaLetStatementNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]
