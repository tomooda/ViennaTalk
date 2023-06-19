Class {
	#name : #ViennaExternalsNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaExternalsNode >> boundIdentifiersInto: aSet [

	self do: [ :node | node boundIdentifiersInto: aSet ]
]

{ #category : #'pretty printing' }
ViennaExternalsNode >> formatWith: aViennaAbstractFormatter [

	^ self asArray
		  inject: 'ext'
		  into: [ :str :node |
		  str , ' ' , (aViennaAbstractFormatter format: node) ]
]

{ #category : #testing }
ViennaExternalsNode >> isViennaExternalsNode [

	^ true
]

{ #category : #accessing }
ViennaExternalsNode >> label [

	^ 'Externals'
]
