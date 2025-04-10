Class {
	#name : 'ViennaApplyNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaApplyNode class >> expression: aViennaExpressionNode argumentExpressionList: aViennaExpressionListNode [

	^ (self new: 2)
		  expression: aViennaExpressionNode;
		  argumentExpressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : 'accessing' }
ViennaApplyNode >> argumentExpressionList [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaApplyNode >> argumentExpressionList: aViennaExpressionListNode [

	self at: 2 put: aViennaExpressionListNode
]

{ #category : 'accessing' }
ViennaApplyNode >> arguments [

	^ self argumentExpressionList asArray
]

{ #category : 'accessing' }
ViennaApplyNode >> expression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaApplyNode >> expression: aString [

	self at: 1 put: aString
]

{ #category : 'pretty printing' }
ViennaApplyNode >> formatWith: aViennaAbstractFormatter [

	| expression args |
	expression := aViennaAbstractFormatter format: self expression.
	args := aViennaAbstractFormatter format: self argumentExpressionList.
	^ expression ++ '('
	  ++ ((aViennaAbstractFormatter needsIndent: expression ++ args)
			   ifTrue: [
				   aViennaAbstractFormatter cr ++ aViennaAbstractFormatter indent
				   ++ (aViennaAbstractFormatter indentString: args) ]
			   ifFalse: [ args ]) ++ ')'
]

{ #category : 'private' }
ViennaApplyNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self argumentExpressionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'accessing' }
ViennaApplyNode >> function [

	^ self expression
]

{ #category : 'pretty printing' }
ViennaApplyNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : 'testing' }
ViennaApplyNode >> isViennaApplyNode [

	^ true
]

{ #category : 'accessing' }
ViennaApplyNode >> label [

	^ 'Apply'
]

{ #category : 'typechecking' }
ViennaApplyNode >> maximalType [

	| args |
	maximalType ifNotNil: [ ^ maximalType ].
	args := self arguments.
	^ (Array streamContents: [ :stream |
		   self function typecheck possibleTypesDo: [ :functionType |
			   [
			   functionType isAnyType ifTrue: [
				   stream nextPut:
					   (ViennaType product: (args collect: #typecheck))
					   -> ViennaType any ].
			   functionType isFunctionType ifTrue: [
				   | paramTypes returnType |
				   paramTypes := functionType argtypes.
				   (paramTypes size = 1 and: [ paramTypes first isUnitType ])
					   ifTrue: [ paramTypes := #(  ) ].
				   returnType := functionType returntype.
				   paramTypes size = args size ifFalse: [
					   ^ ViennaTypeError signal ].
				   1 to: paramTypes size do: [ :i |
				   (args at: i) typecheck: (paramTypes at: i) ].
				   stream nextPut: returnType ].
			   functionType isOperationType ifTrue: [
				   | paramTypes returnType |
				   paramTypes := functionType argtypes.
				   (paramTypes size = 1 and: [ paramTypes first isUnitType ])
					   ifTrue: [ paramTypes := #(  ) ].
				   returnType := functionType returntype.
				   paramTypes size = args size ifFalse: [
					   ^ ViennaTypeError signal ].
				   1 to: paramTypes size do: [ :i |
				   (args at: i) typecheck: (paramTypes at: i) ].
				   stream nextPut: returnType ].
			   functionType isMapType ifTrue: [
				   | paramType returnType |
				   paramType := functionType keytype.
				   returnType := functionType valuetype.
				   args size = 1 ifFalse: [ ^ ViennaTypeError signal ].
				   args first typecheck: paramType.
				   stream nextPut: returnType ].
			   functionType isSeqType ifTrue: [
				   | returnType |
				   returnType := functionType basetype.
				   args size = 1 ifFalse: [ ^ ViennaTypeError signal ].
				   args first typecheck: ViennaType nat1.
				   stream nextPut: returnType ] ]
				   on: ViennaTypeError
				   do: [ :ex |  ] ] ])
		  ifNotEmpty: [ :types | ViennaType normalFormUnion: types ]
		  ifEmpty: [
		  ViennaTypeError on: self signal: 'Not an applicable type' ]
]

{ #category : 'pretty printing' }
ViennaApplyNode >> operatorPrecedence [

	^ 40
]
