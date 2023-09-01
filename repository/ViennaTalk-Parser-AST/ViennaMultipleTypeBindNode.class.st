Class {
	#name : #ViennaMultipleTypeBindNode,
	#superclass : #ViennaMultipleBindNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMultipleTypeBindNode class >> patternList: aViennaPatternListNode type: aViennaTypeNode [

	^ (self new: 2)
		  patternList: aViennaPatternListNode;
		  type: aViennaTypeNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaMultipleTypeBindNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  print: (aViennaAbstractFormatter format: self patternList)
		  infix: ':'
		  arg: (aViennaAbstractFormatter format: self type)
]

{ #category : #private }
ViennaMultipleTypeBindNode >> freeIdentifiersExcept: aSet do: aBlock [

	self patternList freeIdentifiersExcept: aSet do: aBlock.
	self type freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaMultipleTypeBindNode >> isViennaMultipleTypeBindNode [

	^ true
]

{ #category : #accessing }
ViennaMultipleTypeBindNode >> label [

	^ 'MultipleTypeBind'
]

{ #category : #accessing }
ViennaMultipleTypeBindNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaMultipleTypeBindNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
