Class {
	#name : 'ViennaExplicitOperationDefinitionNode',
	#superclass : 'ViennaTopLevelDefinitionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaExplicitOperationDefinitionNode class >> access: aViennaAccessNode identifier: aString type: aViennaTypeNode parameters: aViennaParametersNode statement: aViennaStatementNode pre: aViennaExpresssionNode1 post: aViennaExpressionNode2 [

	^ (self new: 8)
		  access: aViennaAccessNode;
		  identifier: aString;
		  type: aViennaTypeNode;
		  parameters: aViennaParametersNode;
		  statement: aViennaStatementNode;
		  pre: aViennaExpresssionNode1;
		  post: aViennaExpressionNode2;
		  yourself
]

{ #category : 'instance creation' }
ViennaExplicitOperationDefinitionNode class >> identifier: aString type: aViennaTypeNode parameters: aViennaParametersNode statement: aViennaStatementNode pre: aViennaExpresssionNode1 post: aViennaExpressionNode2 [

	^ self
		  access: ViennaAccessNode empty
		  identifier: aString
		  type: aViennaTypeNode
		  parameters: aViennaParametersNode
		  statement: aViennaStatementNode
		  pre: aViennaExpresssionNode1
		  post: aViennaExpressionNode2
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> access [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> argumentType [

	^ self type argumentType
]

{ #category : 'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> asAccessDefinition [

	^ self
]

{ #category : 'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> asExport [

	^ ViennaOperationExportNode
		  nameList: (ViennaNameListNode withAll:
				   { (ViennaLocalNameNode identifier: self identifier) })
		  type: (self type ifNotNil: #copyFragment)
]

{ #category : 'accessing-definitions' }
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

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> body [

	^ self statement
]

{ #category : 'private' }
ViennaExplicitOperationDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self.
	self pre ifNotNil: [
		aBlock cull: 'pre_' , self identifier cull: self ].
	self post ifNotNil: [
		aBlock cull: 'post_' , self identifier cull: self ]
]

{ #category : 'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> definitionOfLocalName: aString [

	self parameters
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> findResolverForIdentifier: aString [

	^ (aString = 'RESULT' or: [ self parameters bindsIdentifier: aString ])
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaExplicitOperationDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| access identifier operationType parameters statement pre post |
	access := (aViennaAbstractFormatter format: self access) trim
		          ifNotEmpty: [ :string | string ++ ' ' ].
	identifier := aViennaAbstractFormatter format: self identifier.
	operationType := aViennaAbstractFormatter format: self type.
	parameters := aViennaAbstractFormatter format: self parameters.
	statement := aViennaAbstractFormatter format: self statement.
	pre := self pre
		       ifNotNil: [ :node |
			       aViennaAbstractFormatter cr ++ (aViennaAbstractFormatter
				        indentString: (aViennaAbstractFormatter keyword: 'pre ')
				        insertCrIfNeeded: (aViennaAbstractFormatter format: node)) ]
		       ifNil: [ aViennaAbstractFormatter empty ].
	post := self post
		        ifNotNil: [ :node |
			        aViennaAbstractFormatter cr ++ (aViennaAbstractFormatter
				         indentString: (aViennaAbstractFormatter keyword: 'post ')
				         insertCrIfNeeded: (aViennaAbstractFormatter format: node)) ]
		        ifNil: [ aViennaAbstractFormatter empty ].
	^ access ++ identifier ++ ' : ' ++ operationType ++ String cr
	  ++ (aViennaAbstractFormatter
			   indentString: identifier ++ parameters ++ ' =='
			   insertCrIfNeeded: statement) ++ pre ++ post
]

{ #category : 'private' }
ViennaExplicitOperationDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet.
	self type freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self parameters freeIdentifiersExcept: boundIdentifiers do: aBlock.
	boundIdentifiers := boundIdentifiers
	                    , self parameters uniqueBoundIdentifiers.
	self statement freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self pre ifNotNil: [ :pre |
		pre freeIdentifiersExcept: boundIdentifiers do: aBlock ].
	self post ifNotNil: [ :post |
		post freeIdentifiersExcept: boundIdentifiers do: aBlock ]
]

{ #category : 'testing' }
ViennaExplicitOperationDefinitionNode >> hasScope [

	^ true
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> identifier [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> identifier: aString [

	self
		at: 2 put: aString;
		at: 4 put: aString
]

{ #category : 'testing' }
ViennaExplicitOperationDefinitionNode >> isOperationDefinition [

	^ true
]

{ #category : 'testing' }
ViennaExplicitOperationDefinitionNode >> isViennaAccessOperationDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaExplicitOperationDefinitionNode >> isViennaExplicitOperationDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaExplicitOperationDefinitionNode >> isViennaExplicitOperationDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : 'testing' }
ViennaExplicitOperationDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaExplicitOperationDefinitionNode >> isViennaOperationDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> label [

	^ 'ExplicitOperationDefinition'
]

{ #category : 'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> lookupIdentifier: aString [

	aString = 'RESULT' ifTrue: [ ^ self ].
	self parameters do: [ :parameter |
		(parameter bindsIdentifier: aString) ifTrue: [ ^ parameter ] ].
	^ nil
]

{ #category : 'typechecking' }
ViennaExplicitOperationDefinitionNode >> maximalType [

	self maximalType: self type typecheck.
	maximalType isOperationType ifFalse: [
		^ ViennaTypeError
			  on: self
			  signal: 'Not an operation type: ' , self type source ].
	maximalType argtypes size = self parameters size
		ifTrue: [
			1 to: self parameters size do: [ :index |
				(self parameters at: index) maximalType:
					(maximalType argtypes at: index) ] ]
		ifFalse: [
			^ ViennaTypeError
				  on: self
				  signal: 'Type mismatch: ' , self parameters size printString
					  , ' parameter(s) declared, but the type is '
					  , maximalType argtypes size printString , '-arity' ].
	self statement typecheck: maximalType returntype.
	self pre ifNotNil: [ :pre |
		| argtypes |
		argtypes := maximalType argtypes.
		(self module ifNil: [ self document ]) stateDefinition ifNotNil: [
			:stateDef | argtypes := argtypes copyWith: stateDef typecheck ].
		pre
			setMaximalType: nil;
			typecheck: ViennaType bool;
			setMaximalType: (ViennaType product: argtypes) -> ViennaType bool ].
	self post ifNotNil: [ :post |
		| argtypes |
		argtypes := maximalType argtypes.
		maximalType returntype isUnitType ifFalse: [
			argtypes := argtypes copyWith: maximalType returntype ].
		(self module ifNil: [ self document ]) stateDefinition ifNotNil: [
			:stateDef |
			argtypes := argtypes copyWithAll:
				            (Array new: 2 withAll: stateDef typecheck) ].
		post
			setMaximalType: nil;
			typecheck: ViennaType bool;
			setMaximalType: (ViennaType product: argtypes) -> ViennaType bool ].
	^ maximalType
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> parameters [

	^ self at: 5
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> parameters: aViennaParametersNode [

	self at: 5 put: aViennaParametersNode
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> post [

	^ self at: 8
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> post: aViennaExpressionNode [

	self at: 8 put: aViennaExpressionNode
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> pre [

	^ self at: 7
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> pre: aViennaExpression [

	self at: 7 put: aViennaExpression
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> returnIdentifiers [

	^ #( 'RESULT' )
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> returnType [

	^ self type returnType
]

{ #category : 'accessing-definitions' }
ViennaExplicitOperationDefinitionNode >> shortName [

	^ self identifier
]

{ #category : 'private' }
ViennaExplicitOperationDefinitionNode >> statement [

	^ self at: 6
]

{ #category : 'private' }
ViennaExplicitOperationDefinitionNode >> statement: aViennaStatementNode [

	^ self at: 6 put: aViennaStatementNode
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> type [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaExplicitOperationDefinitionNode >> type: aViennaTypeNode [

	self at: 3 put: aViennaTypeNode
]
