Class {
	#name : #ViennaExplicitOperationDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExplicitOperationDefinitionNode class >> identifier: aString type: aViennaTypeNode parameters: aViennaParametersNode operationBody: aViennaOperationBodyNode pre: aViennaExpresssionNode1 post: aViennaExpressionNode2 [

	^ (self new: 7)
		  identifier: aString;
		  type: aViennaTypeNode;
		  parameters: aViennaParametersNode;
		  operationBody: aViennaOperationBodyNode;
		  pre: aViennaExpresssionNode1;
		  post: aViennaExpressionNode2;
		  yourself
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> argumentType [

	^ self type argumentType
]

{ #category : #'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> asAccessDefinition [

	^ (ViennaOperationDefinitionNode definition: self) asAccessDefinition
]

{ #category : #'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> asExport [

	^ ViennaOperationExportNode
		  nameList: (ViennaNameListNode withAll:
				   { (ViennaLocalNameNode identifier: self identifier) })
		  type: (self type ifNotNil: #copyFragment)
]

{ #category : #'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> asImportDefinitionIn: moduleNode [

	^ ViennaImportDefinitionNode
		  moduleIdentifier: self module identifier
		  importModuleSignature: (ViennaImportModuleSignatureNode with:
				   (ViennaImportOperationsSignatureNode with:
					    (ViennaOperationImportNode
						     name: (ViennaLocalNameNode identifier: self identifier)
						     type: (self type ifNotNil: #copyFragment)
						     rename: nil)))
]

{ #category : #'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> definitionOfLocalName: aString [

	self parameters
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'pretty printing' }
ViennaExplicitOperationDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| identifier operationType parameters statement pre post |
	identifier := aViennaAbstractFormatter format: self identifier.
	operationType := aViennaAbstractFormatter format: self type.
	parameters := aViennaAbstractFormatter format: self parameters.
	statement := aViennaAbstractFormatter format: self operationBody.
	pre := self pre
		       ifNotNil: [ :node |
			       String cr , (aViennaAbstractFormatter
				        indentString: 'pre '
				        insertCrIfNeeded: (aViennaAbstractFormatter format: node)) ]
		       ifNil: [ '' ].
	post := self post
		        ifNotNil: [ :node |
			        String cr , (aViennaAbstractFormatter
				         indentString: 'post '
				         insertCrIfNeeded: (aViennaAbstractFormatter format: node)) ]
		        ifNil: [ '' ].
	^ identifier , ' : ' , operationType , String cr
	  , (aViennaAbstractFormatter
			   indentString: identifier , parameters , ' =='
			   insertCrIfNeeded: statement) , pre , post
]

{ #category : #testing }
ViennaExplicitOperationDefinitionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> identifier: aString [

	self
		at: 1 put: aString;
		at: 3 put: aString
]

{ #category : #testing }
ViennaExplicitOperationDefinitionNode >> isViennaExplicitOperationDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExplicitOperationDefinitionNode >> isViennaExplicitOperationDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaExplicitOperationDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> label [

	^ 'ExplicitOperationDefinition'
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> operationBody [

	^ self at: 5
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> operationBody: aViennaOperationBodyNode [

	self at: 5 put: aViennaOperationBodyNode
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> parameters [

	^ self at: 4
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> parameters: aViennaParametersNode [

	self at: 4 put: aViennaParametersNode
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> post [

	^ self at: 7
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> post: aViennaExpressionNode [

	self at: 7 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> pre [

	^ self at: 6
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> pre: aViennaExpression [

	self at: 6 put: aViennaExpression
]

{ #category : #'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> resolve [

	^ self
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> returnIdentifier [

	^ 'RESULT'
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> returnType [

	^ self type returnType
]

{ #category : #'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> shortName [

	^ self identifier
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaExplicitOperationDefinitionNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
