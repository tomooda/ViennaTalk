Class {
	#name : #ViennaMapletNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMapletNode class >> keyExpression: aViennaExpressionNode1 valueExpression: aViennaExpressionNode2 [

	^ (self new: 2)
		  keyExpression: aViennaExpressionNode1;
		  valueExpression: aViennaExpressionNode2;
		  yourself
]

{ #category : #private }
ViennaMapletNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaMapletNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self keyExpression)
		  infix: aViennaAbstractFormatter maplet
		  arg: (aViennaAbstractFormatter format: self valueExpression)
]

{ #category : #testing }
ViennaMapletNode >> isViennaMapletNode [

	^ true
]

{ #category : #accessing }
ViennaMapletNode >> keyExpression [

	^ self at: 1
]

{ #category : #accessing }
ViennaMapletNode >> keyExpression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaMapletNode >> label [

	^ 'Maplet'
]

{ #category : #accessing }
ViennaMapletNode >> valueExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaMapletNode >> valueExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]
