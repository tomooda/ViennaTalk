Class {
	#name : #ViennaExtendedExplicitOperationDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaExtendedExplicitOperationDefinitionNode class >> access: aViennaAccessNode identifier: aString patternTypePairList: aViennaPatternTypePairListNode identifierTypePairList: aViennaIdentifierTypePairListNode statement: aViennaStatementNode externals: aViennaExternalsNode pre: aViennaExpressionNode1 post: aViennaExpressionNode2 exceptions: aViennaExceptionsNode [

	^ (self new: 9)
		  access: aViennaAccessNode;
		  identifier: aString;
		  patternTypePairList: aViennaPatternTypePairListNode;
		  identifierTypePairList: aViennaIdentifierTypePairListNode;
		  statement: aViennaStatementNode;
		  externals: aViennaExternalsNode;
		  pre: aViennaExpressionNode1;
		  post: aViennaExpressionNode2;
		  exceptions: aViennaExceptionsNode;
		  yourself
]

{ #category : #'instance creation' }
ViennaExtendedExplicitOperationDefinitionNode class >> identifier: aString patternTypePairList: aViennaPatternTypePairListNode identifierTypePairList: aViennaIdentifierTypePairListNode statement: aViennaStatementNode externals: aViennaExternalsNode pre: aViennaExpressionNode1 post: aViennaExpressionNode2 exceptions: aViennaExceptionsNode [

	^ self
		  access: ViennaAccessNode empty
		  identifier: aString
		  patternTypePairList: aViennaPatternTypePairListNode
		  identifierTypePairList: aViennaIdentifierTypePairListNode
		  statement: aViennaStatementNode
		  externals: aViennaExternalsNode
		  pre: aViennaExpressionNode1
		  post: aViennaExpressionNode2
		  exceptions: aViennaExceptionsNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> argumentType [

	^ self patternTypePairList type
]

{ #category : #'accessing-definitions' }
ViennaExtendedExplicitOperationDefinitionNode >> asAccessDefinition [

	^ self
]

{ #category : #private }
ViennaExtendedExplicitOperationDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self.
	self pre ifNotNil: [
		aBlock cull: 'pre_' , self identifier cull: self ].
	self post ifNotNil: [
		aBlock cull: 'post_' , self identifier cull: self ]
]

{ #category : #'accessing-definitions' }
ViennaExtendedExplicitOperationDefinitionNode >> definitionOfLocalName: aString [

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
ViennaExtendedExplicitOperationDefinitionNode >> exceptions [

	^ self at: 9
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> exceptions: aViennaExceptionsNode [

	self at: 9 put: aViennaExceptionsNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> externals [

	^ self at: 6
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> externals: aViennaExternalsNode [

	self at: 6 put: aViennaExternalsNode
]

{ #category : #'accessing-definitions' }
ViennaExtendedExplicitOperationDefinitionNode >> findResolverForIdentifier: aString [

	^ ((self returnIdentifiers includes: aString) or: [
		   self parameters bindsIdentifier: aString ])
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaExtendedExplicitOperationDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| access identifier patternTypePairList identifierTypePairList operationBody externals pre post exceptions |
	access := (aViennaAbstractFormatter format: self access) trim
		          ifNotEmpty: [ :string | string , ' ' ].
	identifier := aViennaAbstractFormatter format: self identifier.
	patternTypePairList := aViennaAbstractFormatter format:
		                       self patternTypePairList.
	identifierTypePairList := aViennaAbstractFormatter format:
		                          self identifierTypePairList.
	operationBody := aViennaAbstractFormatter format: self statement.
	externals := self externals
		             ifNotNil: [
		             String cr
		             , (aViennaAbstractFormatter format: self externals) ]
		             ifNil: [ '' ].
	pre := self pre
		       ifNotNil: [
			       String cr , (aViennaAbstractFormatter keyword: 'pre ')
			       , (aViennaAbstractFormatter format: self pre) ]
		       ifNil: [ '' ].
	post := self post
		        ifNotNil: [
			        String cr , (aViennaAbstractFormatter keyword: 'post ')
			        , (aViennaAbstractFormatter format: self post) ]
		        ifNil: [ '' ].
	exceptions := self exceptions
		              ifNotNil: [
		              String cr
		              , (aViennaAbstractFormatter format: self exceptions) ]
		              ifNil: [ '' ].
	^ access , (aViennaAbstractFormatter format: identifier)
	  , (aViennaAbstractFormatter format: patternTypePairList)
	  , (aViennaAbstractFormatter format: identifierTypePairList) , ' =='
	  , String cr , aViennaAbstractFormatter indent
	  , (aViennaAbstractFormatter indentString:
			   (aViennaAbstractFormatter format: operationBody)) , externals
	  , pre , post , exceptions
]

{ #category : #private }
ViennaExtendedExplicitOperationDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet.
	self type freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self parameters freeIdentifiersExcept: boundIdentifiers do: aBlock.
	boundIdentifiers := boundIdentifiers
	                    , self parameters uniqueBoundIdentifiers
	                    , self returnIdentifiers.
	self statement freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self pre ifNotNil: [ :pre |
		pre freeIdentifiersExcept: boundIdentifiers do: aBlock ].
	self post ifNotNil: [ :post |
		post freeIdentifiersExcept: boundIdentifiers do: aBlock ]
]

{ #category : #testing }
ViennaExtendedExplicitOperationDefinitionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> identifier [

	^ self at: 2
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> identifier: aString [

	self at: 2 put: aString
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> identifierTypePairList [

	^ self at: 4
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> identifierTypePairList: aViennaIdentifierTypePairListNode [

	self at: 4 put: aViennaIdentifierTypePairListNode
]

{ #category : #testing }
ViennaExtendedExplicitOperationDefinitionNode >> isOperationDefinition [

	^ true
]

{ #category : #testing }
ViennaExtendedExplicitOperationDefinitionNode >> isViennaAccessOperationDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExtendedExplicitOperationDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExtendedExplicitOperationDefinitionNode >> isViennaExtendedExplicitOperationDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExtendedExplicitOperationDefinitionNode >> isViennaOperationDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaExtendedExplicitOperationDefinitionNode >> isViennaOperationDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> label [

	^ 'ExtendedExplicitOperationDefinition'
]

{ #category : #'accessing-definitions' }
ViennaExtendedExplicitOperationDefinitionNode >> lookupIdentifier: aString [

	self patternTypePairList patternsDo: [ :pattern |
		(pattern bindsIdentifier: aString) ifTrue: [ ^ pattern ] ].
	(self identifierTypePairList bindsIdentifier: aString) ifTrue: [
		^ self ].
	^ nil
]

{ #category : #typechecking }
ViennaExtendedExplicitOperationDefinitionNode >> maximalType [

	self maximalType: self type typecheck.
	self patternTypePairList typecheck.
	self identifierTypePairList typecheck.
	self externals ifNotNil: #typecheck.
	self exceptions ifNotNil: #typecheck.
	self statement typecheck: self type typecheck returntype.
	self pre ifNotNil: [ :pre | pre typecheck: ViennaType bool ].
	self post ifNotNil: [ :post | post typecheck: ViennaType bool ].
	^ maximalType
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> parameterTypes [

	^ self at: 3
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> parameterTypes: aViennaParameterTypesNode [

	self at: 3 put: aViennaParameterTypesNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> parameters [

	^ self patternTypePairList parameters
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> parser [

	^ ViennaVDMParser new operationDefinition end
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> patternTypePairList [

	^ self at: 3
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> patternTypePairList: aViennaPatternTypePairListNode [

	self at: 3 put: aViennaPatternTypePairListNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> post [

	^ self at: 8
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> post: aViennaExpressionNode [

	self at: 8 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> pre [

	^ self at: 7
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> pre: aViennaExpressionNode [

	self at: 7 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> returnIdentifiers [

	^ self identifierTypePairList identifiers
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> returnType [

	^ self identifierTypePairList type
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> statement [

	^ self at: 5
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> statement: aViennaStatementNode [

	self at: 5 put: aViennaStatementNode
]

{ #category : #accessing }
ViennaExtendedExplicitOperationDefinitionNode >> type [

	^ (ViennaOperationTypeNode
		   argumentType: self argumentType copyFragment
		   returnType: self returnType copyFragment)
		  parent: self;
		  yourself
]
