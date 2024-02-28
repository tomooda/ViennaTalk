Class {
	#name : #ViennaTraceConcurrentExpressionNode,
	#superclass : #ViennaTraceCoreDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaTraceConcurrentExpressionNode >> formatWith: aViennaAbstractFormatter [

	| traceDefinitions |
	traceDefinitions := aViennaAbstractFormatter formatAll: self.
	^ '||(' , ((aViennaAbstractFormatter anyNeedsIndent: traceDefinitions)
		   ifTrue: [
			   aViennaAbstractFormatter
				   join: ',' , String cr , aViennaAbstractFormatter indent
				   withAll: (traceDefinitions collect: [ :statement |
						    aViennaAbstractFormatter indentString: statement ]) ]
		   ifFalse: [
		   aViennaAbstractFormatter join: ', ' withAll: traceDefinitions ]) , ')'
]

{ #category : #private }
ViennaTraceConcurrentExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #accessing }
ViennaTraceConcurrentExpressionNode >> label [

	^ 'TraceConcurrentExpression'
]

{ #category : #typechecking }
ViennaTraceConcurrentExpressionNode >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
