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

{ #category : #accessing }
ViennaSymbolicLiteralNode >> string [

	^ self at: 1
]

{ #category : #accessing }
ViennaSymbolicLiteralNode >> string: aString [

	self at: 1 put: aString
]

{ #category : #typechecking }
ViennaSymbolicLiteralNode >> typecheck: aViennaType [

	| literal |
	literal := self string.
	(literal = 'true' or: [ literal = 'false' ]) ifTrue: [
		(aViennaType isCompatibleWith: ViennaType bool) ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal: 'Type mismatch: ' , aViennaType printString
					  , ' expected, but bool given' ].
		^ ViennaType bool ].
	literal = 'nil' ifTrue: [
		(aViennaType isCompatibleWith: ViennaType unit optional) ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal: 'Type mismatch: ' , aViennaType printString
					  , ' expected, but nil given' ].
		^ ViennaType unit optional ].
	literal first = '''' ifTrue: [
		(aViennaType isCompatibleWith: ViennaType char) ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal: 'Type mismatch: ' , aViennaType printString
					  , ' expected, but char given' ].
		^ ViennaType char ].
	literal first = '"' ifTrue: [
		(aViennaType isCompatibleWith: ViennaType char seq) ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal: 'Type mismatch: ' , aViennaType printString
					  , ' expected, but seq of char given' ].
		^ ViennaType char seq ].
	(literal first = '-' or: [ literal first isDigit ]) ifTrue: [
		| num type |
		num := literal asNumber.
		type := num isInteger
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
					        ifFalse: [ ViennaType real ] ].
		(aViennaType isCompatibleWith: type) ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal:
					  'Type mismatch: ' , aViennaType printString , ' expected, but '
					  , type printString , ' given' ].
		^ type ]
]
