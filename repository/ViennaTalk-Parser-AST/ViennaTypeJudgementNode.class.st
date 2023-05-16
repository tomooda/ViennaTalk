Class {
	#name : #ViennaTypeJudgementNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeJudgementNode class >> expression: aViennaExpressionNode type: aViennaTypeNode [

	^ (self new: 2)
		  expression: aViennaExpressionNode;
		  type: aViennaTypeNode;
		  yourself
]

{ #category : #accessing }
ViennaTypeJudgementNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeJudgementNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaTypeJudgementNode >> formatWith: aViennaAbstractFormatter [

	| type expression |
	expression := aViennaAbstractFormatter format: self expression.
	type := aViennaAbstractFormatter format: self type.
	(aViennaAbstractFormatter needsIndent: expression , type) ifFalse: [
		^ 'is_(' , expression , ', ' , type , ')' ].
	^ 'is_(' , ((aViennaAbstractFormatter needsIndent: expression)
		   ifTrue: [
			   String cr , aViennaAbstractFormatter indent
			   , (aViennaAbstractFormatter indentString: expression) ]
		   ifFalse: [ expression ]) , ',' , String cr
	  , aViennaAbstractFormatter indent
	  , (aViennaAbstractFormatter indentString: type) , ')'
]

{ #category : #accessing }
ViennaTypeJudgementNode >> label [

	^ 'TypeJudgement'
]

{ #category : #accessing }
ViennaTypeJudgementNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaTypeJudgementNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
