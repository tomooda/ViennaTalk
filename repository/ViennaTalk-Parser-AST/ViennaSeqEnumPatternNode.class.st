Class {
	#name : #ViennaSeqEnumPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

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
