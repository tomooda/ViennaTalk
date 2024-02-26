Class {
	#name : #ViennaTraceBracketedExpression,
	#superclass : #ViennaTraceCoreDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTraceBracketedExpression class >> traceDefinitionList: aViennaTraceDefinitionList [

	^ self new
		  traceDefinitionList: aViennaTraceDefinitionList;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTraceBracketedExpression >> formatWith: aViennaAbstractFormatter [

	^ self traceDefinitionList formatWith: aViennaAbstractFormatter
]

{ #category : #private }
ViennaTraceBracketedExpression >> freeIdentifiersExcept: aSet do: aBlock [

	self traceDefinitionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaTraceBracketedExpression >> label [

	^ 'TraceBracketedExpression'
]

{ #category : #typechecking }
ViennaTraceBracketedExpression >> maximalType [

	self traceDefinitionList typecheck.
	^ ViennaType unit
]

{ #category : #accessing }
ViennaTraceBracketedExpression >> traceDefinitionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaTraceBracketedExpression >> traceDefinitionList: aViennaTraceDefinitionList [

	self at: 1 put: aViennaTraceDefinitionList
]
