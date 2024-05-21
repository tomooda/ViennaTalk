Class {
	#name : 'ViennaSeqBindNode',
	#superclass : 'ViennaSetSeqBindNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaSeqBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self pattern)
		  infix: aViennaAbstractFormatter inseq
		  arg: (aViennaAbstractFormatter format: self expression)
]

{ #category : 'testing' }
ViennaSeqBindNode >> isViennaSeqBindNode [

	^ true
]

{ #category : 'accessing' }
ViennaSeqBindNode >> label [

	^ 'SeqBind'
]

{ #category : 'typechecking' }
ViennaSeqBindNode >> maximalType [

	| basetype |
	basetype := ViennaType unit.
	self expression typecheck possibleTypesDo: [ :type |
		type isSeqType ifTrue: [ basetype := basetype + type basetype ].
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

{ #category : 'typechecking' }
ViennaSeqBindNode >> maximalType: aViennaType [

	| basetype |
	basetype := ViennaType unit.
	self expression typecheck possibleTypesDo: [ :type |
		type isSeqType ifTrue: [ basetype := basetype + type basetype ].
		type isAnyType ifTrue: [ basetype := ViennaType any ] ].
	super maximalType: basetype & aViennaType
]
