Class {
	#name : #ViennaAssignStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAssignStatementNode class >> stateDesignator: aViennaStateDesignatorNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  stateDesignator: aViennaStateDesignatorNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #accessing }
ViennaAssignStatementNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaAssignStatementNode >> expression: aViennaExpressionNode [

	^ self at: 2 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaAssignStatementNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter format: self first)
		  insertCrIfNeeded:
		  ':= ' , (aViennaAbstractFormatter format: self second)
]

{ #category : #testing }
ViennaAssignStatementNode >> isViennaAssignStatementNode [

	^ true
]

{ #category : #accessing }
ViennaAssignStatementNode >> label [

	^ 'AssignStatement'
]

{ #category : #accessing }
ViennaAssignStatementNode >> stateDesignator [

	^ self at: 1
]

{ #category : #accessing }
ViennaAssignStatementNode >> stateDesignator: aViennaStateDesignatorNode [

	^ self at: 1 put: aViennaStateDesignatorNode
]
