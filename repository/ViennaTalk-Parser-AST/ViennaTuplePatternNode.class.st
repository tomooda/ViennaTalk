Class {
	#name : #ViennaTuplePatternNode,
	#superclass : #ViennaPatternNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTuplePatternNode class >> patternList: aViennaPatternListNode [

	^ (self new: 1)
		  patternList: aViennaPatternListNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTuplePatternNode >> formatWith: aViennaAbstractFormatter [

	| patternList |
	patternList := aViennaAbstractFormatter format: self patternList.
	^ 'mk_(' , ((aViennaAbstractFormatter needsIndent: patternList)
		   ifTrue: [
			   String cr , aViennaAbstractFormatter indent
			   , (aViennaAbstractFormatter indentString: patternList) ]
		   ifFalse: [ patternList ]) , ')'
]

{ #category : #testing }
ViennaTuplePatternNode >> isViennaTuplePatternNode [

	^ true
]

{ #category : #accessing }
ViennaTuplePatternNode >> label [

	^ 'TuplePattern'
]

{ #category : #accessing }
ViennaTuplePatternNode >> patternList [

	^ self at: 1
]

{ #category : #accessing }
ViennaTuplePatternNode >> patternList: aViennaPatternListNode [

	self at: 1 put: aViennaPatternListNode
]
