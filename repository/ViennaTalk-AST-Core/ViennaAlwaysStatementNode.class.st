Class {
	#name : 'ViennaAlwaysStatementNode',
	#superclass : 'ViennaStatementNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaAlwaysStatementNode class >> entailingStatement: aViennaStatementNode1 bodyStatement: aViennaStatement2 [

	^ (self new: 2)
		  entailingStatement: aViennaStatementNode1;
		  bodyStatement: aViennaStatement2;
		  yourself
]

{ #category : 'accessing' }
ViennaAlwaysStatementNode >> bodyStatement [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaAlwaysStatementNode >> bodyStatement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]

{ #category : 'accessing' }
ViennaAlwaysStatementNode >> entailingStatement [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaAlwaysStatementNode >> entailingStatement: aViennaStatementNode [

	self at: 1 put: aViennaStatementNode
]

{ #category : 'pretty printing' }
ViennaAlwaysStatementNode >> formatWith: aViennaAbstractFormatter [

	| entailingStatement statement |
	entailingStatement := aViennaAbstractFormatter format:
		                      self entailingStatement.
	statement := aViennaAbstractFormatter format: self bodyStatement.
	^ (aViennaAbstractFormatter needsIndent: entailingStatement)
		  ifTrue: [
			  (aViennaAbstractFormatter
				   indentString: (aViennaAbstractFormatter keyword: 'always')
				   insertCr: entailingStatement) ++ aViennaAbstractFormatter cr
			  ++ (aViennaAbstractFormatter
					   indentString: (aViennaAbstractFormatter keyword: 'in')
					   insertCr: statement) ]
		  ifFalse: [
			  aViennaAbstractFormatter
				  indentString:
					  (aViennaAbstractFormatter keyword: 'always ')
					  ++ entailingStatement
					  ++ (aViennaAbstractFormatter keyword: ' in')
				  insertCrIfNeeded: statement ]
]

{ #category : 'private' }
ViennaAlwaysStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self bodyStatement freeIdentifiersExcept: aSet do: aBlock.
	self entailingStatement freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'testing' }
ViennaAlwaysStatementNode >> isViennaAlwaysStatementNode [

	^ true
]

{ #category : 'accessing' }
ViennaAlwaysStatementNode >> label [

	^ 'AlwaysStatement'
]

{ #category : 'typechecking' }
ViennaAlwaysStatementNode >> maximalType [

	self entailingStatement typecheck.
	^ self bodyStatement typecheck
]
