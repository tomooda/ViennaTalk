Class {
	#name : #ViennaMapletListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #private }
ViennaMapletListNode >> boundIdentifiersDo: aBlock [

	
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

{ #category : #private }
ViennaMapletListNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :maplet | maplet freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaMapletListNode >> isViennaMapletListNode [

	^ true
]

{ #category : #accessing }
ViennaMapletListNode >> label [

	^ 'MapletList'
]

{ #category : #typechecking }
ViennaMapletListNode >> maximalType [

	self do: #typecheck.
	^ (self
		   inject: ViennaType unit
		   into: [ :type :maplet | type + maplet keyExpression typecheck ])
		  mapTo: (self
				   inject: ViennaType unit
				   into: [ :type :maplet |
				   type + maplet valueExpression typecheck ])
]
