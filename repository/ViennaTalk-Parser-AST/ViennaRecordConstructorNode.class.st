Class {
	#name : #ViennaRecordConstructorNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaRecordConstructorNode class >> name: aViennaNameNode expressionList: aViennaExpressionListNode [

	^ (self new: 2)
		  name: aViennaNameNode;
		  expressionList: aViennaExpressionListNode;
		  yourself
]

{ #category : #accessing }
ViennaRecordConstructorNode >> expressionList [

	^ self at: 2
]

{ #category : #accessing }
ViennaRecordConstructorNode >> expressionList: aViennaExpressionListNode [

	self at: 2 put: aViennaExpressionListNode
]

{ #category : #'pretty printing' }
ViennaRecordConstructorNode >> formatWith: aViennaAbstractFormatter [

	| constructor expressionList |
	constructor := aViennaAbstractFormatter format: self name.
	expressionList := aViennaAbstractFormatter format:
		                  self expressionList.
	^ 'mk_' , constructor , '('
	  , ((aViennaAbstractFormatter needsIndent: expressionList)
			   ifTrue: [
				   String cr , aViennaAbstractFormatter indent
				   , (aViennaAbstractFormatter indentString: expressionList) ]
			   ifFalse: [ expressionList ]) , ')'
]

{ #category : #private }
ViennaRecordConstructorNode >> freeIdentifiersExcept: aSet do: aBlock [

	self name freeIdentifiersExcept: aSet do: aBlock.
	self expressionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaRecordConstructorNode >> isViennaRecordConstructorNode [

	^ true
]

{ #category : #accessing }
ViennaRecordConstructorNode >> label [

	^ 'RecordConstructor'
]

{ #category : #accessing }
ViennaRecordConstructorNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaRecordConstructorNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]

{ #category : #'as yet unclassified' }
ViennaRecordConstructorNode >> sliceWith: aViennaSlicer [

	aViennaSlicer onNode: self do: [
		aViennaSlicer write: self.
		self expressionList do: [ :expression |
			aViennaSlicer read: expression ] ].
	self expressionList reverseDo: [ :expression |
		expression sliceWith: aViennaSlicer ]
]
