Class {
	#name : #ViennaExternalsNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaExternalsNode >> boundIdentifiersDo: aBlock [

	self do: [ :node | node boundIdentifiersDo: aBlock ]
]

{ #category : #'pretty printing' }
ViennaExternalsNode >> formatWith: aViennaAbstractFormatter [

	^ self asArray
		  inject: 'ext'
		  into: [ :str :node |
		  str , ' ' , (aViennaAbstractFormatter format: node) ]
]

{ #category : #private }
ViennaExternalsNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :varInfo | varInfo freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaExternalsNode >> isViennaExternalsNode [

	^ true
]

{ #category : #accessing }
ViennaExternalsNode >> label [

	^ 'Externals'
]
