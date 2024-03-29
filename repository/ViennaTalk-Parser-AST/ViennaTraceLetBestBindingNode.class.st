Class {
	#name : #ViennaTraceLetBestBindingNode,
	#superclass : #ViennaTraceBindingDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTraceLetBestBindingNode class >> multipleBind: aViennaMultipleBindNode conditionExpression: aViennaExpressionNode traceDefinition: aViennaTraceDefinitionNode [

	^ (self new: 3)
		  multipleBind: aViennaMultipleBindNode;
		  conditionExpression: aViennaExpressionNode;
		  traceDefinition: aViennaTraceDefinitionNode;
		  yourself
]

{ #category : #accessing }
ViennaTraceLetBestBindingNode >> conditionExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaTraceLetBestBindingNode >> conditionExpression: aViennaExpression [

	self at: 2 put: aViennaExpression
]

{ #category : #'pretty printing' }
ViennaTraceLetBestBindingNode >> formatWith: aViennaAbstractFormatter [

	| multipleBind guard trace |
	multipleBind := aViennaAbstractFormatter
		                indentString: 'let'
		                insertCrIfNeeded:
		                (aViennaAbstractFormatter format: self multipleBind).
	guard := self conditionExpression ifNil: [ '' ] ifNotNil: [ :node |
		         aViennaAbstractFormatter
			         indentString: 'be st'
			         insertCrIfNeeded: (aViennaAbstractFormatter format: node) ].
	trace := aViennaAbstractFormatter
		         indentString: 'in'
		         insertCrIfNeeded:
		         (aViennaAbstractFormatter format: self traceDefinition).
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   noIndentString: multipleBind
				   insertCrIfNeeded: guard)
		  insertCrIfNeeded: trace
]

{ #category : #private }
ViennaTraceLetBestBindingNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	self multipleBind freeIdentifiersExcept: aSet do: aBlock.
	boundIdentifiers := aSet , self multipleBind uniqueBoundIdentifiers.
	self conditionExpression
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock.
	self traceDefinition
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock
]

{ #category : #accessing }
ViennaTraceLetBestBindingNode >> label [

	^ 'TraceLetBestBinding'
]

{ #category : #typechecking }
ViennaTraceLetBestBindingNode >> maximalType [

	self multipleBind typecheck.
	self conditionExpression ifNotNil: [ :condition |
		condition typecheck: ViennaType bool ].
	self traceDefinition typecheck.
	^ ViennaType unit
]

{ #category : #accessing }
ViennaTraceLetBestBindingNode >> multipleBind [

	^ self at: 1
]

{ #category : #accessing }
ViennaTraceLetBestBindingNode >> multipleBind: aViennaMultipleBindNode [

	self at: 1 put: aViennaMultipleBindNode
]

{ #category : #accessing }
ViennaTraceLetBestBindingNode >> traceDefinition [

	^ self at: 3
]

{ #category : #accessing }
ViennaTraceLetBestBindingNode >> traceDefinition: aViennaTraceDefinitionNode [

	self at: 3 put: aViennaTraceDefinitionNode
]
