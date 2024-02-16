Class {
	#name : #ViennaSymbolicLiteralNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaSymbolicLiteralNode class >> string: aString [

	^ (self new: 1)
		  string: aString;
		  yourself
]

{ #category : #'pretty printing' }
ViennaSymbolicLiteralNode >> formatWith: aViennaAbstractFormatter [

	^ self string trim
]

{ #category : #private }
ViennaSymbolicLiteralNode >> freeIdentifiersExcept: aSet do: aBlock [
]

{ #category : #testing }
ViennaSymbolicLiteralNode >> isViennaSymbolicLiteralNode [

	^ true
]

{ #category : #testing }
ViennaSymbolicLiteralNode >> isViennaSymbolicLiteralNode: aString [

	^ aString = self string
]

{ #category : #accessing }
ViennaSymbolicLiteralNode >> label [

	^ 'SymbolicLiteral'
]

{ #category : #typechecking }
ViennaSymbolicLiteralNode >> maximalType [

	| literal |
	literal := self string.
	(literal = 'true' or: [ literal = 'false' ]) ifTrue: [
		^ ViennaType bool ].
	literal = 'nil' ifTrue: [ ^ ViennaType unit optional ].
	literal first = $' ifTrue: [ ^ ViennaType char ].
	literal first = $" ifTrue: [
		^ literal size > 2
			  ifTrue: [ ViennaType char seq1 ]
			  ifFalse: [ ViennaType unit seq ] ].
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

{ #category : #accessing }
ViennaSymbolicLiteralNode >> string [

	^ self at: 1
]

{ #category : #accessing }
ViennaSymbolicLiteralNode >> string: aString [

	self at: 1 put: aString
]
