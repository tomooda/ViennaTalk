Class {
	#name : 'ViennaSeqEnumPatternNode',
	#superclass : 'ViennaPatternNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaSeqEnumPatternNode >> boundIdentifiersDo: aBlock [

	self do: [ :pattern | pattern boundIdentifiersDo: aBlock ]
]

{ #category : 'pretty printing' }
ViennaSeqEnumPatternNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter empty ++ '[' ++ (aViennaAbstractFormatter
		   formatEnumerate: (aViennaAbstractFormatter formatAll: self)
		   ifEmpty: [ aViennaAbstractFormatter empty ]) ++ ']'
]

{ #category : 'private' }
ViennaSeqEnumPatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :pattern | pattern freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaSeqEnumPatternNode >> isViennaSeqEnumPatternNode [

	^ true
]

{ #category : 'accessing' }
ViennaSeqEnumPatternNode >> label [

	^ 'SeqEnumPattern'
]

{ #category : 'typechecking' }
ViennaSeqEnumPatternNode >> maximalType [

	^ self
		  ifNotEmpty: [
			  | basetype |
			  basetype := ViennaType unit.
			  self do: [ :pattern |
				  pattern typecheck possibleTypesDo: [ :type |
					  basetype := basetype + type ] ].
			  basetype ifNotUnit: #seq1 ]
		  ifEmpty: [ ViennaType unit seq ]
]

{ #category : 'typechecking' }
ViennaSeqEnumPatternNode >> maximalType: aViennaType [

	| basetype |
	basetype := ViennaType unit.
	aViennaType possibleTypesDo: [ :type |
		type isSeqType ifTrue: [ basetype := basetype + type basetype ] ].
	self do: [ :pattern | pattern maximalType: basetype ].
	super maximalType: self maximalType
]
