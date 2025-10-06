Class {
	#name : 'ViennaBinaryOperatorExpressionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaBinaryOperatorExpressionNode class >> expression: aViennaExpressionNode1 expression: aViennaExpressionNode2 [

	^ (self new: 2)
		  expression1: aViennaExpressionNode1;
		  expression2: aViennaExpressionNode2;
		  yourself
]

{ #category : 'testing' }
ViennaBinaryOperatorExpressionNode class >> isAbstract [

	^ self = ViennaBinaryOperatorExpressionNode
]

{ #category : 'accessing' }
ViennaBinaryOperatorExpressionNode >> expression1 [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaBinaryOperatorExpressionNode >> expression1: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'accessing' }
ViennaBinaryOperatorExpressionNode >> expression2 [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaBinaryOperatorExpressionNode >> expression2: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : 'pretty printing' }
ViennaBinaryOperatorExpressionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ self subclassResponsibility
]

{ #category : 'pretty printing' }
ViennaBinaryOperatorExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self expression1)
		  infix: (self formatOperatorWith: aViennaAbstractFormatter)
		  arg: (aViennaAbstractFormatter format: self expression2)
]

{ #category : 'private' }
ViennaBinaryOperatorExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression1 freeIdentifiersExcept: aSet do: aBlock.
	self expression2 freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaBinaryOperatorExpressionNode >> isViennaBinaryOperatorExpression [

	^ true
]

{ #category : 'testing' }
ViennaBinaryOperatorExpressionNode >> isViennaBinaryOperatorExpressionNode [

	^ true
]

{ #category : 'typechecking' }
ViennaBinaryOperatorExpressionNode >> maximalType [

	^ ViennaType
		  normalFormUnion: (Array streamContents: [ :stream |
				   (self expression1 typecheck: self paramType1) possibleTypesDo: [
					   :type1 |
					   (self expression2 typecheck: self paramType2)
						   possibleTypesDo: [ :type2 |
							   ([ self returnTypeFor: type1 and: type2 ]
								    on: ViennaTypeError
								    do: [ :ex | nil ]) ifNotNil: [ :type |
								   stream nextPut: type ] ] ] ])
		  ifUnit: [ ViennaTypeError signalOn: self ]
]

{ #category : 'accessing' }
ViennaBinaryOperatorExpressionNode >> paramType1 [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaBinaryOperatorExpressionNode >> paramType2 [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
ViennaBinaryOperatorExpressionNode >> returnTypeFor: aViennaType1 and: aViennaType2 [

	^ self subclassResponsibility
]

{ #category : 'typechecking' }
ViennaBinaryOperatorExpressionNode >> subexpressionsDo: aBlock [

	aBlock
		value: self expression1;
		value: self expression2
]
