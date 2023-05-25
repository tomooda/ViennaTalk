Class {
	#name : #ViennaMapDomainNode,
	#superclass : #ViennaUnaryOperatorExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapDomainNode >> formatOperatorWith: aViennaAbstractFormatter [

	^ 'dom'
]

{ #category : #testing }
ViennaMapDomainNode >> isViennaMapDomainNode [

	^ true
]

{ #category : #accessing }
ViennaMapDomainNode >> label [

	^ 'MapDomain'
]

{ #category : #'pretty printing' }
ViennaMapDomainNode >> operatorPrecedence [

	^ 36
]
