Class {
	#name : #ViennaMapletListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaMapletListNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaMapletListNode >> formatWith: aViennaAbstractFormatter [

	| maplets |
	maplets := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  join: aViennaAbstractFormatter empty ++ ','
			  ++ ((aViennaAbstractFormatter anyNeedsIndent: maplets)
					   ifTrue: [ aViennaAbstractFormatter cr ]
					   ifFalse: [ aViennaAbstractFormatter space ])
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

{ #category : #private }
ViennaMapletListNode >> listDelimiter [

	^ ', '
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
