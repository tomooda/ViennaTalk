Class {
	#name : #ViennaIfStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
				  (aViennaAbstractFormatter
					   indentString: (aViennaAbstractFormatter keyword: 'if')
					   insertCr: cond) , String cr , (aViennaAbstractFormatter
					   indentString: (aViennaAbstractFormatter keyword: 'then')
					   insertCr: statement) , (default ifNil: [ '' ] ifNotNil: [
					   String cr , (aViennaAbstractFormatter
						    indentString: (aViennaAbstractFormatter keyword: 'else')
						    insertCr: default) ]) ]
			  ifFalse: [
				  (aViennaAbstractFormatter keyword: 'if ') , cond
				  , (aViennaAbstractFormatter keyword: ' then ') , statement
				  , (default
						   ifNil: [ '' ]
						   ifNotNil: [
						   (aViennaAbstractFormatter keyword: ' else ') , default ]) ] ].
	^ (aViennaAbstractFormatter
		   indentString: (aViennaAbstractFormatter keyword: 'if ') , cond
		   insertCr: (aViennaAbstractFormatter keyword: 'then ') , statement)
	  , String cr
	  , (aViennaAbstractFormatter join: String cr withAll: elseifs)
	  , (default ifNil: [ '' ] ifNotNil: [
			   String cr , (aViennaAbstractFormatter
				    indentString: (aViennaAbstractFormatter keyword: 'else')
				    insertCr: default) ])
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

{ #category : #typechecking }
ViennaIfStatementNode >> maximalType [

	^ self conditionalStatementList typecheck
	  + (self statement ifNotNil: #typecheck ifNil: [ ViennaType unit ])
]

{ #category : #accessing }
ViennaIfStatementNode >> statement [

	^ self at: 2
]

{ #category : #accessing }
ViennaIfStatementNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]
