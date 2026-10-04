Class {
	#name : 'ViennaAccessNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaAccessNode class >> pure [

	^ self with: 'pure'
]

{ #category : 'private' }
ViennaAccessNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : 'pretty printing' }
ViennaAccessNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: aViennaAbstractFormatter space
		  withAll: (self collect: [ :string | aViennaAbstractFormatter keyword: string ])
]

{ #category : 'private' }
ViennaAccessNode >> freeIdentifiersExcept: aSet do: aBlock [

	
]

{ #category : 'testing' }
ViennaAccessNode >> includes: aString [

	self do: [ :string | aString = string ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'testing' }
ViennaAccessNode >> isViennaAccessNode [

	^ true
]

{ #category : 'accessing' }
ViennaAccessNode >> label [

	^ 'Access'
]

{ #category : 'typechecking' }
ViennaAccessNode >> maximalType [

	^ ViennaType unit
]
