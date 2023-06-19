Class {
	#name : #ViennaMapEnumerationPatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaMapEnumerationPatternNode >> boundIdentifiersInto: aSet [

	self do: [ :mapletPattern | mapletPattern boundIdentifiersInto: aSet ]
]

{ #category : #'pretty printing' }
ViennaMapEnumerationPatternNode >> formatWith: aViennaAbstractFormatter [

	^ '{' , (aViennaAbstractFormatter
		   formatEnumerate: (aViennaAbstractFormatter formatAll: self)
		   ifEmpty: [ aViennaAbstractFormatter maplet ]) , '}'
]

{ #category : #testing }
ViennaMapEnumerationPatternNode >> isViennaMapEnumerationPatternNode [

	^ true
]

{ #category : #accessing }
ViennaMapEnumerationPatternNode >> label [

	^ 'MapEnumerationPattern'
]
