Class {
	#name : #ViennaLocalNameNode,
	#superclass : #ViennaNameNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaLocalNameNode class >> identifier: aString [

	^ (self new: 1)
		  identifier: aString;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaLocalNameNode >> asGlobalName [

	^ (self findResolverForIdentifier: self identifier) ifNotNil: [
		  :resolver |
		  resolver isViennaModuleNode ifTrue: [
			  (resolver lookupIdentifier: self identifier) ifNotNil: [
				  :localDefinition |
				  localDefinition isViennaImportNode
					  ifTrue: [ localDefinition asGlobalName ]
					  ifFalse: [
						  localDefinition isViennaExportableTopLevelDefinitionNode
							  ifTrue: [
								  ViennaGlobalNameNode
									  moduleIdentifier: resolver identifier
									  identifier: self identifier ] ] ] ] ]
]

{ #category : #'pretty printing' }
ViennaLocalNameNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self identifier
]

{ #category : #private }
ViennaLocalNameNode >> freeIdentifiersExcept: aSet do: aBlock [

	(aSet includes: self identifier) ifFalse: [
		aBlock cull: self identifier cull: self ]
]

{ #category : #accessing }
ViennaLocalNameNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaLocalNameNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaLocalNameNode >> isBlockVariableNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :defNode |
		defNode isViennaAssignmentDefinitionNode ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isExportedNameNode [

	^ self module interface exportDefinition exportsIdentifier:
		  self identifier
]

{ #category : #testing }
ViennaLocalNameNode >> isFunctionNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :defNode |
		(defNode isViennaExplicitFunctionDefinitionNode: self identifier)
			ifTrue: [ ^ true ].
		(defNode isViennaExtendedExplicitFunctionDefinitionNode:
			 self identifier) ifTrue: [ ^ true ].
		(defNode isViennaImplicitFunctionDefinitionNode: self identifier)
			ifTrue: [ ^ true ].
		(defNode isViennaFunctionImportNode: self identifier) ifTrue: [
			^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isLocalValueNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :defNode |
		defNode bindHolderNode isViennaValueDefinitionNode ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isOperationNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :defNode |
		(defNode isViennaExplicitOperationDefinitionNode: self identifier)
			ifTrue: [ ^ true ].
		(defNode isViennaImplicitOperationDefinitionNode: self identifier)
			ifTrue: [ ^ true ].
		(defNode isViennaOperationImportNode: self identifier) ifTrue: [
			^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isStateVariableNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :fieldNode |
		(fieldNode isViennaFieldNode and: [
			 fieldNode parent parent isViennaStateDefinitionNode ]) ifTrue: [
			^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isTypeNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :defNode |
		(defNode isViennaTypeSynonymNode: self identifier) ifTrue: [ ^ true ].
		(defNode isViennaRecordTypeDefinitionNode: self identifier) ifTrue: [
			^ true ].
		(defNode isViennaTypeImportNodeRenamed: self identifier) ifTrue: [
			^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isValueNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :defNode |
		defNode bindHolderNode isViennaValueDefinitionNode ifTrue: [ ^ true ].
		(defNode isViennaLocalNameNode and: [
			 defNode parent notNil and: [
				 defNode parent isViennaValueImportNode ] ]) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isViennaLocalNameNode [

	^ true
]

{ #category : #testing }
ViennaLocalNameNode >> isViennaLocalNameNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaLocalNameNode >> label [

	^ 'LocalName'
]

{ #category : #accessing }
ViennaLocalNameNode >> resolve [

	^ self resolveIdentifier: self identifier
]

{ #category : #accessing }
ViennaLocalNameNode >> shortName [

	^ self identifier
]
