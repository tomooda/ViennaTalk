Class {
	#name : #ViennaMultipleSetBindNode,
	#superclass : #ViennaMultipleSetSeqBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMultipleSetBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self patternList)
		  infix: aViennaAbstractFormatter inset
		  arg: (aViennaAbstractFormatter format: self expression)
]

{ #category : #testing }
ViennaMultipleSetBindNode >> isViennaMultipleSetBindNode [

	^ true
]

{ #category : #accessing }
ViennaMultipleSetBindNode >> label [

	^ 'MultipleSetBind'
]

{ #category : #typechecking }
ViennaMultipleSetBindNode >> maximalType [

	| basetype |
	basetype := ViennaType unit.
	self expression typecheck possibleTypesDo: [ :type |
		type isSetType ifTrue: [ basetype := basetype + type basetype ].
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
ViennaMultipleSetBindNode >> maximalType: aViennaType [

	| basetype |
	basetype := ViennaType unit.
	self expression typecheck possibleTypesDo: [ :type |
		type isSetType ifTrue: [ basetype := basetype + type basetype ].
		type isAnyType ifTrue: [ basetype := ViennaType any ] ].
	super maximalType: basetype & aViennaType
]
