Class {
	#name : #ViennaAccessValueDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaAccessValueDefinitionNode class >> access: aViennaAccessNode valueDefinition: aViennaValueDefinitionNode [

	^ (self new: 2)
		  access: aViennaAccessNode;
		  valueDefinition: aViennaValueDefinitionNode;
		  yourself
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #'accessing-definitions' }
ViennaAccessValueDefinitionNode >> asAccessDefinition [

	^ self
]

{ #category : #'accessing-definitions' }
ViennaAccessValueDefinitionNode >> asImportDefinitionIn: aViennaModuleNode [

	^ self valueDefinition asImportDefinitionIn: aViennaModuleNode
]

{ #category : #private }
ViennaAccessValueDefinitionNode >> boundIdentifiersDo: aBlock [

	self valueDefinition boundIdentifiersDo: aBlock
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> expression [

	^ self valueDefinition expression
]

{ #category : #'pretty printing' }
ViennaAccessValueDefinitionNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter
		  join: ' '
		  withAll: (aViennaAbstractFormatter formatAll: self)
]

{ #category : #private }
ViennaAccessValueDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self valueDefinition freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #testing }
ViennaAccessValueDefinitionNode >> isValueDefinition [

	^ true
]

{ #category : #testing }
ViennaAccessValueDefinitionNode >> isViennaAccessValueDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaAccessValueDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> label [

	^ 'AccessValueDefinition'
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> pattern [

	^ self valueDefinition pattern
]

{ #category : #'accessing-definitions' }
ViennaAccessValueDefinitionNode >> resolve [

	^ self valueDefinition resolve
]

{ #category : #'accessing-definitions' }
ViennaAccessValueDefinitionNode >> shortName [

	^ self valueDefinition shortName
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> type [

	^ self valueDefinition type
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> valueDefinition [

	^ self at: 2
]

{ #category : #accessing }
ViennaAccessValueDefinitionNode >> valueDefinition: aViennaValueDefinitionNode [

	self at: 2 put: aViennaValueDefinitionNode
]
