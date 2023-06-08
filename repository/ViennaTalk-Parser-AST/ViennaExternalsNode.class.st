Class {
	#name : #ViennaExternalsNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaExternalsNode >> formatWith: aViennaAbstractFormatter [

	^ self asArray
		  inject: 'ext'
		  into: [ :str :node |
		  str , ' ' , (aViennaAbstractFormatter format: node) ]
]

{ #category : #'as yet unclassified' }
ViennaExternalsNode >> isViennaExternalsNode [

	^ true
]

{ #category : #accessing }
ViennaExternalsNode >> label [

	^ 'Externals'
]
