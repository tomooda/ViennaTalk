Class {
	#name : #ViennaInmapTypeNode,
	#superclass : #ViennaAbstractMapTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaInmapTypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter inmapPrefix
	  , (aViennaAbstractFormatter format: self domainType) , ' '
	  , aViennaAbstractFormatter inmapInfix , ' '
	  , (aViennaAbstractFormatter format: self rangeType)
]

{ #category : #testing }
ViennaInmapTypeNode >> isViennaInmapTypeNode [

	^ true
]

{ #category : #accessing }
ViennaInmapTypeNode >> label [

	^ 'InmapType'
]
