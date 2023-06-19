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
ViennaParameterTypesNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #'pretty printing' }
ViennaParameterTypesNode >> formatWith: aViennaAbstractFormatter [

	^ '(' , (self patternTypePairList
		   ifNil: [ '' ]
		   ifNotNil: [ :node | aViennaAbstractFormatter format: node ])
	  , ')'
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
ViennaParameterTypesNode >> patternTypePairList [

	^ self at: 1
]

{ #category : #accessing }
ViennaParameterTypesNode >> patternTypePairList: aViennaPatternTypePairListNode [

	self at: 1 put: aViennaPatternTypePairListNode
]
