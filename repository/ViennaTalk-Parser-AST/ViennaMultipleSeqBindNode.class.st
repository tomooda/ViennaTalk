Class {
	#name : #ViennaMultipleSeqBindNode,
	#superclass : #ViennaMultipleSetSeqBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMultipleSeqBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self patternList)
		  infix: aViennaAbstractFormatter inseq
		  arg: (aViennaAbstractFormatter format: self expression)
]

{ #category : #testing }
ViennaMultipleSeqBindNode >> isViennaMultipleSeqBindNode [

	^ true
]

{ #category : #accessing }
ViennaMultipleSeqBindNode >> label [

	^ 'MultipleSeqBind'
]

{ #category : #typechecking }
ViennaMultipleSeqBindNode >> maximalType [

	| basetype |
	basetype := ViennaType unit.
	self expression typecheck possibleTypesDo: [ :type |
		type isSeqType ifTrue: [ basetype := basetype + type basetype ].
		type isAnyType ifTrue: [ basetype := ViennaType any ] ].
	self patternsDo: [ :pattern |
		pattern maximalType: basetype.
		[ pattern typecheck: basetype ]
			on: ViennaTypeError
			do: [ :ex |
				ViennaTypeError
					on: self
					signal:
						'Bind mismatch: Pattern ' , pattern source , ' not agree with '
						, basetype printString ] ].
	^ basetype
]

{ #category : #typechecking }
ViennaMultipleSeqBindNode >> maximalType: aViennaType [

	| basetype |
	basetype := ViennaType unit.
	self expression typecheck possibleTypesDo: [ :type |
		type isSeqType ifTrue: [ basetype := basetype + type basetype ].
		type isAnyType ifTrue: [ basetype := ViennaType any ] ].
	super maximalType: basetype & aViennaType
]
