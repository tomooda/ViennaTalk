Class {
	#name : #ViennaDistributedSetIntersectionNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaDistributedSetIntersectionNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter dinter
]

{ #category : #accessing }
ViennaDistributedSetIntersectionNode >> isViennaDistributedSetIntersectionNode [

	^ true
]

{ #category : #accessing }
ViennaDistributedSetIntersectionNode >> label [

	^ 'DistributedSetIntersection'
]

{ #category : #'pretty printing' }
ViennaDistributedSetIntersectionNode >> operatorPrecedence [

	^ 36
]

{ #category : #typechecking }
ViennaDistributedSetIntersectionNode >> paramType [

	^ ViennaType any set set
]

{ #category : #typechecking }
ViennaDistributedSetIntersectionNode >> returnTypeFor: aViennaType [

	^ aViennaType basetype basetype set
]
