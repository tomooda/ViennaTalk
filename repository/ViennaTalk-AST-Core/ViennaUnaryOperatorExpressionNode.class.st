Class {
	#name : #ViennaUnaryOperatorExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaUnaryOperatorExpressionNode class >> expression: aViennaExpressionNode [

	^ (self new: 1)
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #testing }
ViennaUnaryOperatorExpressionNode class >> isAbstract [

	^ self = ViennaUnaryOperatorExpressionNode
]

{ #category : #accessing }
ViennaUnaryOperatorExpressionNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaUnaryOperatorExpressionNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaUnaryOperatorExpressionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ self subclassResponsibility
]

{ #category : #'pretty printing' }
ViennaUnaryOperatorExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ (self formatOperatorWith: aViennaAbstractFormatter)
	  ++ aViennaAbstractFormatter space
	  ++ (aViennaAbstractFormatter format: self expression)
]

{ #category : #private }
ViennaUnaryOperatorExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaUnaryOperatorExpressionNode >> isViennaUnaryOperatorExpressionNode [

	^ true
]

{ #category : #typechecking }
ViennaUnaryOperatorExpressionNode >> maximalType [

	^ ViennaType
		  normalFormUnion: (Array streamContents: [ :stream |
				   (self expression typecheck: self paramType) possibleTypesDo: [
					   :argtype |
					   ([ self returnTypeFor: argtype ]
						    on: ViennaTypeError
						    do: [ :ex | nil ]) ifNotNil: [ :type | stream nextPut: type ] ] ])
		  ifUnit: [ ViennaTypeError signalOn: self ]
]

{ #category : #typechecking }
ViennaUnaryOperatorExpressionNode >> paramType [

	^ self subclassResponsibility
]

{ #category : #typechecking }
ViennaUnaryOperatorExpressionNode >> returnTypeFor: aViennaType [

	^ self subclassResponsibility
]
