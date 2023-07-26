Class {
	#name : #ViennaTupleConstructorNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTupleConstructorNode class >> expressionList: aViennaExpressionListNode [

	^ (self new: 1)
		  expressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : #accessing }
ViennaTupleConstructorNode >> expressionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaTupleConstructorNode >> expressionList: aViennaExpressionListNode [

	self at: 1 put: aViennaExpressionListNode
]

{ #category : #'pretty printing' }
ViennaTupleConstructorNode >> formatWith: aViennaAbstractFormatter [

	| expressionList |
	expressionList := aViennaAbstractFormatter format:
		                  self expressionList.
	^ 'mk_(' , ((aViennaAbstractFormatter needsIndent: expressionList)
		   ifTrue: [
			   String cr , aViennaAbstractFormatter indent
			   , (aViennaAbstractFormatter indentString: expressionList) ]
		   ifFalse: [ expressionList ]) , ')'
]

{ #category : #private }
ViennaTupleConstructorNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expressionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaTupleConstructorNode >> isViennaTupleConstructorNode [

	^ true
]

{ #category : #accessing }
ViennaTupleConstructorNode >> label [

	^ 'TupleConstructor'
]

{ #category : #'as yet unclassified' }
ViennaTupleConstructorNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self expressionList reverseDo: [ :expression |
			aViennaSlicer read: expression ] ].
	self expressionList reverseDo: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
