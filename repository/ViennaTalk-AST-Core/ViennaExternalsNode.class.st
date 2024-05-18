Class {
	#name : 'ViennaExternalsNode',
	#superclass : 'ViennaDefinitionComponentNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'private' }
ViennaExternalsNode >> boundIdentifiersDo: aBlock [

	self do: [ :node | node boundIdentifiersDo: aBlock ]
]

{ #category : 'pretty printing' }
ViennaExternalsNode >> formatWith: aViennaAbstractFormatter [

	^ self asArray
		  inject: (aViennaAbstractFormatter keyword: 'ext')
		  into: [ :str :node |
			  aViennaAbstractFormatter empty ++ str
			  ++ aViennaAbstractFormatter space
			  ++ (aViennaAbstractFormatter format: node) ]
]

{ #category : 'private' }
ViennaExternalsNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :varInfo | varInfo freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : 'testing' }
ViennaExternalsNode >> isViennaExternalsNode [

	^ true
]

{ #category : 'accessing' }
ViennaExternalsNode >> label [

	^ 'Externals'
]

{ #category : 'typechecking' }
ViennaExternalsNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
