Class {
	#name : 'ViennaUnionTypeNode',
	#superclass : 'ViennaTypeNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'converting' }
ViennaUnionTypeNode >> asMaximalViennaType [

	^ ViennaType union: (self collect: #asMaximalViennaType)
]

{ #category : 'pretty printing' }
ViennaUnionTypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  formatEnumerate: (aViennaAbstractFormatter formatAll: self)
		  separator: ' |'
		  ifEmpty: [ aViennaAbstractFormatter empty ]
]

{ #category : 'private' }
ViennaUnionTypeNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :type | type freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaUnionTypeNode >> isViennaUnionTypeNode [

	^ true
]

{ #category : 'accessing' }
ViennaUnionTypeNode >> label [

	^ 'UnionType'
]

{ #category : 'pretty printing' }
ViennaUnionTypeNode >> operatorPrecedence [

	^ 2
]
