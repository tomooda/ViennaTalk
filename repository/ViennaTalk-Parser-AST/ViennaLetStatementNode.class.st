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

{ #category : #'accessing-definitions' }
ViennaLetStatementNode >> definitionOfLocalName: aString [

	self localDefinitionList do: [ :localDef |
		| def |
		def := localDef first.
		def label = 'ValueDefinition' ifTrue: [
			def first allDescendantsDo: [ :n |
				(n label = 'PatternIdentifier' and: [ n first = aString ])
					ifTrue: [ ^ n ] ] ].
		def label = 'FunctionDefinition' ifTrue: [
			def first first = aString ifTrue: [ ^ def first ] ] ]
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
