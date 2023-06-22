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

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> argumentType [

	^ self parameterTypes patternTypePairList type
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> asAccessDefinition [

	^ (ViennaOperationDefinitionNode definition: self) asAccessDefinition
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> asExport [

	^ ViennaOperationExportNode
		  nameList: (ViennaNameListNode withAll:
				   { (ViennaLocalNameNode identifier: self identifier) })
		  type: self type
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> asImportDefinitionIn: moduleNode [

	^ ViennaImportDefinitionNode
		  moduleIdentifier: self module identifier
		  importModuleSignature: (ViennaImportModuleSignatureNode with:
				   (ViennaImportOperationsSignatureNode with:
					    (ViennaOperationImportNode
						     name: (ViennaLocalNameNode identifier: self identifier)
						     type: self type
						     rename: nil)))
]

{ #category : #private }
ViennaImplicitOperationDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock value: self identifier.
	self pre ifNotNil: [ aBlock value: 'pre_' , self identifier ].
	self post ifNotNil: [ aBlock value: 'post_' , self identifier ]
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

{ #category : #private }
ViennaImplicitOperationDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet.
	self type freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self parameters freeIdentifiersExcept: boundIdentifiers do: aBlock.
	boundIdentifiers := boundIdentifiers
	                    , self parameters uniqueBoundIdentifiers
	                    , self returnIdentifiers.
	self pre ifNotNil: [ :pre |
		pre freeIdentifiersExcept: boundIdentifiers do: aBlock ].
	self post ifNotNil: [ :post |
		post freeIdentifiersExcept: boundIdentifiers do: aBlock ]
]

{ #category : #testing }
ViennaImplicitOperationDefinitionNode >> hasScope [

	^ true
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

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> parameters [

	^ self parameterTypes parameters
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> post [

	^ self implicitOperationBody post
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> post: aViennaExpressionNode [

	self implicitOperationBody post: aViennaExpressionNode
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> pre [

	^ self implicitOperationBody pre
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> pre: aViennaExpressionNode [

	self implicitOperationBody pre: aViennaExpressionNode
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> resolve [

	^ self
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> resolveIdentifier: aString [

	^ ((self returnIdentifiers includes: aString) or: [
		   self parameters bindsIdentifier: aString ])
		  ifTrue: [ self ]
		  ifFalse: [ super resolveIdentifier: aString ]
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> returnIdentifiers [

	^ self identifierTypePairList identifiers
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> returnType [

	^ self identifierTypePairList type
]

{ #category : #'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> shortName [

	^ self identifier
]

{ #category : #accessing }
ViennaImplicitOperationDefinitionNode >> type [

	^ ViennaOperationTypeNode
		  argumentType: self argumentType
		  returnType: self returnType
]
