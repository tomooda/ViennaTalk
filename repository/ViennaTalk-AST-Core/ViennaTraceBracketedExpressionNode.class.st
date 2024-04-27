Class {
	#name : #ViennaTraceBracketedExpressionNode,
	#superclass : #ViennaTraceCoreDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaTraceBracketedExpressionNode class >> traceDefinitionList: aViennaTraceDefinitionList [

	^ (self new: 1)
		  traceDefinitionList: aViennaTraceDefinitionList;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTraceBracketedExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ '('
	  , (self traceDefinitionList formatWith: aViennaAbstractFormatter)
	  , ')'
]

{ #category : #private }
ViennaTraceBracketedExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self traceDefinitionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaTraceBracketedExpressionNode >> label [

	^ 'TraceBracketedExpression'
]

{ #category : #typechecking }
ViennaTraceBracketedExpressionNode >> maximalType [

	self traceDefinitionList typecheck.
	^ ViennaType unit
]

{ #category : #accessing }
ViennaTraceBracketedExpressionNode >> traceDefinitionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaTraceBracketedExpressionNode >> traceDefinitionList: aViennaTraceDefinitionList [

	self at: 1 put: aViennaTraceDefinitionList
]
