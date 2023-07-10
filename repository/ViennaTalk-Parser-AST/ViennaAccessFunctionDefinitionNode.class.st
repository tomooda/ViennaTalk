Class {
	#name : #ViennaAccessFunctionDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAccessFunctionDefinitionNode class >> access: aViennaAccessNode functionDefinition: aViennaFunctionDefnitionNode [

	^ (self new: 2)
		  access: aViennaAccessNode;
		  functionDefinition: aViennaFunctionDefnitionNode;
		  yourself
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> argumentType [

	^ self functionDefinition argumentType
]

{ #category : #'accessing-definitions' }
ViennaAccessFunctionDefinitionNode >> asAccessDefinition [

	^ self
]

{ #category : #'accessing-definitions' }
ViennaAccessFunctionDefinitionNode >> asImportDefinitionIn: aViennaModuleNode [

	^ self functionDefinition definition asImportDefinitionIn:
		  aViennaModuleNode
]

{ #category : #private }
ViennaAccessFunctionDefinitionNode >> boundIdentifiersDo: aBlock [

	self functionDefinition boundIdentifiersDo: aBlock
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> expression [

	^ self functionDefinition expression
]

{ #category : #'pretty printing' }
ViennaAccessFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll:
		  ((aViennaAbstractFormatter formatAll: self) reject: #isEmpty)
]

{ #category : #private }
ViennaAccessFunctionDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self functionDefinition freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> functionDefinition [

	^ self at: 2
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> functionDefinition: aViennaFunctionDefinitionNode [

	self at: 2 put: aViennaFunctionDefinitionNode
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> identifier [

	^ self functionDefinition identifier
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> identifier: aString [

	self functionDefinition identifier: aString
]

{ #category : #testing }
ViennaAccessFunctionDefinitionNode >> isFunctionDefinition [

	^ true
]

{ #category : #testing }
ViennaAccessFunctionDefinitionNode >> isViennaAccessFunctionDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaAccessFunctionDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> label [

	^ 'AccessFunctionDefinition'
]

{ #category : #'accessing-definitions' }
ViennaAccessFunctionDefinitionNode >> localResolve [

	^ self functionDefinition localResolve
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> measure [

	^ self functionDefinition measure
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> parametersList [

	^ self functionDefinition parametersList
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> post [

	^ self functionDefinition post
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> pre [

	^ self functionDefinition pre
]

{ #category : #'accessing-definitions' }
ViennaAccessFunctionDefinitionNode >> resolve [

	^ self functionDefinition resolve
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> returnType [

	^ self functionDefinition returnType
]

{ #category : #'accessing-definitions' }
ViennaAccessFunctionDefinitionNode >> shortName [

	^ self functionDefinition shortName
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> type [

	^ self functionDefinition type
]

{ #category : #accessing }
ViennaAccessFunctionDefinitionNode >> typeVariableList [

	^ self functionDefinition typeVariableList
]
