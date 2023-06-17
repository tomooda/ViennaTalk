Class {
	#name : #ViennaAccessNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAccessNode class >> pure [

	^ self with: 'pure'
]

{ #category : #'pretty printing' }
ViennaAccessNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #testing }
ViennaAccessNode >> isViennaAccessNode [

	^ true
]

{ #category : #accessing }
ViennaAccessNode >> label [

	^ 'Access'
]
