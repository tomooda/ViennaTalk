Class {
	#name : #ViennaImplicitFunctionDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaImplicitFunctionDefinitionNode class >> access: aViennaAccessNode identifier: aString typeVariableList: aViennaTypeVariableListNode patternTypePairList: aViennaPatternTypePairListNode identifierTypePairList: aViennaIdentifierTypePairListNode pre: aViennaExpressionNode1 post: aViennaExpressionNode2 [

	^ (self new: 7)
		  access: aViennaAccessNode;
		  identifier: aString;
		  typeVariableList: aViennaTypeVariableListNode;
		  patternTypePairList: aViennaPatternTypePairListNode;
		  identifierTypePairList: aViennaIdentifierTypePairListNode;
		  pre: aViennaExpressionNode1;
		  post: aViennaExpressionNode2;
		  yourself
]

{ #category : #'instance creation' }
ViennaImplicitFunctionDefinitionNode class >> identifier: aString typeVariableList: aViennaTypeVariableListNode patternTypePairList: aViennaPatternTypePairListNode identifierTypePairList: aViennaIdentifierTypePairListNode pre: aViennaExpressionNode1 post: aViennaExpressionNode2 [

	^ self
		  access: ViennaAccessNode empty
		  identifier: aString
		  typeVariableList: aViennaTypeVariableListNode
		  patternTypePairList: aViennaPatternTypePairListNode
		  identifierTypePairList: aViennaIdentifierTypePairListNode
		  pre: aViennaExpressionNode1
		  post: aViennaExpressionNode2
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> argumentType [

	^ self patternTypePairList type
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> asAccessDefinition [

	^ self
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

	aBlock cull: self identifier cull: self.
	self pre ifNotNil: [
		aBlock cull: 'pre_' , self identifier cull: self ].
	self post ifNotNil: [
		aBlock cull: 'post_' , self identifier cull: self ]
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> definitionOfLocalName: aString [

	self typeVariableList do: [ :typeVariable |
		(typeVariable bindsIdentifier: aString) ifTrue: [ ^ typeVariable ] ].
	self patternTypePairList
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	self identifierTypePairList
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> expression [

	^ nil
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> findResolverForIdentifier: aString [

	^ ((self returnIdentifiers includes: aString) or: [
		   (self typeVariableList bindsIdentifier: aString) or: [
			   self parameters bindsIdentifier: aString ] ])
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaImplicitFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| identifier typeVariableList patternTypePairList identifierTypePairList pre post |
	identifier := aViennaAbstractFormatter format: self identifier.
	typeVariableList := aViennaAbstractFormatter format:
		                    self typeVariableList.
	patternTypePairList := aViennaAbstractFormatter format:
		                       self patternTypePairList.
	identifierTypePairList := aViennaAbstractFormatter format:
		                          self identifierTypePairList.
	pre := self pre
		       ifNotNil: [
		       String cr , 'pre '
		       , (aViennaAbstractFormatter format: self pre) ]
		       ifNil: [ '' ].
	post := self post
		        ifNotNil: [
		        String cr , 'post '
		        , (aViennaAbstractFormatter format: self post) ]
		        ifNil: [ '' ].
	^ identifier , (aViennaAbstractFormatter format: typeVariableList)
	  , (aViennaAbstractFormatter format: patternTypePairList)
	  , (aViennaAbstractFormatter format: identifierTypePairList) , pre
	  , post
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

	^ self at: 2
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> identifier: aString [

	self at: 2 put: aString
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> identifierTypePairList [

	^ self at: 5
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> identifierTypePairList: aViennaIdentifierTypePairListNode [

	self at: 5 put: aViennaIdentifierTypePairListNode
]

{ #category : #testing }
ViennaImplicitFunctionDefinitionNode >> isFunctionDefinition [

	^ true
]

{ #category : #testing }
ViennaImplicitFunctionDefinitionNode >> isViennaAccessFunctionDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaImplicitFunctionDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaImplicitFunctionDefinitionNode >> isViennaFunctionDefinitionNode: aString [

	^ self identifier = aString
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

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> lookupIdentifier: aString [

	self typeVariableList do: [ :typeVariable |
		(typeVariable bindsIdentifier: aString) ifTrue: [ ^ typeVariable ] ].
	self patternTypePairList patternsDo: [ :pattern |
		(pattern bindsIdentifier: aString) ifTrue: [ ^ pattern ] ].
	(self identifierTypePairList bindsIdentifier: aString) ifTrue: [
		^ self ].
	^ nil
]

{ #category : #typechecking }
ViennaImplicitFunctionDefinitionNode >> maximalType [

	self maximalType: self type typecheck.
	self typeVariableList typecheck.
	self patternTypePairList typecheck.
	self identifierTypePairList typecheck.
	self pre ifNotNil: [ :pre | pre typecheck: ViennaType bool ].
	self post ifNotNil: [ :post | post typecheck: ViennaType bool ].
	self measure ifNotNil: [ :measure |
		measure typecheck:
			self type argumentType typecheck -> ViennaType nat ].
	^ maximalType
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> measure [

	^ nil
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> parameterTypes [

	^ self at: 4
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> parameterTypes: aViennaParameterTypesNode [

	self at: 4 put: aViennaParameterTypesNode
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> parameters [

	^ self patternTypePairList parameters
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> parametersList [

	^ ViennaParametersListNode with: self parameters copyFragment
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> parser [

	^ ViennaVDMParser new functionDefinition end
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> patternTypePairList [

	^ self at: 4
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> patternTypePairList: aViennaPatternTypePairListNode [

	self at: 4 put: aViennaPatternTypePairListNode
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> post [

	^ self at: 7
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> post: aViennaExpressionNode [

	self at: 7 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> pre [

	^ self at: 6
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> pre: aViennaExpressionNode [

	self at: 6 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> returnIdentifiers [

	^ self identifierTypePairList identifiers
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> returnType [

	^ self identifierTypePairList type
]

{ #category : #'accessing-definitions' }
ViennaImplicitFunctionDefinitionNode >> shortName [

	^ self identifier
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> type [

	^ (ViennaPartialFunctionTypeNode
		   argumentType: self argumentType copyFragment
		   returnType: self returnType copyFragment)
		  parent: self;
		  yourself
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> typeVariableList [

	^ self at: 3
]

{ #category : #accessing }
ViennaImplicitFunctionDefinitionNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 3 put: aViennaTypeVariableListNode
]
