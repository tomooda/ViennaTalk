Class {
	#name : #ViennaOthersStatementNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaOthersStatementNode class >> statement: aViennaStatementNode [

	^ (self new: 1)
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #private }
ViennaOthersStatementNode >> boundIdentifiersDo: aBlock [

	
]

{ #category : #'pretty printing' }
ViennaOthersStatementNode >> formatWith: aViennaAbstractFormatter [

	| statement |
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'others ')
			  , aViennaAbstractFormatter arrow
		  insertCrIfNeeded: statement
]

{ #category : #private }
ViennaOthersStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self statement freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaOthersStatementNode >> isViennaOthersStatementNode [

	^ true
]

{ #category : #accessing }
ViennaOthersStatementNode >> label [

	^ 'OthersStatement'
]

{ #category : #typechecking }
ViennaOthersStatementNode >> maximalType [

	^ self statement typecheck
]

{ #category : #accessing }
ViennaOthersStatementNode >> statement [

	^ self at: 1
]

{ #category : #accessing }
ViennaOthersStatementNode >> statement: aViennaStatementNode [

	self at: 1 put: aViennaStatementNode
]
