Class {
	#name : #ViennaTraceLetDefBindingNode,
	#superclass : #ViennaTraceBindingDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTraceLetDefBindingNode class >> localDefinitionList: aViennaLocalDefinitionListNode traceDefinition: aViennaTraceDefinitionNode [

	^ (self new: 2)
		  localDefinitionList: aViennaLocalDefinitionListNode;
		  traceDefinition: aViennaTraceDefinitionNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTraceLetDefBindingNode >> formatWith: aViennaAbstractFormatter [

	| localDefinitionList traceDefinition |
	localDefinitionList := aViennaAbstractFormatter format:
		                       self localDefinitionList.
	traceDefinition := aViennaAbstractFormatter format:
		                   self traceDefinition.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   indentString: 'let'
				   insertCrIfNeeded: localDefinitionList)
		  insertCrIfNeeded: (aViennaAbstractFormatter
				   indentString: 'in'
				   insertCrIfNeeded: traceDefinition)
]

{ #category : #private }
ViennaTraceLetDefBindingNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet
	                    , self localDefinitionList uniqueBoundIdentifiers.
	self localDefinitionList
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock.
	self traceDefinition
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock
]

{ #category : #accessing }
ViennaTraceLetDefBindingNode >> label [

	^ 'TraceLetDefBinding'
]

{ #category : #'parsers-definitions' }
ViennaTraceLetDefBindingNode >> localDefinitionList [

	^ self at: 1
]

{ #category : #'parsers-definitions' }
ViennaTraceLetDefBindingNode >> localDefinitionList: aViennaLocalDefinitionListNode [

	self at: 1 put: aViennaLocalDefinitionListNode
]

{ #category : #typechecking }
ViennaTraceLetDefBindingNode >> maximalType [

	self localDefinitionList typecheck.
	self traceDefinition typecheck.
	^ ViennaType unit
]

{ #category : #'parsers-definitions' }
ViennaTraceLetDefBindingNode >> traceDefinition [

	^ self at: 2
]

{ #category : #'parsers-definitions' }
ViennaTraceLetDefBindingNode >> traceDefinition: aViennaTraceDefinitionNode [

	self at: 2 put: aViennaTraceDefinitionNode
]
