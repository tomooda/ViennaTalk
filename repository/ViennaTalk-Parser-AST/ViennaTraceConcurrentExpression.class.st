Class {
	#name : #ViennaTraceConcurrentExpression,
	#superclass : #ViennaTraceCoreDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaTraceConcurrentExpression >> formatWith: aViennaAbstractFormatter [

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
ViennaTraceConcurrentExpression >> freeIdentifiersExcept: aSet do: aBlock [

	self do: [ :node | node freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #accessing }
ViennaTraceConcurrentExpression >> label [

	^ 'TraceConcurrentExpression'
]

{ #category : #typechecking }
ViennaTraceConcurrentExpression >> maximalType [

	self do: #typecheck.
	^ ViennaType unit
]
