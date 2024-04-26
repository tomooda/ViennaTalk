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

{ #category : #'accessing-definitions' }
ViennaTraceLetDefBindingNode >> definitionOfLocalName: aString [

	self localDefinitionList do: [ :def |
		def isViennaValueDefinitionNode ifTrue: [
			def pattern
				allDescendantsSuchThat: [ :n |
				n isViennaPatternIdentifierNode: aString ]
				do: [ :n | ^ n ] ].
		(def isViennaFunctionDefinitionNode: aString) ifTrue: [ ^ def ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'accessing-definitions' }
ViennaTraceLetDefBindingNode >> findResolverForIdentifier: aString [

	^ (self localDefinitionList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
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

{ #category : #accessing }
ViennaTraceLetDefBindingNode >> localDefinitionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaTraceLetDefBindingNode >> localDefinitionList: aViennaLocalDefinitionListNode [

	self at: 1 put: aViennaLocalDefinitionListNode
]

{ #category : #'accessing-definitions' }
ViennaTraceLetDefBindingNode >> lookupIdentifier: aString [

	self localDefinitionList do: [ :localDefinition |
		(localDefinition bindsIdentifier: aString) ifTrue: [
			^ localDefinition ] ].
	^ nil
]

{ #category : #typechecking }
ViennaTraceLetDefBindingNode >> maximalType [

	self localDefinitionList typecheck.
	self traceDefinition typecheck.
	^ ViennaType unit
]

{ #category : #accessing }
ViennaTraceLetDefBindingNode >> traceDefinition [

	^ self at: 2
]

{ #category : #accessing }
ViennaTraceLetDefBindingNode >> traceDefinition: aViennaTraceDefinitionNode [

	self at: 2 put: aViennaTraceDefinitionNode
]
