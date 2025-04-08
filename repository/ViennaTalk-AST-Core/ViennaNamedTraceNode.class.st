Class {
	#name : 'ViennaNamedTraceNode',
	#superclass : 'ViennaTopLevelDefinitionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaNamedTraceNode class >> identifier: aString traceDefinitionList: aViennaTraceDefinitionList [

	^ (self new: 2)
		  identifier: aString;
		  traceDefinitionList: aViennaTraceDefinitionList;
		  yourself
]

{ #category : 'accessing' }
ViennaNamedTraceNode >> addToModule: aViennaModuleNode [

	^ aViennaModuleNode module addNamedTrace: self copyFragment
]

{ #category : 'private' }
ViennaNamedTraceNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self
]

{ #category : 'pretty printing' }
ViennaNamedTraceNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter indentString:
		  (aViennaAbstractFormatter identifier: self identifier) ++ ':'
		  ++ aViennaAbstractFormatter cr
		  ++ (aViennaAbstractFormatter format: self traceDefinitionList)
]

{ #category : 'private' }
ViennaNamedTraceNode >> freeIdentifiersExcept: aSet do: aBlock [

	self traceDefinitionList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : 'accessing' }
ViennaNamedTraceNode >> identifier [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaNamedTraceNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : 'testing' }
ViennaNamedTraceNode >> isViennaExportableTopLevelDefinitionNode [

	^ false
]

{ #category : 'testing' }
ViennaNamedTraceNode >> isViennaNamedTraceNode [

	^ true
]

{ #category : 'accessing' }
ViennaNamedTraceNode >> label [

	^ 'NamedTrace'
]

{ #category : 'typechecking' }
ViennaNamedTraceNode >> maximalType [

	self traceDefinitionList typecheck.
	^ ViennaType unit
]

{ #category : 'running' }
ViennaNamedTraceNode >> run [

	((ViennaVDM2SmalltalkObject new generate: self document) at:
		 self module identifier) perform: self identifier asSymbol
]

{ #category : 'running' }
ViennaNamedTraceNode >> run: aBlock [

	((ViennaVDM2SmalltalkObject new generate: self document) at:
		 self module identifier)
		perform: (self identifier , ':') asSymbol
		with: aBlock
]

{ #category : 'running' }
ViennaNamedTraceNode >> run: aBlock onError: handlerBlock [

	((ViennaVDM2SmalltalkObject new generate: self document) at:
		 self module identifier)
		perform: (self identifier , ':onError:') asSymbol
		with: aBlock
		with: handlerBlock
]

{ #category : 'accessing' }
ViennaNamedTraceNode >> traceDefinitionList [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaNamedTraceNode >> traceDefinitionList: aViennaTraceDefinitionListNode [

	self at: 2 put: aViennaTraceDefinitionListNode
]
