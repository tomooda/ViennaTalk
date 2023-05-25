Class {
	#name : #ViennaIfExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaIfExpressionNode class >> conditionalExpressionList: aViennaConditionalExpressionListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  conditionalExpressionList: aViennaConditionalExpressionListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaIfExpressionNode >> conditionalExpressionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaIfExpressionNode >> conditionalExpressionList: aViennaConditionalExpressionListNode [

	self at: 1 put: aViennaConditionalExpressionListNode
]

{ #category : #accessing }
ViennaIfExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaIfExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaIfExpressionNode >> formatWith: aViennaAbstractFormatter [

	| cond expr default elseifs |
	cond := aViennaAbstractFormatter format: self first first first.
	expr := aViennaAbstractFormatter format: self first first second.
	default := aViennaAbstractFormatter format: self second.
	elseifs := aViennaAbstractFormatter formatAll:
		           self first asArray copyWithoutFirst.
	self first size = 1 ifTrue: [
		^ (aViennaAbstractFormatter needsIndent: cond , expr , default)
			  ifTrue: [
				  (aViennaAbstractFormatter indentString: 'if' insertCr: cond)
				  , String cr
				  , (aViennaAbstractFormatter indentString: 'then' insertCr: expr)
				  , String cr
				  ,
				  (aViennaAbstractFormatter indentString: 'else' insertCr: default) ]
			  ifFalse: [ 'if ' , cond , ' then ' , expr , ' else ' , default ] ].
	^ (aViennaAbstractFormatter
		   indentString: 'if ' , cond
		   insertCr: 'then ' , expr) , String cr
	  , (aViennaAbstractFormatter join: String cr withAll: elseifs)
	  , String cr
	  , (aViennaAbstractFormatter indentString: 'else' insertCr: default)
]

{ #category : #testing }
ViennaIfExpressionNode >> isViennaIfExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaIfExpressionNode >> label [

	^ 'IfExpression'
]

{ #category : #'pretty printing' }
ViennaIfExpressionNode >> operatorPrecedence [

	^ 10
]
