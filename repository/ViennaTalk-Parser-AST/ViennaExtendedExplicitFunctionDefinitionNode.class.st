Class {
	#name : #ViennaExtendedExplicitFunctionDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaExtendedExplicitFunctionDefinitionNode class >> access: aViennaAccessNode identifier: aString typeVariableList: aViennaTypeVariableListNode parameterTypes: aViennaParameterTypesNode identifierTypePairList: aViennaIdentifierTypePairListNode expression: aViennaExpressionNode1 pre: aViennaExpressionNode2 post: aViennaExpressionNode3 measure: aViennaExpressionNode4 [

	^ (self new: 9)
		  access: aViennaAccessNode;
		  identifier: aString;
		  typeVariableList: aViennaTypeVariableListNode;
		  parameterTypes: aViennaParameterTypesNode;
		  identifierTypePairList: aViennaIdentifierTypePairListNode;
		  expression: aViennaExpressionNode1;
		  pre: aViennaExpressionNode2;
		  post: aViennaExpressionNode3;
		  measure: aViennaExpressionNode4;
		  yourself
]

{ #category : #'instance creation' }
ViennaExtendedExplicitFunctionDefinitionNode class >> identifier: aString typeVariableList: aViennaTypeVariableListNode parameterTypes: aViennaParameterTypesNode identifierTypePairList: aViennaIdentifierTypePairListNode expression: aViennaExpressionNode1 pre: aViennaExpressionNode2 post: aViennaExpressionNode3 measure: aViennaExpressionNode4 [

	^ self
		  access: ViennaAccessNode empty
		  identifier: aString
		  typeVariableList: aViennaTypeVariableListNode
		  parameterTypes: aViennaParameterTypesNode
		  identifierTypePairList: aViennaIdentifierTypePairListNode
		  expression: aViennaExpressionNode1
		  pre: aViennaExpressionNode2
		  post: aViennaExpressionNode3
		  measure: aViennaExpressionNode4
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> argumentType [

	^ self parameterTypes type
]

{ #category : #'accessing-definitions' }
ViennaExtendedExplicitFunctionDefinitionNode >> asAccessDefinition [

	^ self
]

{ #category : #private }
ViennaExtendedExplicitFunctionDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self.
	self pre ifNotNil: [
		aBlock cull: 'pre_' , self identifier cull: self ].
	self post ifNotNil: [
		aBlock cull: 'post_' , self identifier cull: self ]
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> expression [

	^ self at: 6
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> expression: aViennaExpressionNode [

	self at: 6 put: aViennaExpressionNode
]

{ #category : #'accessing-definitions' }
ViennaExtendedExplicitFunctionDefinitionNode >> findResolverForIdentifier: aString [

	^ ((self returnIdentifiers includes: aString) or: [
		   (self typeVariableList bindsIdentifier: aString) or: [
			   self parameters bindsIdentifier: aString ] ])
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaExtendedExplicitFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| access identifier typeVariableList parameterTypes identifierTypePairList expression pre post |
	access := (aViennaAbstractFormatter format: self access) trim
		          ifNotEmpty: [ :string | string , ' ' ].
	identifier := aViennaAbstractFormatter format: self identifier.
	typeVariableList := aViennaAbstractFormatter format:
		                    self typeVariableList.
	parameterTypes := aViennaAbstractFormatter format:
		                  self parameterTypes.
	identifierTypePairList := aViennaAbstractFormatter format:
		                          self identifierTypePairList.
	expression := aViennaAbstractFormatter format: self expression.
	pre := self pre
		       ifNotNil: [
		       String cr , 'pre '
		       , (aViennaAbstractFormatter format: self pre) ]
		       ifNil: [ '' ].
	post := self post
		        ifNotNil: [
		        String cr , 'post ' , aViennaAbstractFormatter format:
			        self post ]
		        ifNil: [ '' ].
	^ access , identifier , typeVariableList , parameterTypes
	  , identifierTypePairList , ' ==' , String cr
	  , aViennaAbstractFormatter indent
	  , (aViennaAbstractFormatter indentString: expression) , pre , post
]

{ #category : #private }
ViennaExtendedExplicitFunctionDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet
	                    , self typeVariableList uniqueBoundIdentifiers.
	self type freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self parameters freeIdentifiersExcept: boundIdentifiers do: aBlock.
	boundIdentifiers := boundIdentifiers
	                    , self parameters uniqueBoundIdentifiers
	                    , self returnIdentifiers.
	self expression freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self pre ifNotNil: [ :pre |
		pre freeIdentifiersExcept: boundIdentifiers do: aBlock ].
	self post ifNotNil: [ :post |
		post freeIdentifiersExcept: boundIdentifiers do: aBlock ]
]

{ #category : #testing }
ViennaExtendedExplicitFunctionDefinitionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> identifier [

	^ self at: 2
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> identifier: aString [

	self at: 2 put: aString
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> identifierTypePairList [

	^ self at: 5
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> identifierTypePairList: aViennaIdentifierTypePairListNode [

	self at: 5 put: aViennaIdentifierTypePairListNode
]

{ #category : #testing }
ViennaExtendedExplicitFunctionDefinitionNode >> isFunctionDefinition [

	^ true
]

{ #category : #testing }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaAccessFunctionDefinitionNode [

	^ true
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

{ #category : #testing }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaFunctionDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> label [

	^ 'ExtendedExplicitFunctionDefinition'
]

{ #category : #'accessing-definitions' }
ViennaExtendedExplicitFunctionDefinitionNode >> lookupIdentifier: aString [

	self typeVariableList do: [ :typeVariable |
		(typeVariable bindsIdentifier: aString) ifTrue: [ ^ typeVariable ] ].
	self parameterTypes patternsDo: [ :pattern |
		(pattern bindsIdentifier: aString) ifTrue: [ ^ pattern ] ].
	(self identifierTypePairList bindsIdentifier: aString) ifTrue: [
		^ self ].
	^ nil
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> measure [

	^ self at: 9
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> measure: aViennaExpressionNode [

	self at: 9 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> parameterTypes [

	^ self at: 4
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> parameterTypes: aViennaParameterTypesNode [

	self at: 4 put: aViennaParameterTypesNode
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> parameters [

	^ self parameterTypes parameters
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> parametersList [

	^ ViennaParametersListNode with: self parameters copyFragment
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> post [

	^ self at: 8
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> post: aViennaExpressionNode [

	self at: 8 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> pre [

	^ self at: 7
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> pre: aViennaExpressionNode [

	self at: 7 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> returnIdentifiers [

	^ self identifierTypePairList identifiers
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> returnType [

	^ self identifierTypePairList type
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> type [

	^ (ViennaPartialFunctionTypeNode
		   argumentType: self argumentType copyFragment
		   returnType: self returnType copyFragment)
		  parent: self;
		  yourself
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> typeVariableList [

	^ self at: 3
]

{ #category : #accessing }
ViennaExtendedExplicitFunctionDefinitionNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 3 put: aViennaTypeVariableListNode
]
