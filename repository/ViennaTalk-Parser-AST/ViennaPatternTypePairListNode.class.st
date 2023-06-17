Class {
	#name : #ViennaPatternTypePairListNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaPatternTypePairListNode >> formatWith: aViennaAbstractFormatter [

	| string |
	string := ''.
	self ifNotEmpty: [
		1 to: self size - 2 by: 2 do: [ :index |
			string := string
			          , (aViennaAbstractFormatter format: (self at: index))
			          , ':'
			          , (aViennaAbstractFormatter format: (self at: index + 1))
			          , ', ' ].
		string := string
		          ,
		          (aViennaAbstractFormatter format: (self at: self size - 1))
		          , ':'
		          , (aViennaAbstractFormatter format: (self at: self size)) ].
	^ string
]

{ #category : #testing }
ViennaPatternTypePairListNode >> isViennaPatternTypePairListNode [

	^ true
]

{ #category : #accessing }
ViennaPatternTypePairListNode >> label [

	^ 'PatternTypePairList'
]

{ #category : #accessing }
ViennaPatternTypePairListNode >> type [

	^ ((2 to: self size by: 2) collect: [ :index |
		   (self at: index) copyFragment ])
		  ifEmpty: [ ViennaUnitTypeNode new ]
		  ifNotEmpty: [ :types |
			  types size = 1
				  ifTrue: [ types first ]
				  ifFalse: [ ViennaProductTypeNode withAll: types ] ]
]
