Class {
	#name : #ViennaExplicitFunctionDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaExplicitFunctionDefinitionNode class >> access: aViennaAccessNode identifier: aString typeVariableList: aViennaTypeVariableListNode type: aViennaTypeNode parametersList: aViennaParametersListNode expression: aViennaExpressionNode1 pre: aViennaExpressionNode2 post: aViennaExpressionNode3 measure: aViennaExpressionNode4 [

	^ (self new: 10)
		  access: aViennaAccessNode;
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

{ #category : #'instance creation' }
ViennaExplicitFunctionDefinitionNode class >> identifier: aString typeVariableList: aViennaTypeVariableListNode type: aViennaTypeNode parametersList: aViennaParametersListNode expression: aViennaExpressionNode1 pre: aViennaExpressionNode2 post: aViennaExpressionNode3 measure: aViennaExpressionNode4 [

	^ self
		  access: ViennaAccessNode empty
		  identifier: aString
		  typeVariableList: aViennaTypeVariableListNode
		  type: aViennaTypeNode
		  parametersList: aViennaParametersListNode
		  expression: aViennaExpressionNode1
		  pre: aViennaExpressionNode2
		  post: aViennaExpressionNode3
		  measure: aViennaExpressionNode4
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> argumentType [

	^ self type argumentType
]

{ #category : #'accessing-definitions' }
ViennaExplicitFunctionDefinitionNode >> asAccessDefinition [

	^ self
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

{ #category : #private }
ViennaExplicitFunctionDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self.
	self pre ifNotNil: [
		aBlock cull: 'pre_' , self identifier cull: self ].
	self post ifNotNil: [
		aBlock cull: 'post_' , self identifier cull: self ].
	self measure ifNotNil: [
		aBlock cull: 'measure_' , self identifier cull: self ]
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

	^ self at: 7
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> expression: aViennaExpressionNode [

	self at: 7 put: aViennaExpressionNode
]

{ #category : #'accessing-definitions' }
ViennaExplicitFunctionDefinitionNode >> findResolverForIdentifier: aString [

	^ (aString = 'RESULT' or: [
		   (self typeVariableList bindsIdentifier: aString) or: [
			   self parametersList bindsIdentifier: aString ] ])
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaExplicitFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| access identifier typeVariableList functionType parametersList expression pre post measure |
	access := (aViennaAbstractFormatter format: self access) trim
		          ifNotEmpty: [ :string |
		          string , aViennaAbstractFormatter space ].
	identifier := aViennaAbstractFormatter identifier: self identifier.
	typeVariableList := aViennaAbstractFormatter format:
		                    self typeVariableList.
	functionType := aViennaAbstractFormatter format: self type.
	parametersList := aViennaAbstractFormatter format:
		                  self parametersList.
	expression := aViennaAbstractFormatter format: self expression.
	pre := self pre
		       ifNotNil: [ :node |
			       aViennaAbstractFormatter cr
			       , (aViennaAbstractFormatter keyword: 'pre ')
			       , (aViennaAbstractFormatter format: node) ]
		       ifNil: [ aViennaAbstractFormatter empty ].
	post := self post
		        ifNotNil: [ :node |
			        aViennaAbstractFormatter cr
			        , (aViennaAbstractFormatter keyword: 'post ')
			        , (aViennaAbstractFormatter format: node) ]
		        ifNil: [ aViennaAbstractFormatter empty ].
	measure := self measure
		           ifNotNil: [ :node |
			           aViennaAbstractFormatter cr
			           , (aViennaAbstractFormatter keyword: 'measure ')
			           , (aViennaAbstractFormatter format: node) ]
		           ifNil: [ aViennaAbstractFormatter empty ].
	^ access , identifier , typeVariableList , ' : ' , functionType
	  , aViennaAbstractFormatter cr , (aViennaAbstractFormatter
		   indentString: identifier , parametersList , ' =='
		   insertCrIfNeeded: expression) , pre , post , measure
]

{ #category : #private }
ViennaExplicitFunctionDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet
	                    , self typeVariableList uniqueBoundIdentifiers.
	self type freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self parametersList
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock.
	boundIdentifiers := boundIdentifiers
	                    , self parametersList uniqueBoundIdentifiers.
	self expression freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self pre ifNotNil: [ :pre |
		pre freeIdentifiersExcept: boundIdentifiers do: aBlock ].
	self post ifNotNil: [ :post |
		post freeIdentifiersExcept: boundIdentifiers do: aBlock ].
	self measure ifNotNil: [ :measure |
		measure freeIdentifiersExcept: boundIdentifiers do: aBlock ]
]

{ #category : #testing }
ViennaExplicitFunctionDefinitionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> identifier [

	^ self at: 2
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> identifier: aString [

	self
		at: 2 put: aString;
		at: 5 put: aString
]

{ #category : #testing }
ViennaExplicitFunctionDefinitionNode >> isFunctionDefinition [

	^ true
]

{ #category : #testing }
ViennaExplicitFunctionDefinitionNode >> isViennaAccessFunctionDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExplicitFunctionDefinitionNode >> isViennaExplicitFunctionDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExplicitFunctionDefinitionNode >> isViennaExplicitFunctionDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaExplicitFunctionDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExplicitFunctionDefinitionNode >> isViennaFunctionDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> label [

	^ 'ExplicitFunctionDefinition'
]

{ #category : #'accessing-definitions' }
ViennaExplicitFunctionDefinitionNode >> lookupIdentifier: aString [

	aString = 'RESULT' ifTrue: [ ^ self ].
	self typeVariableList do: [ :typeVariable |
		(typeVariable bindsIdentifier: aString) ifTrue: [ ^ typeVariable ] ].
	self parametersList do: [ :parameters |
		parameters do: [ :parameter |
			(parameter bindsIdentifier: aString) ifTrue: [ ^ parameter ] ] ].
	^ nil
]

{ #category : #typechecking }
ViennaExplicitFunctionDefinitionNode >> maximalType [

	| returnType |
	self typeVariableList typecheck.
	self maximalType: self type typecheck.
	returnType := maximalType.
	self parametersList do: [ :parameters |
		returnType isFunctionType
			ifTrue: [
				returnType argtypes size = parameters size
					ifTrue: [
						1 to: parameters size do: [ :index |
							(parameters at: index) maximalType:
								(returnType argtypes at: index) ].
						returnType := returnType returntype ]
					ifFalse: [
						^ ViennaTypeError
							  on: self
							  signal: 'Type mismatch: parameters are ' , parameters source
								  , ' but the type is declared ' , returnType printString ] ]
			ifFalse: [
				^ ViennaTypeError
					  on: self
					  signal: 'Type mismatch: the order of the parameters is '
						  , self parametersList size printString
						  , ' but the type is declared ' , self type source ] ].
	self expression typecheck: returnType.
	self pre ifNotNil: [ :pre | pre typecheck: ViennaType bool ].
	self post ifNotNil: [ :post | post typecheck: ViennaType bool ].
	self measure ifNotNil: [ :measure |
		measure typecheck:
			self type argumentType typecheck -> ViennaType nat + ViennaType nat ].
	^ maximalType
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> measure [

	^ self at: 10
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> measure: aViennaExpressionNode [

	self at: 10 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> parametersList [

	^ self at: 6
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> parametersList: aViennaParametersListNode [

	self at: 6 put: aViennaParametersListNode
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> parser [

	^ ViennaVDMParser new functionDefinition end
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> post [

	^ self at: 9
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> post: aViennaExpressionNode [

	self at: 9 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> pre [

	^ self at: 8
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> pre: aViennaExpressionNode [

	self at: 8 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> returnIdentifiers [

	^ #( 'RESULT' )
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> returnType [

	^ self parametersList inject: self type into: [ :t :params |
		  t isViennaFunctionTypeNode
			  ifTrue: [ t returnType ]
			  ifFalse: [ ^ nil ] ]
]

{ #category : #'accessing-definitions' }
ViennaExplicitFunctionDefinitionNode >> shortName [

	^ self identifier
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> type [

	^ self at: 4
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> type: aViennaTypeNode [

	self at: 4 put: aViennaTypeNode
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> typeVariableList [

	^ self at: 3
]

{ #category : #accessing }
ViennaExplicitFunctionDefinitionNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 3 put: aViennaTypeVariableListNode
]
