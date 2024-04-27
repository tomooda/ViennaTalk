Class {
	#name : #ViennaSetBindNode,
	#superclass : #ViennaSetSeqBindNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaSetBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self pattern)
		  infix: aViennaAbstractFormatter inset
		  arg: (aViennaAbstractFormatter format: self expression)
]

{ #category : #testing }
ViennaSetBindNode >> isViennaSetBindNode [

	^ true
]

{ #category : #accessing }
ViennaSetBindNode >> label [

	^ 'SetBind'
]

{ #category : #typechecking }
ViennaSetBindNode >> maximalType [

	| basetype |
	basetype := ViennaType unit.
	self expression typecheck possibleTypesDo: [ :type |
		type isSetType ifTrue: [ basetype := basetype + type basetype ].
		type isAnyType ifTrue: [ basetype := ViennaType any ] ].
	self pattern maximalType: basetype.
	^ [ self pattern typecheck: basetype ]
		  on: ViennaTypeError
		  do: [ :ex |
			  ViennaTypeError
				  on: self
				  signal:
					  'Bind mismatch: Pattern ' , self pattern source
					  , ' not agree with ' , basetype printString ]
]

{ #category : #typechecking }
ViennaSetBindNode >> maximalType: aViennaType [

	| basetype |
	basetype := ViennaType unit.
	self expression typecheck possibleTypesDo: [ :type |
		type isSetType ifTrue: [ basetype := basetype + type basetype ].
		type isAnyType ifTrue: [ basetype := ViennaType any ] ].
	super maximalType: basetype & aViennaType
]
