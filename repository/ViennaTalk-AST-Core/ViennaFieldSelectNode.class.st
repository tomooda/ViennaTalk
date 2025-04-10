Class {
	#name : 'ViennaFieldSelectNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaFieldSelectNode class >> expression: aViennaExpression field: aString [

	^ (self new: 2)
		  expression: aViennaExpression;
		  field: aString;
		  yourself
]

{ #category : 'accessing' }
ViennaFieldSelectNode >> expression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaFieldSelectNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'accessing' }
ViennaFieldSelectNode >> field [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaFieldSelectNode >> field: aString [

	self at: 2 put: aString
]

{ #category : 'pretty printing' }
ViennaFieldSelectNode >> formatWith: aViennaAbstractFormatter [

	| record field |
	record := aViennaAbstractFormatter format: self expression.
	field := aViennaAbstractFormatter format: self field.
	^ aViennaAbstractFormatter empty ++ record ++ '.' ++ field
]

{ #category : 'private' }
ViennaFieldSelectNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'pretty printing' }
ViennaFieldSelectNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : 'accessing' }
ViennaFieldSelectNode >> isViennaFieldSelectNode [

	^ true
]

{ #category : 'accessing' }
ViennaFieldSelectNode >> label [

	^ 'FieldSelect'
]

{ #category : 'accessing' }
ViennaFieldSelectNode >> maximalType [

	| type |
	maximalType ifNotNil: [ ^ maximalType ].
	type := ViennaType unit.
	self expression typecheck possibleTypesDo: [ :basetype |
		basetype isCompositeType ifTrue: [
			basetype fieldsDo: [ :f :e :t |
				f = self field ifTrue: [ type := type + t ] ] ] ].
	^ type ifUnit: [
		  ViennaTypeError
			  on: self
			  signal: 'The field ' , self field , ' is not accessible' ]
]

{ #category : 'pretty printing' }
ViennaFieldSelectNode >> operatorPrecedence [

	^ 40
]
