Class {
	#name : #ViennaMapEnumerationNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapEnumerationNode >> formatWith: aViennaAbstractFormatter [

	| elements |
	elements := aViennaAbstractFormatter formatAll: self.
	^ '{' , (aViennaAbstractFormatter
		   formatEnumerate: elements
		   ifEmpty: [ aViennaAbstractFormatter maplet ]) , '}'
]

{ #category : #accessing }
ViennaMapEnumerationNode >> isViennaMapEnumerationNode [

	^ true
]

{ #category : #accessing }
ViennaMapEnumerationNode >> label [

	^ 'MapEnumeration'
]
