Class {
	#name : #ViennaMapletListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMapletListNode >> formatWith: aViennaAbstractFormatter [

	| maplets |
	maplets := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: ',' , ((aViennaAbstractFormatter anyNeedsIndent: maplets)
				   ifTrue: [ String cr ]
				   ifFalse: [ String space ])
		  withAll: maplets
]

{ #category : #'as yet unclassified' }
ViennaMapletListNode >> isViennaMapletListNode [

	^ true
]

{ #category : #accessing }
ViennaMapletListNode >> label [

	^ 'MapletList'
]
