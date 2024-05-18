Class {
	#name : 'ViennaSetRangeExpressionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaSetRangeExpressionNode class >> startExpression: aViennaExpressionNode1 endExpression: aViennaExpressionNode2 [

	^ (self new: 2)
		  startExpression: aViennaExpressionNode1;
		  endExpression: aViennaExpressionNode2;
		  yourself
]

{ #category : 'accessing' }
ViennaSetRangeExpressionNode >> endExpression [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaSetRangeExpressionNode >> endExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : 'pretty printing' }
ViennaSetRangeExpressionNode >> formatWith: aViennaAbstractFormatter [

	| startExpression endExpression |
	startExpression := aViennaAbstractFormatter format:
		                   self startExpression.
	endExpression := aViennaAbstractFormatter format: self endExpression.
	^ aViennaAbstractFormatter
		  noIndentString:
		  aViennaAbstractFormatter empty ++ '{' ++ startExpression ++ ','
		  insertCrIfNeeded:
			  aViennaAbstractFormatter empty ++ aViennaAbstractFormatter dots
			  ++ ', ' ++ endExpression ++ '}'
]

{ #category : 'private' }
ViennaSetRangeExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self startExpression freeIdentifiersExcept: aSet do: aBlock.
	self endExpression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaSetRangeExpressionNode >> isViennaSetRangeExpressionNode [

	^ true
]

{ #category : 'accessing' }
ViennaSetRangeExpressionNode >> label [

	^ 'SetRangeExpression'
]

{ #category : 'typechecking' }
ViennaSetRangeExpressionNode >> maximalType [

	^ ((self startExpression typecheck: ViennaType real)
	   + (self endExpression typecheck: ViennaType real)) set
]

{ #category : 'typechecking' }
ViennaSetRangeExpressionNode >> maximalType: aViennaType [

	| basetype |
	aViennaType isAnyType
		ifTrue: [ basetype := ViennaType any ]
		ifFalse: [
			basetype := ViennaType unit.
			aViennaType
				possibleTypesSuchThat: #isSetType
				do: [ :setType | basetype := basetype + setType basetype ] ].
	self startExpression maximalType: basetype.
	self endExpression maximalType: basetype.
	super maximalType: aViennaType
]

{ #category : 'accessing' }
ViennaSetRangeExpressionNode >> startExpression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaSetRangeExpressionNode >> startExpression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]
