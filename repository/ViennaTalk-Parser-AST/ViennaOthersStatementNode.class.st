Class {
	#name : #ViennaOthersStatementNode,
	#superclass : #ViennaDefinitionComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaOthersStatementNode class >> statement: aViennaStatementNode [

	^ (self new: 1)
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #private }
ViennaOthersStatementNode >> boundIdentifiersInto: aSet [

	
]

{ #category : #'pretty printing' }
ViennaOthersStatementNode >> formatWith: aViennaAbstractFormatter [

	| statement |
	statement := aViennaAbstractFormatter format: self statement.
	^ aViennaAbstractFormatter
		  indentString: 'others ' , aViennaAbstractFormatter arrow
		  insertCrIfNeeded: statement
]

{ #category : #testing }
ViennaOthersStatementNode >> isViennaOthersStatementNode [

	^ true
]

{ #category : #accessing }
ViennaOthersStatementNode >> label [

	^ 'OthersStatement'
]

{ #category : #accessing }
ViennaOthersStatementNode >> statement [

	^ self at: 1
]

{ #category : #accessing }
ViennaOthersStatementNode >> statement: aViennaStatementNode [

	self at: 1 put: aViennaStatementNode
]
