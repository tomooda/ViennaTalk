Class {
	#name : #ViennaMapDomainNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaMapDomainNode >> label [

	^ 'MapDomain'
]

{ #category : #'pretty printing' }
ViennaMapDomainNode >> operatorPrecedence [

	^ 36
]