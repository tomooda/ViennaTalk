Class {
	#name : #ViennaNondeterministicStatementNode,
	#superclass : #ViennaStatementNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaNondeterministicStatementNode >> formatWith: aViennaAbstractFormatter [

	| statements |
	statements := aViennaAbstractFormatter formatAll: self.
	^ (aViennaAbstractFormatter keyword: '||') ++ '('
	  ++ ((aViennaAbstractFormatter anyNeedsIndent: statements)
			   ifTrue: [
				   aViennaAbstractFormatter
					   join: ',' ++ String cr ++ aViennaAbstractFormatter indent
					   withAll: (statements collect: [ :statement |
							    aViennaAbstractFormatter indentString: statement ]) ]
			   ifFalse: [
			   aViennaAbstractFormatter join: ', ' withAll: statements ]) ++ ')'
]

{ #category : #private }
ViennaNondeterministicStatementNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :statement |
		statement freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaNondeterministicStatementNode >> isViennaNondeterministicStatementNode [

	^ true
]

{ #category : #accessing }
ViennaNondeterministicStatementNode >> label [

	^ 'NondeterministicStatement'
]

{ #category : #typechecking }
ViennaNondeterministicStatementNode >> maximalType [

	^ self
		  inject: ViennaType unit
		  into: [ :type :statement | type + statement typecheck ]
]
