Class {
	#name : #ViennaSeqEnumPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaSeqEnumPatternNode >> boundIdentifiersDo: aBlock [

	self do: [ :pattern | pattern boundIdentifiersDo: aBlock ]
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
