Class {
	#name : #ViennaTraceRepeatDefinitionNode,
	#superclass : #ViennaTraceDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaTraceRepeatDefinitionNode class >> traceCoreDefinition: aViennaTraceCoreDefinitionNode traceRepeatPattern: aViennaTraceRepeatPatternNode [

	^ (self new: 2)
		  traceCoreDefinition: aViennaTraceCoreDefinitionNode;
		  traceRepeatPattern: aViennaTraceRepeatPatternNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTraceRepeatDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ (aViennaAbstractFormatter format: self traceCoreDefinition)
	  ++ (self traceRepeatPattern
			   ifNotNil: [ :pattern |
				   aViennaAbstractFormatter space
				   ++ (aViennaAbstractFormatter format: pattern) ]
			   ifNil: [ aViennaAbstractFormatter empty ])
]

{ #category : #private }
ViennaTraceRepeatDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self traceCoreDefinition freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaTraceRepeatDefinitionNode >> label [

	^ 'TraceRepeatDefinition'
]

{ #category : #typechecking }
ViennaTraceRepeatDefinitionNode >> maximalType [

	self traceCoreDefinition typecheck.
	^ ViennaType unit
]

{ #category : #accessing }
ViennaTraceRepeatDefinitionNode >> traceCoreDefinition [

	^ self at: 1
]

{ #category : #accessing }
ViennaTraceRepeatDefinitionNode >> traceCoreDefinition: aViennaTraceCoreDefinitionNode [

	self at: 1 put: aViennaTraceCoreDefinitionNode
]

{ #category : #accessing }
ViennaTraceRepeatDefinitionNode >> traceRepeatPattern [

	^ self at: 2
]

{ #category : #accessing }
ViennaTraceRepeatDefinitionNode >> traceRepeatPattern: aViennaTraceRepeatPatternNode [

	self at: 2 put: aViennaTraceRepeatPatternNode
]
