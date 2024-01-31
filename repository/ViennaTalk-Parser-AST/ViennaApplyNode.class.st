Class {
	#name : #ViennaApplyNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaApplyNode class >> expression: aViennaExpressionNode argumentExpressionList: aViennaExpressionListNode [

	^ (self new: 2)
		  expression: aViennaExpressionNode;
		  argumentExpressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : #accessing }
ViennaApplyNode >> argumentExpressionList [

	^ self at: 2
]

{ #category : #accessing }
ViennaApplyNode >> argumentExpressionList: aViennaExpressionListNode [

	self at: 2 put: aViennaExpressionListNode
]

{ #category : #accessing }
ViennaApplyNode >> arguments [

	^ self argumentExpressionList asArray
]

{ #category : #accessing }
ViennaApplyNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaApplyNode >> expression: aString [

	self at: 1 put: aString
]

{ #category : #'pretty printing' }
ViennaApplyNode >> formatWith: aViennaAbstractFormatter [

	| expression args |
	expression := aViennaAbstractFormatter format: self expression.
	args := aViennaAbstractFormatter format: self argumentExpressionList.
	^ expression , '('
	  , ((aViennaAbstractFormatter needsIndent: expression , args)
			   ifTrue: [
				   String cr , aViennaAbstractFormatter indent
				   , (aViennaAbstractFormatter indentString: args) ]
			   ifFalse: [ args ]) , ')'
]

{ #category : #private }
ViennaApplyNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self argumentExpressionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaApplyNode >> function [

	^ self expression
]

{ #category : #'pretty printing' }
ViennaApplyNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #testing }
ViennaApplyNode >> isViennaApplyNode [

	^ true
]

{ #category : #accessing }
ViennaApplyNode >> label [

	^ 'Apply'
]

{ #category : #'pretty printing' }
ViennaApplyNode >> operatorPrecedence [

	^ 40
]

{ #category : #typechecking }
ViennaApplyNode >> typecheck: aViennaType [

	| functionType argumentTypes |
	functionType := self function type.
	argumentTypes := self arguments collect: #type.
	functionType isFunctionType ifTrue: [
		| paramTypes returnType |
		paramTypes := functionType argtypes.
		(paramTypes size = 1 and: [ paramTypes first isUnitType ]) ifTrue: [
			paramTypes := #(  ) ].
		returnType := functionType returntype.
		paramTypes size = argumentTypes size ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal:
					  'Wrong number of arguments: expected '
					  , paramTypes size printString , ' but given '
					  , argumentTypes size printString ].
		1 to: paramTypes size do: [ :i |
			((argumentTypes at: i) isCompatibleWith: (paramTypes at: i))
				ifFalse: [
					^ ViennaTypeError
						  on: self
						  signal: 'The types of the argument #' , i printString
							  , ' don''t agree: expected ' , (paramTypes at: i) printString
							  , ' but given ' , (argumentTypes at: i) printString ] ].
		(aViennaType isCompatibleWith: returnType) ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal:
					  'The return types don''t agree: expected '
					  , returnType printString , ' but given ' , aViennaType ].
		^ returnType ].
	functionType isOperationType ifTrue: [
		| paramTypes returnType |
		paramTypes := functionType argtypes.
		(paramTypes size = 1 and: [ paramTypes first isUnitType ]) ifTrue: [
			paramTypes := #(  ) ].
		returnType := functionType returntype.
		paramTypes size = argumentTypes size ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal:
					  'Wrong number of arguments: expected '
					  , paramTypes size printString , ' but given '
					  , argumentTypes size printString ].
		1 to: paramTypes size do: [ :i |
			((argumentTypes at: i) isCompatibleWith: (paramTypes at: i))
				ifFalse: [
					^ ViennaTypeError
						  on: self
						  signal: 'The types of the argument #' , i printString
							  , ' don''t agree: expected ' , (paramTypes at: i) printString
							  , ' but given ' , (argumentTypes at: i) printString ] ].
		(aViennaType isCompatibleWith: returnType) ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal:
					  'The return types don''t agree: expected '
					  , returnType printString , ' but given ' , aViennaType ].
		^ returnType ].
	functionType isMapType ifTrue: [
		| paramType returnType |
		paramType := functionType keytype.
		returnType := functionType valuetype.
		argumentTypes size = 1 ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal: 'Wrong number of arguments: expected 1 but given '
					  , argumentTypes size printString ].
		(argumentTypes first isCompatibleWith: paramType) ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal: 'The types of the argument don''t agree: expected '
					  , paramType printString , ' but given '
					  , argumentTypes first printString ].
		(aViennaType isCompatibleWith: returnType) ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal:
					  'The return types don''t agree: expected '
					  , returnType printString , ' but given ' , aViennaType ].
		^ returnType ].
	functionType isSeqType ifTrue: [
		| returnType |
		returnType := functionType basetype.
		argumentTypes size = 1 ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal: 'Wrong number of arguments: expected 1 but given '
					  , argumentTypes size printString ].
		argumentTypes first isRealType ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal:
					  'The types of the argument don''t agree: expected nat1 but given '
					  , argumentTypes first printString ].
		(aViennaType isCompatibleWith: returnType) ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal:
					  'The return types don''t agree: expected '
					  , returnType printString , ' but given ' , aViennaType ].
		^ returnType ].
	^ ViennaTypeError on: self function signal: 'Not applicable'
]
