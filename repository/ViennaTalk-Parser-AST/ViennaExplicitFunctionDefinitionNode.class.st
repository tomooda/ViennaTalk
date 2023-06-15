Class {
	#name : #ViennaExplicitFunctionDefinitionNode,
	#superclass : #ViennaObsoleteNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExplicitFunctionDefinitionNode class >> identifier: aString typeVariableList: aViennaTypeVariableListNode type: aViennaTypeNode parametersList: aViennaParametersListNode expression: aViennaExpressionNode1 pre: aViennaExpressionNode2 post: aViennaExpressionNode3 measure: aViennaExpressionNode4 [

	^ (self new: 9)
		  identifier: aString;
		  typeVariableList: aViennaTypeVariableListNode;
		  type: aViennaTypeNode;
		  parametersList: aViennaParametersListNode;
		  expression: aViennaExpressionNode1;
		  pre: aViennaExpressionNode2;
		  post: aViennaExpressionNode3;
		  measure: aViennaExpressionNode4;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaExplicitFunctionDefinitionNode >> asAccessDefinition [

	^ (ViennaFunctionDefinitionNode definition: self) asAccessDefinition
]

{ #category : #'accessing-definitions' }
ViennaExplicitFunctionDefinitionNode >> asExport [

	^ ViennaFunctionExportNode
		  nameList: (ViennaNameListNode with:
				   (ViennaLocalNameNode identifier: self identifier))
		  typeVariableList: (self typeVariableList ifNotNil: #copyFragment)
		  type: (self type ifNotNil: #copyFragment)
]

{ #category : #'accessing-definitions' }
ViennaExplicitFunctionDefinitionNode >> asImportDefinitionIn: moduleName [

	^ ViennaImportDefinitionNode
		  moduleIdentifier: self module identifier
		  importModuleSignature: (ViennaImportModuleSignatureNode with:
				   (ViennaImportFunctionsSignatureNode with:
					    (ViennaFunctionImportNode
						     name: (ViennaLocalNameNode identifier: self identifier)
						     typeVariableList:
						     (self typeVariableList ifNotNil: #copyFragment)
						     type: (self type ifNotNil: #copyFragment)
						     rename: nil)))
]

{ #category : #'accessing-definitions' }
ViennaExplicitFunctionDefinitionNode >> definitionOfLocalName: aString [

	self parametersList
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> expression [

	^ self at: 6
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> expression: aViennaExpressionNode [

	self at: 6 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaExplicitFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| identifier typeVariableList functionType parametersList expression pre post measure |
	identifier := aViennaAbstractFormatter format: self identifier.
	typeVariableList := aViennaAbstractFormatter format:
		                    self typeVariableList.
	functionType := aViennaAbstractFormatter format: self type.
	parametersList := aViennaAbstractFormatter format:
		                  self parametersList.
	expression := aViennaAbstractFormatter format: self expression.
	pre := self pre
		       ifNotNil: [ :node |
			       String cr , 'pre ' , (aViennaAbstractFormatter format: node) ]
		       ifNil: [ '' ].
	post := self post
		        ifNotNil: [ :node |
			        String cr , 'post '
			        , (aViennaAbstractFormatter format: node) ]
		        ifNil: [ '' ].
	measure := self measure
		           ifNotNil: [ :node |
			           String cr , 'measure '
			           , (aViennaAbstractFormatter format: node) ]
		           ifNil: [ '' ].
	^ identifier , typeVariableList , ' : ' , functionType , String cr
	  , (aViennaAbstractFormatter
			   indentString: identifier , parametersList , ' =='
			   insertCrIfNeeded: expression) , pre , post , measure
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> identifier: aString [

	self
		at: 1 put: aString;
		at: 4 put: aString
]

{ #category : #testing }
ViennaExplicitFunctionDefinitionNode >> isViennaExplicitFunctionDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExplicitFunctionDefinitionNode >> isViennaExplicitFunctionDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> label [

	^ 'ExplicitFunctionDefinition'
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> measure [

	^ self at: 9
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> measure: aViennaExpressionNode [

	self at: 9 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> parametersList [

	^ self at: 5
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> parametersList: aViennaParametersListNode [

	self at: 5 put: aViennaParametersListNode
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> post [

	^ self at: 8
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> post: aViennaExpressionNode [

	self at: 8 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> pre [

	^ self at: 7
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> pre: aViennaExpressionNode [

	self at: 7 put: aViennaExpressionNode
]

{ #category : #'accessing-definitions' }
ViennaExplicitFunctionDefinitionNode >> resolve [

	^ self
]

{ #category : #'accessing-definitions' }
ViennaExplicitFunctionDefinitionNode >> shortName [

	^ self identifier
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> type [

	^ self at: 3
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> type: aViennaTypeNode [

	self at: 3 put: aViennaTypeNode
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> typeVariableList [

	^ self at: 2
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 2 put: aViennaTypeVariableListNode
]
