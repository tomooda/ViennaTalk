Class {
	#name : #ViennaExtendedExplicitFunctionDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExtendedExplicitFunctionDefinitionNode class >> identifier: aString typeVariableList: aViennaTypeVariableListNode parameterTypes: aViennaParameterTypesNode identifierTypePairList: aViennaIdentifierTypePairListNode expression: aViennaExpressionNode1 pre: aViennaExpressionNode2 post: aViennaExpressionNode3 [

	^ (self new: 7)
		  identifier: aString;
		  typeVariableList: aViennaTypeVariableListNode;
		  parameterTypes: aViennaParameterTypesNode;
		  identifierTypePairList: aViennaIdentifierTypePairListNode;
		  expression: aViennaExpressionNode1;
		  pre: aViennaExpressionNode2;
		  post: aViennaExpressionNode3;
		  yourself
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> argumentType [

	^ self parameterTypes patternTypePairList type
]

{ #category : #private }
ViennaExtendedExplicitFunctionDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock value: self identifier.
	self pre ifNotNil: [ aBlock value: 'pre_' , self identifier ].
	self post ifNotNil: [ aBlock value: 'post_' , self identifier ]
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> expression [

	^ self at: 5
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> expression: aViennaExpressionNode [

	self at: 5 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaExtendedExplicitFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| identifier typeVariableList parameterTypes identifierTypePairList expression pre post |
	identifier := self identifier.
	typeVariableList := self typeVariableList.
	parameterTypes := self parameterTypes.
	identifierTypePairList := self identifierTypePairList.
	expression := self expression.
	pre := self pre.
	post := self post.
	^ (aViennaAbstractFormatter format: identifier)
	  , (aViennaAbstractFormatter format: typeVariableList)
	  , (aViennaAbstractFormatter format: parameterTypes)
	  , (aViennaAbstractFormatter format: identifierTypePairList) , ' =='
	  , String cr , aViennaAbstractFormatter indent
	  , (aViennaAbstractFormatter indentString:
			   (aViennaAbstractFormatter format: expression)) , (pre
		   ifNotNil: [
		   String cr , 'pre ' , (aViennaAbstractFormatter format: pre) ]
		   ifNil: [ '' ]) , String cr , 'post '
	  , (aViennaAbstractFormatter format: post)
]

{ #category : #testing }
ViennaExtendedExplicitFunctionDefinitionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> identifierTypePairList [

	^ self at: 4
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> identifierTypePairList: aViennaIdentifierTypePairListNode [

	self at: 4 put: aViennaIdentifierTypePairListNode
]

{ #category : #testing }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaExtendedExplicitFunctionDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaExtendedExplicitFunctionDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> label [

	^ 'ExtendedExplicitFunctionDefinition'
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> parameterTypes [

	^ self at: 3
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> parameterTypes: aViennaParameterTypesNode [

	self at: 3 put: aViennaParameterTypesNode
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> post [

	^ self at: 7
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> post: aViennaExpressionNode [

	self at: 7 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> pre [

	^ self at: 6
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> pre: aViennaExpressionNode [

	self at: 6 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> returnIdentifier [

	^ self identifierTypePairList first
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> returnType [

	^ self identifierTypePairList type
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> type [

	^ ViennaPartialFunctionTypeNode
		  argumentType: self argumentType
		  returnType: self returnType
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> typeVariableList [

	^ self at: 2
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 2 put: aViennaTypeVariableListNode
]
