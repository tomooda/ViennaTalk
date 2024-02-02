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

	| args possibleReturnTypes |
	args := self arguments.
	possibleReturnTypes := Array streamContents: [ :stream |
		                       self function maximalType possibleTypesDo: [
			                       :functionType |
			                       [
			                       functionType isFunctionType ifTrue: [
				                       | paramTypes returnType |
				                       paramTypes := functionType argtypes.
				                       (paramTypes size = 1 and: [
					                        paramTypes first isUnitType ]) ifTrue: [
					                       paramTypes := #(  ) ].
				                       returnType := functionType returntype.
				                       paramTypes size = args size ifFalse: [
					                       ^ ViennaTypeError signal ].
				                       1 to: paramTypes size do: [ :i |
				                       (args at: i) typecheck: (paramTypes at: i) ].
				                       (aViennaType isCompatibleWith: returnType)
					                       ifFalse: [ ^ ViennaTypeError signal ].
				                       stream nextPut: returnType ].
			                       functionType isOperationType ifTrue: [
				                       | paramTypes returnType |
				                       paramTypes := functionType argtypes.
				                       (paramTypes size = 1 and: [
					                        paramTypes first isUnitType ]) ifTrue: [
					                       paramTypes := #(  ) ].
				                       returnType := functionType returntype.
				                       paramTypes size = args size ifFalse: [
					                       ^ ViennaTypeError signal ].
				                       1 to: paramTypes size do: [ :i |
				                       (args at: i) typecheck: (paramTypes at: i) ].
				                       (aViennaType isCompatibleWith: returnType)
					                       ifFalse: [ ^ ViennaTypeError signal ].
				                       stream nextPut: returnType ].
			                       functionType isMapType ifTrue: [
				                       | paramType returnType |
				                       paramType := functionType keytype.
				                       returnType := functionType valuetype.
				                       args size = 1 ifFalse: [
					                       ^ ViennaTypeError signal ].
				                       args first typecheck: paramType.
				                       (aViennaType isCompatibleWith: returnType)
					                       ifFalse: [ ^ ViennaTypeError signal ].
				                       stream nextPut: returnType ].
			                       functionType isSeqType ifTrue: [
				                       | returnType |
				                       returnType := functionType basetype.
				                       args size = 1 ifFalse: [
					                       ^ ViennaTypeError signal ].
				                       args first typecheck: ViennaType nat1.
				                       (aViennaType isCompatibleWith: returnType)
					                       ifFalse: [ ^ ViennaTypeError signal ].
				                       stream nextPut: returnType ] ]
				                       on: ViennaTypeError
				                       do: [ :ex |  ] ] ].
	possibleReturnTypes ifEmpty: [
		^ ViennaTypeError on: self signal: 'Not an applicable type' ].
	^ possibleReturnTypes size > 1
		  ifTrue: [ ViennaType union: possibleReturnTypes ]
		  ifFalse: [ possibleReturnTypes first ]
]
