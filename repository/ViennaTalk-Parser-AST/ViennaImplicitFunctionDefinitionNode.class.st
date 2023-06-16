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

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> asAccessDefinition [

	^ (ViennaFunctionDefinitionNode definition: self) asAccessDefinition
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> asExport [

	^ ViennaFunctionExportNode
		  nameList:
		  (ViennaNameListNode with:
			   (ViennaLocalNameNode identifier: self first))
		  typeVariableList: (self second ifNotNil: #copyFragment)
		  type: (ViennaPartialFunctionTypeNode
				   argumentType: self third first pairListToType
				   returnType: self fourth pairListToType)
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
						     type: (ViennaPartialFunctionTypeNode
								      argumentType: self third first pairListToType
								      returnType: self fourth pairListToType)
						     rename: nil)))
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
	identifier := self first.
	typeVariableList := self second.
	parameterTypes := self third.
	identifierTypePairList := self fourth.
	pre := self fifth.
	post := self sixth.
	^ (aViennaAbstractFormatter format: identifier)
	  , (aViennaAbstractFormatter format: typeVariableList)
	  , (aViennaAbstractFormatter format: parameterTypes)
	  , (aViennaAbstractFormatter format: identifierTypePairList) , (pre
		   ifNotNil: [
		   String cr , 'pre ' , (aViennaAbstractFormatter format: pre) ]
		   ifNil: [ String new ]) , String cr , 'post '
	  , (aViennaAbstractFormatter format: post)
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
ViennaImplicitFunctionDefinitionNode >> parameterTypes [

	^ self at: 3
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> parameterTypes: aViennaParameterTypesNode [

	self at: 3 put: aViennaParameterTypesNode
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

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> shortName [

	^ self identifier
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> typeVariableList [

	^ self at: 2
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 2 put: aViennaTypeVariableListNode
]
