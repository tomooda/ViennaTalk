Class {
	#name : #ViennaMapletListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaMapletListNode >> boundIdentifiersInto: aSet [

	
]

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

{ #category : #testing }
ViennaMapletListNode >> isViennaMapletListNode [

	^ true
]

{ #category : #accessing }
ViennaMapletListNode >> label [

	^ 'MapletList'
]
