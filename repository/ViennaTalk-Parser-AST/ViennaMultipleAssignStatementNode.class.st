Class {
	#name : #ViennaMultipleAssignStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaMultipleAssignStatementNode >> formatWith: aViennaAbstractFormatter [

	| statements |
	statements := aViennaAbstractFormatter formatAll: self.
	^ 'atomic(' , ((aViennaAbstractFormatter anyNeedsIndent: statements)
		   ifTrue: [
			   aViennaAbstractFormatter
				   join: ';' , String cr , aViennaAbstractFormatter indent
				   withAll: (statements collect: [ :statement |
						    aViennaAbstractFormatter indentString: statement ]) ]
		   ifFalse: [
		   aViennaAbstractFormatter join: '; ' withAll: statements ]) , ')'
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
