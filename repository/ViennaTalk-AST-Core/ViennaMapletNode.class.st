Class {
	#name : 'ViennaMapletNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaMapletNode class >> keyExpression: aViennaExpressionNode1 valueExpression: aViennaExpressionNode2 [

	^ (self new: 2)
		  keyExpression: aViennaExpressionNode1;
		  valueExpression: aViennaExpressionNode2;
		  yourself
]

{ #category : 'private' }
ViennaMapletNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'pretty printing' }
ViennaMapletNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self keyExpression)
		  infix: aViennaAbstractFormatter maplet
		  arg: (aViennaAbstractFormatter format: self valueExpression)
]

{ #category : 'private' }
ViennaMapletNode >> freeIdentifiersExcept: aSet do: aBlock [

	self keyExpression freeIdentifiersExcept: aSet do: aBlock.
	self valueExpression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaMapletNode >> isViennaMapletNode [

	^ true
]

{ #category : 'accessing' }
ViennaMapletNode >> keyExpression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaMapletNode >> keyExpression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'accessing' }
ViennaMapletNode >> label [

	^ 'Maplet'
]

{ #category : 'typechecking' }
ViennaMapletNode >> maximalType [

	^ self keyExpression typecheck mapTo: self valueExpression typecheck
]

{ #category : 'accessing' }
ViennaMapletNode >> valueExpression [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaMapletNode >> valueExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]
