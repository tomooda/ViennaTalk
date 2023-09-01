Class {
	#name : #ViennaIfStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaIfStatementNode class >> conditionalStatementList: aViennaConditionalStatementListNode statement: aViennaStatementNode [

	^ (self new: 2)
		  conditionalStatementList: aViennaConditionalStatementListNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #accessing }
ViennaIfStatementNode >> conditionalStatementList [

	^ self at: 1
]

{ #category : #accessing }
ViennaIfStatementNode >> conditionalStatementList: aViennaConditionalStatementListNode [

	self at: 1 put: aViennaConditionalStatementListNode
]

{ #category : #'pretty printing' }
ViennaIfStatementNode >> formatWith: aViennaAbstractFormatter [

	| cond statement default elseifs |
	cond := aViennaAbstractFormatter format:
		        self conditionalStatementList first condition.
	statement := aViennaAbstractFormatter format:
		             self conditionalStatementList first statement.
	default := self statement ifNotNil: [
		           aViennaAbstractFormatter format: self statement ].
	elseifs := aViennaAbstractFormatter formatAll:
		           self conditionalStatementList asArray copyWithoutFirst.
	self conditionalStatementList size = 1 ifTrue: [
		^ (aViennaAbstractFormatter needsIndent:
			   cond , statement , (default ifNil: [ '' ]))
			  ifTrue: [
				  (aViennaAbstractFormatter indentString: 'if' insertCr: cond)
				  , String cr
				  ,
				  (aViennaAbstractFormatter
					   indentString: 'then'
					   insertCr: statement) , (default ifNil: [ '' ] ifNotNil: [
					   String cr
					   ,
					   (aViennaAbstractFormatter
						    indentString: 'else'
						    insertCr: default) ]) ]
			  ifFalse: [
				  'if ' , cond , ' then ' , statement
				  , (default ifNil: [ '' ] ifNotNil: [ ' else ' , default ]) ] ].
	^ (aViennaAbstractFormatter
		   indentString: 'if ' , cond
		   insertCr: 'then ' , statement) , String cr
	  , (aViennaAbstractFormatter join: String cr withAll: elseifs)
	  , (default ifNil: [ '' ] ifNotNil: [
			   String cr
			   ,
			   (aViennaAbstractFormatter indentString: 'else' insertCr: default) ])
]

{ #category : #private }
ViennaIfStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self conditionalStatementList freeIdentifiersExcept: aSet do: aBlock.
	self statement freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaIfStatementNode >> isViennaIfStatementNode [

	^ true
]

{ #category : #accessing }
ViennaIfStatementNode >> label [

	^ 'IfStatement'
]

{ #category : #accessing }
ViennaIfStatementNode >> statement [

	^ self at: 2
]

{ #category : #accessing }
ViennaIfStatementNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]
