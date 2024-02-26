Class {
	#name : #ViennaTraceLetDefBinding,
	#superclass : #ViennaTraceBindingDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTraceLetDefBinding class >> localDefinitionList: aViennaLocalDefinitionListNode traceDefinition: aViennaTraceDefinitionNode [

	^ self new
		  localDefinitionList: aViennaLocalDefinitionListNode;
		  traceDefinition: aViennaTraceDefinitionNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTraceLetDefBinding >> formatWith: aViennaAbstractFormatter [

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
ViennaTraceLetDefBinding >> freeIdentifiersExcept: aSet do: aBlock [

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
ViennaTraceLetDefBinding >> label [

	^ 'TraceLetDefBinding'
]

{ #category : #'parsers-definitions' }
ViennaTraceLetDefBinding >> localDefinitionList [

	^ self at: 1
]

{ #category : #'parsers-definitions' }
ViennaTraceLetDefBinding >> localDefinitionList: aViennaLocalDefinitionListNode [

	self at: 1 put: aViennaLocalDefinitionListNode
]

{ #category : #typechecking }
ViennaTraceLetDefBinding >> maximalType [

	self localDefinitionList typecheck.
	self traceDefinition typecheck.
	^ ViennaType unit
]

{ #category : #'parsers-definitions' }
ViennaTraceLetDefBinding >> traceDefinition [

	^ self at: 2
]

{ #category : #'parsers-definitions' }
ViennaTraceLetDefBinding >> traceDefinition: aViennaTraceDefinitionNode [

	self at: 2 put: aViennaTraceDefinitionNode
]
