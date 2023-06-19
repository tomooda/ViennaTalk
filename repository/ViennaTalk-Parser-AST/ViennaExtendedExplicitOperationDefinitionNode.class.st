Class {
	#name : #ViennaExtendedExplicitOperationDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExtendedExplicitOperationDefinitionNode class >> identifier: aString parameterTypes: aViennaParameterTypesNode identifierTypePairList: aViennaIdentifierTypePairListNode operationBody: aViennaOperfationBodyNode externals: aViennaExternalsNode pre: aViennaExpressionNode1 post: aViennaExpressionNode2 exceptions: aViennaExceptionsNode [

	^ (self new: 8)
		  identifier: aString;
		  parameterTypes: aViennaParameterTypesNode;
		  identifierTypePairList: aViennaIdentifierTypePairListNode;
		  operationBody: aViennaOperfationBodyNode;
		  externals: aViennaExternalsNode;
		  pre: aViennaExpressionNode1;
		  post: aViennaExpressionNode2;
		  exceptions: aViennaExceptionsNode;
		  yourself
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> argumentType [

	^ self parameterTypes patternTypePairList type
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> exceptions [

	^ self at: 8
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> exceptions: aViennaExceptionsNode [

	self at: 8 put: aViennaExceptionsNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> externals [

	^ self at: 5
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> externals: aViennaExternalsNode [

	self at: 5 put: aViennaExternalsNode
]

{ #category : #'pretty printing' }
ViennaExtendedExplicitOperationDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| identifier parameterTypes identifierTypePairList operationBody externals pre post exceptions string |
	identifier := self identifier.
	parameterTypes := self parameterTypes.
	identifierTypePairList := self identifierTypePairList.
	operationBody := self operationBody.
	externals := self externals.
	pre := self pre.
	post := self post.
	exceptions := self exceptions.
	string := (aViennaAbstractFormatter format: identifier)
	          , (aViennaAbstractFormatter format: parameterTypes)
	          , (aViennaAbstractFormatter format: identifierTypePairList)
	          , ' ==' , String cr , aViennaAbstractFormatter indent
	          , (aViennaAbstractFormatter indentString:
			           (aViennaAbstractFormatter format: operationBody)).
	externals ifNotNil: [
		string := string , String cr
		          , (aViennaAbstractFormatter format: externals) ].
	pre ifNotNil: [
		string := string , String cr , 'pre '
		          , (aViennaAbstractFormatter format: pre) ].
	string := string , String cr , 'post '
	          , (aViennaAbstractFormatter format: post).
	exceptions ifNotNil: [
		string := string , String cr
		          , (aViennaAbstractFormatter format: exceptions) ].
	^ string
]

{ #category : #testing }
ViennaExtendedExplicitOperationDefinitionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> identifierTypePairList [

	^ self at: 3
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> identifierTypePairList: aViennaIdentifierTypePairListNode [

	self at: 3 put: aViennaIdentifierTypePairListNode
]

{ #category : #testing }
ViennaExtendedExplicitOperationDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExtendedExplicitOperationDefinitionNode >> isViennaExtendedExplicitOperationDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> label [

	^ 'ExtendedExplicitOperationDefinition'
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> operationBody [

	^ self at: 4
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> operationBody: aViennaOperationBodyNode [

	self at: 4 put: aViennaOperationBodyNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> parameterTypes [

	^ self at: 2
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> parameterTypes: aViennaParameterTypesNode [

	self at: 2 put: aViennaParameterTypesNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> post [

	^ self at: 7
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> post: aViennaExpressionNode [

	self at: 7 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> pre [

	^ self at: 6
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> pre: aViennaExpressionNode [

	self at: 6 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> returnIdentifier [

	^ self identifierTypePairList first
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> returnType [

	^ self identifierTypePairList type
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> type [

	^ ViennaOperationTypeNode
		  argumentType: self argumentType
		  returnType: self returnType
]
