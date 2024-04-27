Class {
	#name : #ViennaSeqConcPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaSeqConcPatternNode >> boundIdentifiersDo: aBlock [

	self do: [ :pattern | pattern boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaSeqConcPatternNode >> formatWith: aViennaAbstractFormatter [

	| patterns |
	patterns := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: ((aViennaAbstractFormatter anyNeedsIndent: patterns)
				   ifTrue: [
				   aViennaAbstractFormatter cr , aViennaAbstractFormatter concat ]
				   ifFalse: [ aViennaAbstractFormatter concat ])
		  withAll: patterns
]

{ #category : #private }
ViennaSeqConcPatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :pattern | pattern freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaSeqConcPatternNode >> isViennaSeqConcPatternNode [

	^ true
]

{ #category : #accessing }
ViennaSeqConcPatternNode >> label [

	^ 'SeqConcPattern'
]

{ #category : #typechecking }
ViennaSeqConcPatternNode >> maximalType [

	| basetype isSeq1 |
	basetype := ViennaType unit.
	isSeq1 := false.
	self do: [ :pattern |
		pattern typecheck possibleTypesDo: [ :type |
			type isSeqType ifTrue: [
				basetype := basetype + type basetype.
				isSeq1 := isSeq1 or: [ type isSeq1Type ] ].
			type isAnyType ifTrue: [ basetype := ViennaType any ] ] ].
	^ basetype ifNotUnit: [
		  isSeq1
			  ifTrue: [ basetype seq1 ]
			  ifFalse: [ basetype seq ] ]
]

{ #category : #typechecking }
ViennaSeqConcPatternNode >> maximalType: aViennaType [

	| type |
	type := ViennaType unit.
	aViennaType possibleTypesDo: [ :seqType |
		seqType isSeqType ifTrue: [ type := type + seqType ] ].
	self do: [ :pattern | pattern maximalType: type ].
	super maximalType: self maximalType
]
