Class {
	#name : #ViennaIdentifierTypePairListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

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

{ #category : #testing }
ViennaIdentifierTypePairListNode >> isViennaIdentifierTypePairListNode [

	^ true
]

{ #category : #accessing }
ViennaIdentifierTypePairListNode >> label [

	^ 'IdentifierTypePairList'
]

{ #category : #accessing }
ViennaIdentifierTypePairListNode >> type [

	^ ((2 to: self size by: 2) collect: [ :index |
		   (self at: index) copyFragment ])
		  ifEmpty: [ ViennaUnitTypeNode new ]
		  ifNotEmpty: [ :types |
			  types size = 1
				  ifTrue: [ types first ]
				  ifFalse: [ ViennaProductTypeNode withAll: types ] ]
]
