Class {
	#name : #ViennaSetEnumPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaSetEnumPatternNode >> formatWith: aViennaAbstractFormatter [

	^ '{' , (aViennaAbstractFormatter
		   formatEnumerate: (aViennaAbstractFormatter formatAll: self)
		   ifEmpty: [ '' ]) , '}'
]

{ #category : #testing }
ViennaSetEnumPatternNode >> isViennaSetEnumPatternNode [

	^ true
]

{ #category : #accessing }
ViennaSetEnumPatternNode >> label [

	^ 'SetEnumPattern'
]
