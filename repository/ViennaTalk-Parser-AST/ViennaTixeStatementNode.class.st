Class {
	#name : #ViennaTixeStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTixeStatementNode class >> traps: aViennaTrapsNode statement: aViennaStatementNode [

	^ (self new: 2)
		  traps: aViennaTrapsNode;
		  statement: aViennaStatementNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTixeStatementNode >> formatWith: aViennaAbstractFormatter [

	| traps statement |
	traps := aViennaAbstractFormatter format: self traps.
	statement := aViennaAbstractFormatter format: self statement.
	^ (aViennaAbstractFormatter needsIndent: traps)
		  ifTrue: [
			  (aViennaAbstractFormatter indentString: 'tixe' insertCr: traps)
			  , String cr
			  ,
			  (aViennaAbstractFormatter indentString: 'in' insertCr: statement) ]
		  ifFalse: [
			  aViennaAbstractFormatter
				  indentString: 'tixe ' , traps , ' in'
				  insertCrIfNeeded: statement ]
]

{ #category : #private }
ViennaTixeStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self traps freeIdentifiersExcept: aSet do: aBlock.
	self statement freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaTixeStatementNode >> isViennaTixeStatementNode [

	^ true
]

{ #category : #accessing }
ViennaTixeStatementNode >> label [

	^ 'TixeStatement'
]

{ #category : #accessing }
ViennaTixeStatementNode >> statement [

	^ self at: 2
]

{ #category : #accessing }
ViennaTixeStatementNode >> statement: aViennaStatementNode [

	self at: 2 put: aViennaStatementNode
]

{ #category : #accessing }
ViennaTixeStatementNode >> traps [

	^ self at: 1
]

{ #category : #accessing }
ViennaTixeStatementNode >> traps: aViennaTrapsNode [

	self at: 1 put: aViennaTrapsNode
]
