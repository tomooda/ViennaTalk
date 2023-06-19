Class {
	#name : #ViennaSeqEnumPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaSeqEnumPatternNode >> boundIdentifiersInto: aSet [

	self do: [ :pattern | pattern boundIdentifiersInto: aSet ]
]

{ #category : #'pretty printing' }
ViennaSeqEnumPatternNode >> formatWith: aViennaAbstractFormatter [

	^ '[' , (aViennaAbstractFormatter
		   formatEnumerate: (aViennaAbstractFormatter formatAll: self)
		   ifEmpty: [ '' ]) , ']'
]

{ #category : #testing }
ViennaSeqEnumPatternNode >> isViennaSeqEnumPatternNode [

	^ true
]

{ #category : #accessing }
ViennaSeqEnumPatternNode >> label [

	^ 'SeqEnumPattern'
]
