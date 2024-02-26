Class {
	#name : #ViennaTraceApplyExpression,
	#superclass : #ViennaTraceCoreDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTraceApplyExpression class >> callStatement: aViennaCallStatementNode [

	^ self new
		  callStatement: aViennaCallStatementNode;
		  yourself
]

{ #category : #accessing }
ViennaTraceApplyExpression >> callStatement [

	^ self at: 1
]

{ #category : #accessing }
ViennaTraceApplyExpression >> callStatement: aViennaCallStatementNode [

	self at: 1 put: aViennaCallStatementNode
]

{ #category : #'pretty printing' }
ViennaTraceApplyExpression >> formatWith: aViennaAbstractFormatter [

	^ self callStatement formatWith: aViennaAbstractFormatter
]

{ #category : #private }
ViennaTraceApplyExpression >> freeIdentifiersExcept: aSet do: aBlock [

	self callStatement freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaTraceApplyExpression >> label [

	^ 'TraceApplyExpression'
]

{ #category : #typechecking }
ViennaTraceApplyExpression >> maximalType [

	self callStatement typecheck.
	^ ViennaType unit
]
