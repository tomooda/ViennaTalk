Class {
	#name : #ViennaCallStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaCallStatementNode class >> name: aViennaNameNode expressionList: aViennaExpressionListNode [

	^ (self new: 2)
		  name: aViennaNameNode;
		  expressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : #accessing }
ViennaCallStatementNode >> expressionList [

	^ self at: 2
]

{ #category : #accessing }
ViennaCallStatementNode >> expressionList: aViennaExpressionListNode [

	self at: 2 put: aViennaExpressionListNode
]

{ #category : #'pretty printing' }
ViennaCallStatementNode >> formatWith: aViennaAbstractFormatter [

	| args |
	args := aViennaAbstractFormatter format: self expressionList.
	^ (aViennaAbstractFormatter format: self name) , '('
	  , ((aViennaAbstractFormatter needsIndent: args)
			   ifTrue: [ aViennaAbstractFormatter newlineIndentString: args ]
			   ifFalse: [ args ]) , ')'
]

{ #category : #testing }
ViennaCallStatementNode >> isViennaCallStatementNode [

	^ true
]

{ #category : #accessing }
ViennaCallStatementNode >> label [

	^ 'CallStatement'
]

{ #category : #accessing }
ViennaCallStatementNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaCallStatementNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]
