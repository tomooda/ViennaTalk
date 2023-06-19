Class {
	#name : #ViennaSetEnumPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaSetEnumPatternNode >> boundIdentifiersInto: aSet [

	self do: [ :pattern | pattern boundIdentifiersInto: aSet ]
]

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
