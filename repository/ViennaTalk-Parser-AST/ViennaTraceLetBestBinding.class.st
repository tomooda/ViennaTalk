Class {
	#name : #ViennaTraceLetBestBinding,
	#superclass : #ViennaTraceBindingDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTraceLetBestBinding class >> multipleBind: aViennaMultipleBindNode conditionExpression: aViennaExpressionNode traceDefinition: aViennaTraceDefinitionNode [

	^ self new
		  multipleBind: aViennaMultipleBindNode;
		  conditionExpression: aViennaExpressionNode;
		  traceDefinition: aViennaTraceDefinitionNode;
		  yourself
]

{ #category : #accessing }
ViennaTraceLetBestBinding >> conditionExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaTraceLetBestBinding >> conditionExpression: aViennaExpression [

	self at: 2 put: aViennaExpression
]

{ #category : #'pretty printing' }
ViennaTraceLetBestBinding >> formatWith: aViennaAbstractFormatter [

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
ViennaTraceLetBestBinding >> freeIdentifiersExcept: aSet do: aBlock [

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
ViennaTraceLetBestBinding >> label [

	^ 'TraceLetBestBinding'
]

{ #category : #typechecking }
ViennaTraceLetBestBinding >> maximalType [

	self multipleBind typecheck.
	self conditionExpression ifNotNil: [ :condition |
		condition typecheck: ViennaType bool ].
	self traceDefinition typecheck.
	^ ViennaType unit
]

{ #category : #accessing }
ViennaTraceLetBestBinding >> multipleBind [

	^ self at: 1
]

{ #category : #accessing }
ViennaTraceLetBestBinding >> multipleBind: aViennaMultipleBindNode [

	self at: 1 put: aViennaMultipleBindNode
]

{ #category : #accessing }
ViennaTraceLetBestBinding >> traceDefinition [

	^ self at: 3
]

{ #category : #accessing }
ViennaTraceLetBestBinding >> traceDefinition: aViennaTraceDefinitionNode [

	self at: 3 put: aViennaTraceDefinitionNode
]
