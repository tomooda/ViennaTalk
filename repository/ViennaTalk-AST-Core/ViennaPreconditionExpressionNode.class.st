Class {
	#name : 'ViennaPreconditionExpressionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaPreconditionExpressionNode >> formatWith: aViennaAbstractFormatter [

	| expressions |
	expressions := aViennaAbstractFormatter formatAll: self.
	^ (aViennaAbstractFormatter keyword: 'pre_') ++ '('
	  ++ ((aViennaAbstractFormatter anyNeedsIndent: expressions)
			   ifTrue: [
				   aViennaAbstractFormatter
					   join:
						   aViennaAbstractFormatter empty ++ ','
						   ++ aViennaAbstractFormatter cr
						   ++ aViennaAbstractFormatter indent
					   withAll: (expressions collect: [ :expression |
							    aViennaAbstractFormatter indentString: expression ]) ]
			   ifFalse: [
			   aViennaAbstractFormatter join: ', ' withAll: expressions ])
	  ++ ')'
]

{ #category : 'private' }
ViennaPreconditionExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :expression |
		expression freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaPreconditionExpressionNode >> isViennaPreconditionExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaPreconditionExpressionNode >> label [

	^ 'PreconditionExpression'
]

{ #category : 'typechecking' }
ViennaPreconditionExpressionNode >> maximalType [

	self do: [ :exp | exp typecheck ].
	^ ViennaType bool
]
