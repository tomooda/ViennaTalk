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

{ #category : #testing }
ViennaTupleConstructorNode >> isViennaTupleConstructorNode [

	^ true
]

{ #category : #accessing }
ViennaTupleConstructorNode >> label [

	^ 'TupleConstructor'
]
