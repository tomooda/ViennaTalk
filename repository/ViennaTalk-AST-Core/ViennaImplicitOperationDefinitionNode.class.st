Class {
	#name : 'ViennaImplicitOperationDefinitionNode',
	#superclass : 'ViennaTopLevelDefinitionNode',
	#type : 'variable',
	#traits : 'TPrePostFunction',
	#classTraits : 'TPrePostFunction classTrait',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaImplicitOperationDefinitionNode class >> access: aViennaAccessNode identifier: aString patternTypePairList: aViennaPatternTypePairListNode identifierTypePairList: aViennaIdentifierTypePairListNode externals: aViennaExternalsNode pre: aViennaExpression1 post: aViennaExpression2 exceptions: aViennaExceptionsNode [

	^ (self new: 8)
		  access: aViennaAccessNode;
		  identifier: aString;
		  patternTypePairList: aViennaPatternTypePairListNode;
		  identifierTypePairList: aViennaIdentifierTypePairListNode;
		  externals: aViennaExternalsNode;
		  preFunction: aViennaExpression1;
		  postFunction: aViennaExpression2;
		  exceptions: aViennaExceptionsNode;
		  yourself
]

{ #category : 'instance creation' }
ViennaImplicitOperationDefinitionNode class >> identifier: aString patternTypePairList: aViennaPatternTypePairListNode identifierTypePairList: aViennaIdentifierTypePairListNode externals: aViennaExternalsNode pre: aViennaExpression1 post: aViennaExpression2 exceptions: aViennaExceptionsNode [

	^ self
		  access: ViennaAccessNode empty
		  identifier: aString
		  patternTypePairList: aViennaPatternTypePairListNode
		  identifierTypePairList: aViennaIdentifierTypePairListNode
		  externals: aViennaExternalsNode
		  pre: aViennaExpression1
		  post: aViennaExpression2
		  exceptions: aViennaExceptionsNode
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> access [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> addToModule: aViennaModuleNode [

	^ aViennaModuleNode module addOperationDefinition: self copyFragment
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> argumentType [

	^ self patternTypePairList type
]

{ #category : 'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> asExport [

	^ ViennaOperationExportNode
		  nameList: (ViennaNameListNode withAll:
				   { (ViennaLocalNameNode identifier: self identifier) })
		  type: self type
]

{ #category : 'accessing-definitions' }
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

{ #category : 'private' }
ViennaImplicitOperationDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self.
	self pre ifNotNil: [
		aBlock cull: 'pre_' , self identifier cull: self ].
	self post ifNotNil: [
		aBlock cull: 'post_' , self identifier cull: self ]
]

{ #category : 'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> definitionOfLocalName: aString [

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

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> exceptions [

	^ self at: 8
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> exceptions: aViennaExceptionsNode [

	self at: 8 put: aViennaExceptionsNode
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> externals [

	^ self at: 5
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> externals: aViennaExternalsNode [

	self at: 5 put: aViennaExternalsNode
]

{ #category : 'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> findResolverForIdentifier: aString [

	^ ((self returnIdentifiers includes: aString) or: [
		   self parameters bindsIdentifier: aString ])
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaImplicitOperationDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| access identifier patternTypePairList identifierTypePairList externals pre post exceptions |
	access := (aViennaAbstractFormatter format: self access) trim
		          ifNotEmpty: [ :string |
		          string ++ aViennaAbstractFormatter space ].
	identifier := aViennaAbstractFormatter format: self identifier.
	patternTypePairList := aViennaAbstractFormatter format:
		                       self patternTypePairList.
	identifierTypePairList := aViennaAbstractFormatter format:
		                          self identifierTypePairList.
	externals := self externals
		             ifNotNil: [
			             aViennaAbstractFormatter cr
			             ++ (aViennaAbstractFormatter format: self externals) ]
		             ifNil: [ aViennaAbstractFormatter empty ].
	pre := self pre
		       ifNotNil: [
			       aViennaAbstractFormatter cr
			       ++ (aViennaAbstractFormatter keyword: 'pre ')
			       ++ (aViennaAbstractFormatter format: self pre) ]
		       ifNil: [ aViennaAbstractFormatter empty ].
	post := self post
		        ifNotNil: [
			        aViennaAbstractFormatter cr
			        ++ (aViennaAbstractFormatter keyword: 'post ')
			        ++ (aViennaAbstractFormatter format: self post) ]
		        ifNil: [ aViennaAbstractFormatter empty ].
	exceptions := self exceptions
		              ifNotNil: [
			              aViennaAbstractFormatter cr
			              ++ (aViennaAbstractFormatter format: self exceptions) ]
		              ifNil: [ aViennaAbstractFormatter empty ].
	^ aViennaAbstractFormatter empty ++ access ++ identifier
	  ++ patternTypePairList ++ identifierTypePairList ++ externals ++ pre
	  ++ post ++ exceptions
]

{ #category : 'private' }
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

{ #category : 'testing' }
ViennaImplicitOperationDefinitionNode >> hasScope [

	^ true
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> identifier [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> identifier: aString [

	self at: 2 put: aString
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> identifierTypePairList [

	^ self at: 4
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> identifierTypePairList: aViennaIdentifierTypePairListNode [

	self at: 4 put: aViennaIdentifierTypePairListNode
]

{ #category : 'testing' }
ViennaImplicitOperationDefinitionNode >> isOperationDefinition [

	^ true
]

{ #category : 'testing' }
ViennaImplicitOperationDefinitionNode >> isViennaAccessOperationDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaImplicitOperationDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaImplicitOperationDefinitionNode >> isViennaImplicitOperationDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaImplicitOperationDefinitionNode >> isViennaImplicitOperationDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : 'testing' }
ViennaImplicitOperationDefinitionNode >> isViennaOperationDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : 'testing' }
ViennaImplicitOperationDefinitionNode >> label [

	^ 'ImplicitOperationDefinition'
]

{ #category : 'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> lookupIdentifier: aString [

	self patternTypePairList patternsDo: [ :pattern |
		(pattern bindsIdentifier: aString) ifTrue: [ ^ pattern ] ].
	(self identifierTypePairList bindsIdentifier: aString) ifTrue: [
		^ self ].
	^ nil
]

{ #category : 'typechecking' }
ViennaImplicitOperationDefinitionNode >> maximalType [

	self maximalType: self type typecheck.
	self patternTypePairList typecheck.
	self identifierTypePairList typecheck.
	self externals ifNotNil: #typecheck.
	self exceptions ifNotNil: #typecheck.
	self pre ifNotNil: #typecheck.
	self post ifNotNil: #typecheck.
	^ maximalType
]

{ #category : 'typechecking' }
ViennaImplicitOperationDefinitionNode >> maximalTypeOfPrePostDefinition: aViennaPrePostDefinitionNode [

	self preFunction == aViennaPrePostDefinitionNode ifTrue: [
		| argtypes |
		argtypes := maximalType argtypes.
		(self module ifNil: [ self document ]) stateDefinition ifNotNil: [
			:stateDef | argtypes := argtypes copyWith: stateDef typecheck ].
		aViennaPrePostDefinitionNode body typecheck: ViennaType bool.
		^ (ViennaType product: argtypes) -> ViennaType bool ].
	self postFunction == aViennaPrePostDefinitionNode ifTrue: [
		| argtypes |
		argtypes := maximalType argtypes.
		maximalType returntype isUnitType ifFalse: [
			argtypes := argtypes copyWith: maximalType returntype ].
		(self module ifNil: [ self document ]) stateDefinition ifNotNil: [
			:stateDef |
			argtypes := argtypes copyWithAll:
				            (Array new: 2 withAll: stateDef typecheck) ].
		aViennaPrePostDefinitionNode body typecheck: ViennaType bool.
		^ (ViennaType product: argtypes) -> ViennaType bool ].
	^ nil
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> parameterTypes [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> parameterTypes: aViennaParameterTypesNode [

	self at: 3 put: aViennaParameterTypesNode
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> parameters [

	^ self patternTypePairList parameters
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> patternTypePairList [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> patternTypePairList: aViennaPatternTypePairListNode [

	self at: 3 put: aViennaPatternTypePairListNode
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> postFunction [

	^ self at: 7
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> postFunction: aViennaPrePostFunctionDefinitionNode [

	self at: 7 put: aViennaPrePostFunctionDefinitionNode
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> preFunction [

	^ self at: 6
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> preFunction: aViennaPrePostFunctionDefinitionNode [

	self at: 6 put: aViennaPrePostFunctionDefinitionNode
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> returnIdentifiers [

	^ self identifierTypePairList identifiers
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> returnType [

	^ self identifierTypePairList type
]

{ #category : 'accessing-definitions' }
ViennaImplicitOperationDefinitionNode >> shortName [

	^ self identifier
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> statement [

	^ nil
]

{ #category : 'accessing' }
ViennaImplicitOperationDefinitionNode >> type [

	^ (ViennaOperationTypeNode
		   argumentType: self argumentType copyFragment
		   returnType: self returnType copyFragment)
		  parent: self;
		  yourself
]
