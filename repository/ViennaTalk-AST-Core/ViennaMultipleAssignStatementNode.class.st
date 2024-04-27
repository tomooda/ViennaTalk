Class {
	#name : #ViennaMultipleAssignStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaMultipleAssignStatementNode >> formatWith: aViennaAbstractFormatter [

	| statements |
	statements := aViennaAbstractFormatter formatAll: self.
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter keyword: 'atomic') , '('
		  insertCrIfNeeded:
			  (aViennaAbstractFormatter
				   join: ';' , String cr
				   withAll: statements) , ')'
]

{ #category : #private }
ViennaMultipleAssignStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :assignmentStatement |
		assignmentStatement freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaMultipleAssignStatementNode >> isViennaMultipleAssignStatementNode [

	^ true
]

{ #category : #accessing }
ViennaMultipleAssignStatementNode >> label [

	^ 'MultipleAssignStatement'
]

{ #category : #typechecking }
ViennaMultipleAssignStatementNode >> maximalType [

	^ self
		  inject: ViennaType unit
		  into: [ :type :statement | type + statement typecheck ]
]
