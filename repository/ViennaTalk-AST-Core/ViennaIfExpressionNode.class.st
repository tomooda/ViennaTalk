Class {
	#name : #ViennaIfExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
	cond := aViennaAbstractFormatter format:
		        self conditionalExpressionList first condition.
	expr := aViennaAbstractFormatter format:
		        self conditionalExpressionList first expression.
	default := aViennaAbstractFormatter format: self expression.
	elseifs := aViennaAbstractFormatter formatAll:
		           self conditionalExpressionList asArray copyWithoutFirst.
	self first size = 1 ifTrue: [
		^ (aViennaAbstractFormatter needsIndent: cond ++ expr ++ default)
			  ifTrue: [
				  (aViennaAbstractFormatter
					   indentString: (aViennaAbstractFormatter keyword: 'if')
					   insertCr: cond) ++ aViennaAbstractFormatter cr
				  ++ (aViennaAbstractFormatter
						   indentString: (aViennaAbstractFormatter keyword: 'then')
						   insertCr: expr) ++ aViennaAbstractFormatter cr
				  ++ (aViennaAbstractFormatter
						   indentString: (aViennaAbstractFormatter keyword: 'else')
						   insertCr: default) ]
			  ifFalse: [
				  (aViennaAbstractFormatter keyword: 'if ') ++ cond
				  ++ (aViennaAbstractFormatter keyword: ' then ') ++ expr
				  ++ (aViennaAbstractFormatter keyword: ' else ') ++ default ] ].
	^ (aViennaAbstractFormatter
		   indentString: (aViennaAbstractFormatter keyword: 'if ') ++ cond
		   insertCr: (aViennaAbstractFormatter keyword: 'then ') ++ expr)
	  ++ aViennaAbstractFormatter cr
	  ++ (aViennaAbstractFormatter join: String cr withAll: elseifs)
	  ++ aViennaAbstractFormatter cr ++ (aViennaAbstractFormatter
		   indentString: (aViennaAbstractFormatter keyword: 'else')
		   insertCr: default)
]

{ #category : #private }
ViennaIfExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self conditionalExpressionList freeIdentifiersExcept: aSet do: aBlock.
	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaIfExpressionNode >> isViennaIfExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaIfExpressionNode >> label [

	^ 'IfExpression'
]

{ #category : #typechecking }
ViennaIfExpressionNode >> maximalType [

	^ self conditionalExpressionList typecheck
	  + self expression typecheck
]

{ #category : #typechecking }
ViennaIfExpressionNode >> maximalType: aViennaType [

	self conditionalExpressionList maximalType: aViennaType.
	self expression maximalType: aViennaType.
	super maximalType: aViennaType
]

{ #category : #'pretty printing' }
ViennaIfExpressionNode >> operatorPrecedence [

	^ 10
]
