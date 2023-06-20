Class {
	#name : #ViennaMapEnumerationPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaMapEnumerationPatternNode >> boundIdentifiersDo: aBlock [

	self do: [ :mapletPattern |
		mapletPattern boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaMapEnumerationPatternNode >> formatWith: aViennaAbstractFormatter [

	^ '{' , (aViennaAbstractFormatter
		   formatEnumerate: (aViennaAbstractFormatter formatAll: self)
		   ifEmpty: [ aViennaAbstractFormatter maplet ]) , '}'
]

{ #category : #private }
ViennaMapEnumerationPatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :mapletPattern |
		mapletPattern freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaMapEnumerationPatternNode >> isViennaMapEnumerationPatternNode [

	^ true
]

{ #category : #accessing }
ViennaMapEnumerationPatternNode >> label [

	^ 'MapEnumerationPattern'
]
