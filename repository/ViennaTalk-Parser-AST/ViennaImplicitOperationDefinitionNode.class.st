Class {
	#name : #ViennaImplicitOperationDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaImplicitOperationDefinitionNode class >> identifier: aString parameterTypes: aViennaParameterTypesNode identifierTypePairList: aViennaIdentifierTypePairListNode implicitOperationBody: aViennaImplicitOperationBodyNode [

	^ (self new: 4)
		  identifier: aString;
		  parameterTypes: aViennaParameterTypesNode;
		  identifierTypePairList: aViennaIdentifierTypePairListNode;
		  implicitOperationBody: aViennaImplicitOperationBodyNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> asAccessDefinition [

	^ (ViennaOperationDefinitionNode definition: self) asAccessDefinition
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> asExport [

	^ ViennaOperationExportNode
		  nameList: (ViennaNameListNode withAll:
				   { (ViennaLocalNameNode identifier: self first) })
		  type: (ViennaOperationTypeNode
				   argumentType: self second first pairListToType
				   returnType: self third pairListToType)
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> asImportDefinitionIn: moduleNode [

	^ ViennaImportDefinitionNode
		  moduleIdentifier: self module identifier
		  importModuleSignature: (ViennaImportModuleSignatureNode with:
				   (ViennaImportOperationsSignatureNode with:
					    (ViennaOperationImportNode
						     name: (ViennaLocalNameNode identifier: self identifier)
						     type: (ViennaOperationTypeNode
								      argumentType: self second first pairListToType
								      returnType: self third pairListToType)
						     rename: nil)))
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> definitionOfLocalName: aString [

	self parameterTypes patternTypePairList do: [ :patList |
		patList isViennaPatternListNode ifTrue: [
			patList allDescendantsDo: [ :n |
				(n isViennaPatternIdentifier: aString) ifTrue: [ ^ n ] ] ] ].
	self identifierTypePairList do: [ :n |
		n = aString ifTrue: [ ^ self ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'pretty printing' }
ViennaImplicitOperationDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| identifier parameterTypes identifierTypePairList implicitOperationBody |
	identifier := self identifier.
	parameterTypes := aViennaAbstractFormatter format:
		                  self parameterTypes.
	identifierTypePairList := aViennaAbstractFormatter format:
		                          self identifierTypePairList.
	implicitOperationBody := aViennaAbstractFormatter format:
		                         self implicitOperationBody.
	^ identifier , parameterTypes , identifierTypePairList
	  , implicitOperationBody
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> identifierTypePairList [

	^ self at: 3
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> identifierTypePairList: aViennaIdentifierTypePairListNode [

	self at: 3 put: aViennaIdentifierTypePairListNode
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> implicitOperationBody [

	^ self at: 4
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> implicitOperationBody: aViennaImplicitOperationBodyNode [

	self at: 4 put: aViennaImplicitOperationBodyNode
]

{ #category : #testing }
ViennaImplicitOperationDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaImplicitOperationDefinitionNode >> isViennaImplicitOperationDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaImplicitOperationDefinitionNode >> isViennaImplicitOperationDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaImplicitOperationDefinitionNode >> label [

	^ 'ImplicitOperationDefinition'
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> parameterTypes [

	^ self at: 2
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> parameterTypes: aViennaParameterTypesNode [

	self at: 2 put: aViennaParameterTypesNode
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> resolve [

	^ self
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> shortName [

	^ self identifier
]
