Class {
	#name : #ViennaLetExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLetExpressionNode class >> localDefinitionList: aViennaLocalDefinitionListNode body: aViennaExpressionNode [

	^ self
		  localDefinitionList: aViennaLocalDefinitionListNode
		  expression: aViennaExpressionNode
]

{ #category : #'instance creation' }
ViennaLetExpressionNode class >> localDefinitionList: aViennaLocalDefinitionListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  localDefinitionList: aViennaLocalDefinitionListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaLetExpressionNode >> body [

	^ self expression
]

{ #category : #accessing }
ViennaLetExpressionNode >> body: aViennaExpressionNode [

	^ self expression: aViennaExpressionNode
]

{ #category : #'accessing-definitions' }
ViennaLetExpressionNode >> definitionOfLocalName: aString [

	self localDefinitionList do: [ :localDef |
		| def |
		def := localDef valueDefinitionOrFunctionDefinition.
		def isViennaValueDefinitionNode ifTrue: [
			def pattern
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ n ] ].
		(def isViennaFunctionDefinitionNode: aString) ifTrue: [
			^ def definition ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaLetExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaLetExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaLetExpressionNode >> formatWith: aViennaAbstractFormatter [

	| localDefinitionList expression |
	localDefinitionList := aViennaAbstractFormatter format:
		                       self localDefinitionList.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   indentString: 'let'
				   insertCrIfNeeded: localDefinitionList)
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: 'in'
				   insertCrIfNeeded: expression)
]

{ #category : #accessing }
ViennaLetExpressionNode >> isViennaLetExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaLetExpressionNode >> label [

	^ 'LetExpression'
]

{ #category : #accessing }
ViennaLetExpressionNode >> localDefinitionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaLetExpressionNode >> localDefinitionList: aViennaLocalDefinitionListNode [

	self at: 1 put: aViennaLocalDefinitionListNode
]

{ #category : #enumerating }
ViennaLetExpressionNode >> localDefinitionsDo: aBlock [

	self localDefinitionList do: [ :localDef |
		aBlock value: localDef first ]
]

{ #category : #'pretty printing' }
ViennaLetExpressionNode >> operatorPrecedence [

	^ 10
]
