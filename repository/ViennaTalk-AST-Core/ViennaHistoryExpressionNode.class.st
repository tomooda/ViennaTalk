Class {
	#name : 'ViennaHistoryExpressionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'testing' }
ViennaHistoryExpressionNode class >> isAbstract [

	^ self = ViennaHistoryExpressionNode
]

{ #category : 'accessing' }
ViennaHistoryExpressionNode >> expressionName [

	^ self subclassResponsibility
]

{ #category : 'pretty printing' }
ViennaHistoryExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty ++ self expressionName ++ '('
	  ++ (aViennaAbstractFormatter format: self nameList) ++ ')'
]

{ #category : 'private' }
ViennaHistoryExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self nameList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaHistoryExpressionNode >> isViennaHistoryExpressionNode [

	^ true
]

{ #category : 'typechecking' }
ViennaHistoryExpressionNode >> maximalType [

	^ ViennaType nat
]

{ #category : 'accessing' }
ViennaHistoryExpressionNode >> nameList [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaHistoryExpressionNode >> nameList: aViennaNameListNode [

	self at: 1 put: aViennaNameListNode
]
