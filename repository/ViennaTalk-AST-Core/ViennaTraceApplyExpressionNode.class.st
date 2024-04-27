Class {
	#name : #ViennaTraceApplyExpressionNode,
	#superclass : #ViennaTraceCoreDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaTraceApplyExpressionNode class >> callStatement: aViennaCallStatementNode [

	^ (self new: 1)
		  callStatement: aViennaCallStatementNode;
		  yourself
]

{ #category : #accessing }
ViennaTraceApplyExpressionNode >> callStatement [

	^ self at: 1
]

{ #category : #accessing }
ViennaTraceApplyExpressionNode >> callStatement: aViennaCallStatementNode [

	self at: 1 put: aViennaCallStatementNode
]

{ #category : #'pretty printing' }
ViennaTraceApplyExpressionNode >> formatWith: aViennaAbstractFormatter [

	^ self callStatement formatWith: aViennaAbstractFormatter
]

{ #category : #private }
ViennaTraceApplyExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self callStatement freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaTraceApplyExpressionNode >> label [

	^ 'TraceApplyExpression'
]

{ #category : #typechecking }
ViennaTraceApplyExpressionNode >> maximalType [

	self callStatement typecheck.
	^ ViennaType unit
]
