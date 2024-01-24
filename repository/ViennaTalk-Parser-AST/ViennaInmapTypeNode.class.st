Class {
	#name : #ViennaInmapTypeNode,
	#superclass : #ViennaAbstractMapTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #converting }
ViennaInmapTypeNode >> asMaximalViennaType [

	^ self domainType asMaximalViennaType inmapTo:
		  self rangeType asMaximalViennaType
]

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
