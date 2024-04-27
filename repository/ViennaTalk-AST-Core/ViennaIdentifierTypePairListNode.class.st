Class {
	#name : #ViennaIdentifierTypePairListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #private }
ViennaIdentifierTypePairListNode >> boundIdentifiersDo: aBlock [

	1 to: self size by: 2 do: [ :index |
	aBlock cull: (self at: index) cull: self ]
]

{ #category : #'pretty printing' }
ViennaIdentifierTypePairListNode >> formatWith: aViennaAbstractFormatter [

	^ self
		  ifNotEmpty: [
			  | string |
			  string := ''.
			  1 to: self size - 2 by: 2 do: [ :index |
				  string := string
				            , (aViennaAbstractFormatter format: (self at: index))
				            , ':'
				            ,
				            (aViennaAbstractFormatter format: (self at: index + 1))
				            , ', ' ].
			  string
			  , (aViennaAbstractFormatter format: (self at: self size - 1))
			  , ':' , (aViennaAbstractFormatter format: (self at: self size)) ]
		  ifEmpty: [ '' ]
]

{ #category : #private }
ViennaIdentifierTypePairListNode >> freeIdentifiersExcept: aSet do: aBlock [

	2 to: self size by: 2 do: [ :index |
	(self at: index) freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #private }
ViennaIdentifierTypePairListNode >> identifiers [

	^ (1 to: self size by: 2) collect: [ :index |
		  (self at: index) identifier ]
]

{ #category : #testing }
ViennaIdentifierTypePairListNode >> isViennaIdentifierTypePairListNode [

	^ true
]

{ #category : #accessing }
ViennaIdentifierTypePairListNode >> label [

	^ 'IdentifierTypePairList'
]

{ #category : #private }
ViennaIdentifierTypePairListNode >> listDelimiter [

	^ ', '
]

{ #category : #typechecking }
ViennaIdentifierTypePairListNode >> maximalType [

	^ ViennaType product: ((1 to: self size by: 2) collect: [ :index |
			   | pattern type |
			   pattern := self at: index.
			   type := self at: index + 1.
			   pattern maximalType: type typecheck.
			   pattern typecheck ])
]

{ #category : #private }
ViennaIdentifierTypePairListNode >> patternIdentifiers [

	^ (1 to: self size by: 2) collect: [ :index | self at: index ]
]

{ #category : #accessing }
ViennaIdentifierTypePairListNode >> type [

	^ (((2 to: self size by: 2) collect: [ :index |
			    (self at: index) copyFragment ])
		   ifEmpty: [ ViennaUnitTypeNode new ]
		   ifNotEmpty: [ :types |
			   types size = 1
				   ifTrue: [ types first ]
				   ifFalse: [ ViennaProductTypeNode withAll: types ] ])
		  parent: parent;
		  yourself
]

{ #category : #private }
ViennaIdentifierTypePairListNode >> types [

	^ (2 to: self size by: 2) collect: [ :index | self at: index ]
]
