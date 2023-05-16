Class {
	#name : #ViennaMapEnumerationNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMapEnumerationNode class >> withAll: anArrayOfViennaMapletNode [

	| map |
	map := self new: anArrayOfViennaMapletNode size.
	1 to: anArrayOfViennaMapletNode size do: [ :index |
	map at: index put: (anArrayOfViennaMapletNode at: index) ].
	^ map
]

{ #category : #'pretty printing' }
ViennaMapEnumerationNode >> formatWith: aViennaAbstractFormatter [

	| elements |
	elements := aViennaAbstractFormatter formatAll: self.
	^ '{' , (aViennaAbstractFormatter
		   formatEnumerate: elements
		   ifEmpty: [ aViennaAbstractFormatter maplet ]) , '}'
]

{ #category : #accessing }
ViennaMapEnumerationNode >> label [

	^ 'MapEnumeration'
]
