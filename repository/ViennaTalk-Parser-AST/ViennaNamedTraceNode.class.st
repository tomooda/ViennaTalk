Class {
	#name : #ViennaNamedTraceNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaNamedTraceNode class >> identifier: aString traceDefinitionList: aViennaTraceDefinitionList [

	^ self new
		  identifier: aString;
		  traceDefinitionList: aViennaTraceDefinitionList;
		  yourself
]

{ #category : #private }
ViennaNamedTraceNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self
]

{ #category : #'pretty printing' }
ViennaNamedTraceNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter indentString:
		  self identifier , ':' , String cr
		  , (aViennaAbstractFormatter format: self traceDefinitionList)
]

{ #category : #private }
ViennaNamedTraceNode >> freeIdentifiersExcept: aSet do: aBlock [

	self traceDefinitionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaNamedTraceNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaNamedTraceNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaNamedTraceNode >> isViennaExportableTopLevelDefinitionNode [

	^ false
]

{ #category : #accessing }
ViennaNamedTraceNode >> label [

	^ 'NamedTrace'
]

{ #category : #typechecking }
ViennaNamedTraceNode >> maximalType [

	self traceDefinitionList typecheck.
	^ ViennaType unit
]

{ #category : #accessing }
ViennaNamedTraceNode >> traceDefinitionList [

	^ self at: 2
]

{ #category : #accessing }
ViennaNamedTraceNode >> traceDefinitionList: aViennaTraceDefinitionListNode [

	self at: 2 put: aViennaTraceDefinitionListNode
]
