Class {
	#name : #ViennaImplicitFunctionDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaImplicitFunctionDefinitionNode class >> identifier: aString typeVariableList: aViennaTypeVariableListNode parameterTypes: aViennaParameterTypesNode identifierTypePairList: aViennaIdentifierTypePairListNode pre: aViennaExpressionNode1 post: aViennaExpressionNode2 [

	^ (self new: 6)
		  identifier: aString;
		  typeVariableList: aViennaTypeVariableListNode;
		  parameterTypes: aViennaParameterTypesNode;
		  identifierTypePairList: aViennaIdentifierTypePairListNode;
		  pre: aViennaExpressionNode1;
		  post: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> argumentType [

	^ self parameterTypes patternTypePairList type
		  parent: self;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> asAccessDefinition [

	^ (ViennaFunctionDefinitionNode definition: self) asAccessDefinition
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> asExport [

	^ ViennaFunctionExportNode
		  nameList: (ViennaNameListNode with:
				   (ViennaLocalNameNode identifier: self identifier))
		  typeVariableList: (self typeVariableList ifNotNil: #copyFragment)
		  type: self type
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> asImportDefinitionIn: moduleNode [

	^ ViennaImportDefinitionNode
		  moduleIdentifier: self module identifier
		  importModuleSignature: (ViennaImportModuleSignatureNode with:
				   (ViennaImportFunctionsSignatureNode with:
					    (ViennaFunctionImportNode
						     name: (ViennaLocalNameNode identifier: self identifier)
						     typeVariableList: self second copyFragment
						     type: self type
						     rename: nil)))
]

{ #category : #private }
ViennaImplicitFunctionDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock value: self identifier.
	self pre ifNotNil: [ aBlock value: 'pre_' , self identifier ].
	self post ifNotNil: [ aBlock value: 'post_' , self identifier ]
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> definitionOfLocalName: aString [

	self parameterTypes patternTypePairList do: [ :patList |
		patList isViennaPatternListNode ifTrue: [
			patList
				allDescendantsSuchThat: [ :n | n isPatternIdentifier: aString ]
				do: [ :n | ^ n ] ] ].
	self identifierTypePairList do: [ :n |
		n = aString ifTrue: [ ^ self ] ]
]

{ #category : #'pretty printing' }
ViennaImplicitFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| identifier typeVariableList parameterTypes identifierTypePairList pre post |
	identifier := self identifier.
	typeVariableList := self typeVariableList.
	parameterTypes := self parameterTypes.
	identifierTypePairList := self identifierTypePairList.
	pre := self pre.
	post := self post.
	^ (aViennaAbstractFormatter format: identifier)
	  , (aViennaAbstractFormatter format: typeVariableList)
	  , (aViennaAbstractFormatter format: parameterTypes)
	  , (aViennaAbstractFormatter format: identifierTypePairList) , (pre
		   ifNotNil: [
		   String cr , 'pre ' , (aViennaAbstractFormatter format: pre) ]
		   ifNil: [ String new ]) , String cr , 'post '
	  , (aViennaAbstractFormatter format: post)
]

{ #category : #private }
ViennaImplicitFunctionDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet
	                    , self typeVariableList uniqueBoundIdentifiers.
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
ViennaImplicitFunctionDefinitionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> identifierTypePairList [

	^ self at: 4
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> identifierTypePairList: aViennaIdentifierTypePairListNode [

	self at: 4 put: aViennaIdentifierTypePairListNode
]

{ #category : #testing }
ViennaImplicitFunctionDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaImplicitFunctionDefinitionNode >> isViennaImplicitFunctionDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaImplicitFunctionDefinitionNode >> isViennaImplicitFunctionDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaImplicitFunctionDefinitionNode >> label [

	^ 'ImplicitFunctionDefinition'
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> measure [

	^ nil
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> parameterTypes [

	^ self at: 3
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> parameterTypes: aViennaParameterTypesNode [

	self at: 3 put: aViennaParameterTypesNode
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> parameters [

	^ self parameterTypes parameters
		  parent: self;
		  yourself
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> parametersList [

	^ (ViennaParametersListNode with: self parameters)
		  parent: self;
		  yourself
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> post [

	^ self at: 6
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> post: aViennaExpressionNode [

	self at: 6 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> pre [

	^ self at: 5
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> pre: aViennaExpressionNode [

	self at: 5 put: aViennaExpressionNode
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> resolve [

	^ self
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> returnIdentifiers [

	^ self identifierTypePairList identifiers
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> returnType [

	^ self identifierTypePairList type
		  parent: self;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> shortName [

	^ self identifier
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> type [

	^ (ViennaPartialFunctionTypeNode
		   argumentType: self argumentType
		   returnType: self returnType)
		  parent: self;
		  yourself
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> typeVariableList [

	^ self at: 2
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 2 put: aViennaTypeVariableListNode
]
