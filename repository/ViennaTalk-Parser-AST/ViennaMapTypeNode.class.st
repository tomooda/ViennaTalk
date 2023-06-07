Class {
	#name : #ViennaMapTypeNode,
	#superclass : #ViennaAbstractMapTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMapTypeNode class >> domainType: aViennaTypeNode1 rangeType: aViennaTypeNode2 [

	^ (self new: 2)
		  domainType: aViennaTypeNode1;
		  rangeType: aViennaTypeNode2;
		  yourself
]

{ #category : #'pretty printing' }
ViennaMapTypeNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter mapPrefix
	  , (aViennaAbstractFormatter format: self domainType) , ' '
	  , aViennaAbstractFormatter mapInfix , ' '
	  , (aViennaAbstractFormatter format: self rangeType)
]

{ #category : #testing }
ViennaMapTypeNode >> isViennaMapTypeNode [

	^ true
]

{ #category : #accessing }
ViennaMapTypeNode >> label [

	^ 'MapType'
]

{ #category : #'pretty printing' }
ViennaMapTypeNode >> operatorPrecedence [

	^ 4
]
