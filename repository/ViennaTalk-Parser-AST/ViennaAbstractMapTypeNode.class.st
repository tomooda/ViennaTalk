Class {
	#name : #ViennaAbstractMapTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAbstractMapTypeNode class >> domainType: aViennaTypeNode1 rangeType: aViennaTypeNode2 [

	^ (self new: 2)
		  domainType: aViennaTypeNode1;
		  rangeType: aViennaTypeNode2;
		  yourself
]

{ #category : #testing }
ViennaAbstractMapTypeNode class >> isAbstract [

	^ self = ViennaAbstractMapTypeNode
]

{ #category : #accessing }
ViennaAbstractMapTypeNode >> domainType [

	^ self at: 1
]

{ #category : #accessing }
ViennaAbstractMapTypeNode >> domainType: aViennaTypeNode [

	self at: 1 put: aViennaTypeNode
]

{ #category : #'as yet unclassified' }
ViennaAbstractMapTypeNode >> isViennaAbstractMapTypeNode [

	^ true
]

{ #category : #'pretty printing' }
ViennaAbstractMapTypeNode >> operatorPrecedence [

	^ 4
]

{ #category : #accessing }
ViennaAbstractMapTypeNode >> rangeType [

	^ self at: 2
]

{ #category : #accessing }
ViennaAbstractMapTypeNode >> rangeType: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
