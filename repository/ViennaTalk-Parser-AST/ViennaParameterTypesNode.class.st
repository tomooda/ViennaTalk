Class {
	#name : #ViennaParameterTypesNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaParameterTypesNode class >> patternTypePairList: aViennaPatternTypePairListNode [

	^ (self new: 1)
		  patternTypePairList: aViennaPatternTypePairListNode;
		  yourself
]

{ #category : #private }
ViennaParameterTypesNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaParameterTypesNode >> formatWith: aViennaAbstractFormatter [

	^ '(' , (self patternTypePairList
		   ifNil: [ '' ]
		   ifNotNil: [ :node | aViennaAbstractFormatter format: node ])
	  , ')'
]

{ #category : #accessing }
ViennaParameterTypesNode >> freeIdentifiersExcept: aSet do: aBlock [

	self patternTypePairList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaParameterTypesNode >> isViennaParameterTypesNode [

	^ true
]

{ #category : #accessing }
ViennaParameterTypesNode >> label [

	^ 'ParameterTypes'
]

{ #category : #accessing }
ViennaParameterTypesNode >> parameters [

	^ self patternTypePairList parameters
]

{ #category : #accessing }
ViennaParameterTypesNode >> patternTypePairList [

	^ self at: 1
]

{ #category : #accessing }
ViennaParameterTypesNode >> patternTypePairList: aViennaPatternTypePairListNode [

	self at: 1 put: aViennaPatternTypePairListNode
]

{ #category : #enumerating }
ViennaParameterTypesNode >> patternsDo: aBlock [

	self patternTypePairList patternsDo: aBlock
]

{ #category : #accessing }
ViennaParameterTypesNode >> type [

	^ self patternTypePairList type
]
