Class {
	#name : #ViennaMapOrSequenceReferenceNode,
	#superclass : #ViennaStateDesignatorNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMapOrSequenceReferenceNode class >> stateDesignator: aViennaStateDesignatorNode1 argumentExpression: aViennaExpressionNode2 [

	^ (self new: 2)
		  stateDesignator: aViennaStateDesignatorNode1;
		  argumentExpression: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> argumentExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> argumentExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaMapOrSequenceReferenceNode >> formatWith: aViennaAbstractFormatter [

	| ref arg |
	ref := aViennaAbstractFormatter format: self stateDesignator.
	arg := aViennaAbstractFormatter format: self argumentExpression.
	^ (aViennaAbstractFormatter needsIndent: ref , arg)
		  ifTrue: [
			  ref , String cr , aViennaAbstractFormatter indent
			  , (aViennaAbstractFormatter indentString: '(' , arg , ')') ]
		  ifFalse: [ ref , '(' , arg , ')' ]
]

{ #category : #private }
ViennaMapOrSequenceReferenceNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self argumentExpression freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #'pretty printing' }
ViennaMapOrSequenceReferenceNode >> ifAssociatesLeftDo: aBlock1 ifAssociatesRightDo: aBlock2 otherwise: aBlock3 [

	^ aBlock1 value
]

{ #category : #testing }
ViennaMapOrSequenceReferenceNode >> isAssignable [

	^ self stateDesignator isAssignable
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> isViennaMapOrSequenceReferenceNode [

	^ true
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> label [

	^ 'MapOrSequenceReference'
]

{ #category : #'accessing-definitions' }
ViennaMapOrSequenceReferenceNode >> localResolve [

	^ self stateDesignator localResolve
]

{ #category : #typechecking }
ViennaMapOrSequenceReferenceNode >> maximalType [

	^ (Array streamContents: [ :stream |
		   self stateDesignator typecheck possibleTypesDo: [ :designatorType |
			   [
			   designatorType isMapType ifTrue: [
				   | paramType returnType |
				   paramType := designatorType keytype.
				   returnType := designatorType valuetype.
				   self argumentExpression typecheck: paramType.
				   stream nextPut: returnType ].
			   designatorType isSeqType ifTrue: [
				   | returnType |
				   returnType := designatorType basetype.
				   self argumentExpression typecheck: ViennaType nat1.
				   stream nextPut: returnType ] ]
				   on: ViennaTypeError
				   do: [ :ex |  ] ] ])
		  ifNotEmpty: [ :types | ViennaType normalFormUnion: types ]
		  ifEmpty: [
		  ViennaTypeError on: self signal: 'Not an applicable type' ]
]

{ #category : #'pretty printing' }
ViennaMapOrSequenceReferenceNode >> operatorPrecedence [

	^ 31
]

{ #category : #'accessing-definitions' }
ViennaMapOrSequenceReferenceNode >> resolve [

	^ self stateDesignator resolve
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> stateDesignator [

	^ self at: 1
]

{ #category : #accessing }
ViennaMapOrSequenceReferenceNode >> stateDesignator: aViennaStateDesignatorNode [

	self at: 1 put: aViennaStateDesignatorNode
]
