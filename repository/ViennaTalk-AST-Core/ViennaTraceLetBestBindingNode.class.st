Class {
	#name : #ViennaTraceLetBestBindingNode,
	#superclass : #ViennaTraceBindingDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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

{ #category : #'accessing-definitions' }
ViennaTraceLetBestBindingNode >> definitionOfLocalName: aString [

	| valDef |
	valDef := self first.
	valDef
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'accessing-definitions' }
ViennaTraceLetBestBindingNode >> findResolverForIdentifier: aString [

	^ (self multipleBind bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaTraceLetBestBindingNode >> formatWith: aViennaAbstractFormatter [

	| multipleBind guard trace |
	multipleBind := aViennaAbstractFormatter
		                indentString:
		                (aViennaAbstractFormatter keyword: 'let')
		                insertCrIfNeeded:
		                (aViennaAbstractFormatter format: self multipleBind).
	guard := self conditionExpression ifNil: [ '' ] ifNotNil: [ :node |
		         aViennaAbstractFormatter
			         indentString: (aViennaAbstractFormatter keyword: 'be st')
			         insertCrIfNeeded: (aViennaAbstractFormatter format: node) ].
	trace := aViennaAbstractFormatter
		         indentString: (aViennaAbstractFormatter keyword: 'in')
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

{ #category : #'accessing-definitions' }
ViennaTraceLetBestBindingNode >> lookupIdentifier: aString [

	^ (self multipleBind bindsIdentifier: aString)
		  ifTrue: [ self multipleBind ]
		  ifFalse: [ nil ]
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
