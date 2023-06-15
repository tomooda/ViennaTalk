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

{ #category : #'pretty printing' }
ViennaLocalNameNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self identifier
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

	^ self module second second anySatisfy: [ :exportModuleSignature |
		  exportModuleSignature isViennaExportModuleSignatureAllNode or: [
			  exportModuleSignature anySatisfy: [ :exportSignatures |
				  exportSignatures anySatisfy: [ :export |
					  export exportsName: self ] ] ] ]
]

{ #category : #testing }
ViennaLocalNameNode >> isFunctionNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :defNode |
		((defNode isViennaExplicitFunctionDefinitionNode: self identifier)
			 or: [
				 (#( 'ImplicitFunctionDefinition' ) includes: defNode label) and: [
					 defNode first = self identifier ] ]) ifTrue: [ ^ true ].
		(defNode isViennaFunctionImportNode: self identifier) ifTrue: [
			^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isLocalValueNameNode [

	(self definitionOfLocalName: self first) ifNotNil: [ :defNode |
		| node |
		node := defNode.
		[ node notNil ] whileTrue: [
			(#( 'ValueDefinition' ) includes: node label) ifTrue: [ ^ true ].
			node := node parent ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isOperationNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :defNode |
		(defNode isViennaExplicitOperationDefinitionNode: self identifier)
			ifTrue: [ ^ true ].
		((#( 'ImplicitOperationDefinition' ) includes: defNode label) and: [
			 defNode first = self identifier ]) ifTrue: [ ^ true ].
		(defNode isViennaOperationImportNode: self identifier) ifTrue: [
			^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isStateVariableNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :fieldNode |
		(fieldNode isViennaFieldNode and: [
			 fieldNode parent parent label = 'StateDefinition' ]) ifTrue: [
			^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isTypeNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :defNode |
		((#( 'TypeDefinition' 'RecordTypeDefinition' ) includes:
			  defNode label) and: [ defNode first = self identifier ]) ifTrue: [
			^ true ].
		(defNode isViennaTypeImportNodeRenamed: self identifier) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
ViennaLocalNameNode >> isValueNameNode [

	(self definitionOfLocalName: self identifier) ifNotNil: [ :defNode |
		defNode bindHolderNode label = 'ValueDefinition' ifTrue: [ ^ true ].
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

	^ self resolveLocalName: self identifier
]

{ #category : #accessing }
ViennaLocalNameNode >> shortName [

	^ self identifier
]
