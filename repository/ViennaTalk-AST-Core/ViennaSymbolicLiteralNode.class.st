Class {
	#name : 'ViennaSymbolicLiteralNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'accessing' }
ViennaSymbolicLiteralNode class >> string: aString [

	^ (self new: 1)
		  string: aString;
		  yourself
]

{ #category : 'pretty printing' }
ViennaSymbolicLiteralNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter literal: self string trim
]

{ #category : 'private' }
ViennaSymbolicLiteralNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : 'testing' }
ViennaSymbolicLiteralNode >> isViennaSymbolicLiteralNode [

	^ true
]

{ #category : 'testing' }
ViennaSymbolicLiteralNode >> isViennaSymbolicLiteralNode: aString [

	^ aString = self string
]

{ #category : 'accessing' }
ViennaSymbolicLiteralNode >> label [

	^ 'SymbolicLiteral'
]

{ #category : 'typechecking' }
ViennaSymbolicLiteralNode >> maximalType [

	| literal |
	maximalType ifNotNil: [ ^ maximalType ].
	literal := self string.
	(literal = 'true' or: [ literal = 'false' ]) ifTrue: [
		^ ViennaType bool ].
	literal = 'nil' ifTrue: [ ^ ViennaType unit optional ].
	literal first = $' ifTrue: [ ^ ViennaType char ].
	literal first = $" ifTrue: [
		^ literal size > 2
			  ifTrue: [ ViennaType char seq1 ]
			  ifFalse: [ ViennaType unit seq ] ].
	literal first = $< ifTrue: [
		^ ViennaType quote: (literal copyFrom: 2 to: literal size - 1) ].
	(literal first = $- or: [ literal first isDigit ]) ifTrue: [
		| num |
		num := literal asNumber.
		^ num isInteger
			  ifTrue: [
				  num > 0
					  ifTrue: [ ViennaType nat1 ]
					  ifFalse: [
						  num = 0
							  ifTrue: [ ViennaType nat ]
							  ifFalse: [ ViennaType int ] ] ]
			  ifFalse: [
				  num isFraction
					  ifTrue: [ ViennaType rat ]
					  ifFalse: [ ViennaType real ] ] ]
]

{ #category : 'accessing' }
ViennaSymbolicLiteralNode >> string [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaSymbolicLiteralNode >> string: aString [

	self at: 1 put: aString
]
