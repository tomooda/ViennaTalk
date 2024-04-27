Class {
	#name : #ViennaTuplePatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaTuplePatternNode class >> patternList: aViennaPatternListNode [

	^ (self new: 1)
		  patternList: aViennaPatternListNode;
		  yourself
]

{ #category : #'instance creation' }
ViennaTuplePatternNode class >> withAll: aCollectionOfViennaPatternNode [

	^ self patternList:
		  (ViennaPatternListNode withAll: aCollectionOfViennaPatternNode)
]

{ #category : #private }
ViennaTuplePatternNode >> boundIdentifiersDo: aBlock [

	self patternList boundIdentifiersDo: aBlock
]

{ #category : #'pretty printing' }
ViennaTuplePatternNode >> formatWith: aViennaAbstractFormatter [

	| patternList |
	patternList := aViennaAbstractFormatter format: self patternList.
	^ (aViennaAbstractFormatter keyword: 'mk_') , '('
	  , ((aViennaAbstractFormatter needsIndent: patternList)
			   ifTrue: [
				   String cr , aViennaAbstractFormatter indent
				   , (aViennaAbstractFormatter indentString: patternList) ]
			   ifFalse: [ patternList ]) , ')'
]

{ #category : #private }
ViennaTuplePatternNode >> freeIdentifiersExcept: aSet do: aBlock [

	self patternList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaTuplePatternNode >> isViennaTuplePatternNode [

	^ true
]

{ #category : #accessing }
ViennaTuplePatternNode >> label [

	^ 'TuplePattern'
]

{ #category : #typechecking }
ViennaTuplePatternNode >> maximalType [

	^ ViennaType product: (self patternList collect: #typecheck)
]

{ #category : #typechecking }
ViennaTuplePatternNode >> maximalType: aViennaType [

	| arity types |
	arity := self patternList size.
	types := Array new: arity withAll: ViennaType unit.
	aViennaType possibleTypesDo: [ :type |
		(type isProductType and: [ type basetypes size = arity ]) ifTrue: [
			1 to: arity do: [ :index |
				types
					at: index
					put: (types at: index) + (type basetypes at: index) ] ] ].
	1 to: arity do: [ :index |
		(self patternList at: index) maximalType: (types at: index) ].
	^ super maximalType: self maximalType
]

{ #category : #accessing }
ViennaTuplePatternNode >> patternList [

	^ self at: 1
]

{ #category : #accessing }
ViennaTuplePatternNode >> patternList: aViennaPatternListNode [

	self at: 1 put: aViennaPatternListNode
]
