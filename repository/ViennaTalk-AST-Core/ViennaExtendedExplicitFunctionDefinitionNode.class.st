Class {
	#name : 'ViennaExtendedExplicitFunctionDefinitionNode',
	#superclass : 'ViennaTopLevelDefinitionNode',
	#type : 'variable',
	#traits : 'TPrePostFunction',
	#classTraits : 'TPrePostFunction classTrait',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaExtendedExplicitFunctionDefinitionNode class >> access: aViennaAccessNode identifier: aString typeVariableList: aViennaTypeVariableListNode patternTypePairList: aViennaPatternTypePairListNode identifierTypePairList: aViennaIdentifierTypePairListNode expression: aViennaExpressionNode1 pre: aViennaExpressionNode2 post: aViennaExpressionNode3 measure: aViennaExpressionNode4 [

	^ (self new: 9)
		  access: aViennaAccessNode;
		  identifier: aString;
		  typeVariableList: aViennaTypeVariableListNode;
		  patternTypePairList: aViennaPatternTypePairListNode;
		  identifierTypePairList: aViennaIdentifierTypePairListNode;
		  expression: aViennaExpressionNode1;
		  preFunction: aViennaExpressionNode2;
		  postFunction: aViennaExpressionNode3;
		  measure: aViennaExpressionNode4;
		  yourself
]

{ #category : 'instance creation' }
ViennaExtendedExplicitFunctionDefinitionNode class >> identifier: aString typeVariableList: aViennaTypeVariableListNode patternTypePairList: aViennaPatternTypePairListNode identifierTypePairList: aViennaIdentifierTypePairListNode expression: aViennaExpressionNode1 pre: aViennaExpressionNode2 post: aViennaExpressionNode3 measure: aViennaExpressionNode4 [

	^ self
		  access: ViennaAccessNode empty
		  identifier: aString
		  typeVariableList: aViennaTypeVariableListNode
		  patternTypePairList: aViennaPatternTypePairListNode
		  identifierTypePairList: aViennaIdentifierTypePairListNode
		  expression: aViennaExpressionNode1
		  pre: aViennaExpressionNode2
		  post: aViennaExpressionNode3
		  measure: aViennaExpressionNode4
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> access [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> argumentType [

	^ self patternTypePairList type
]

{ #category : 'accessing-definitions' }
ViennaExtendedExplicitFunctionDefinitionNode >> asAccessDefinition [

	^ self
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> body [

	^ self expression
]

{ #category : 'private' }
ViennaExtendedExplicitFunctionDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self.
	self pre ifNotNil: [
		aBlock cull: 'pre_' , self identifier cull: self ].
	self post ifNotNil: [
		aBlock cull: 'post_' , self identifier cull: self ].
	self measure ifNotNil: [
		aBlock cull: 'measure_' , self identifier cull: self ]
]

{ #category : 'accessing-definitions' }
ViennaExtendedExplicitFunctionDefinitionNode >> definitionOfLocalName: aString [

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

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> expression [

	^ self at: 6
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> expression: aViennaExpressionNode [

	self at: 6 put: aViennaExpressionNode
]

{ #category : 'accessing-definitions' }
ViennaExtendedExplicitFunctionDefinitionNode >> findResolverForIdentifier: aString [

	^ ((self returnIdentifiers includes: aString) or: [
		   (self typeVariableList bindsIdentifier: aString) or: [
			   self parameters bindsIdentifier: aString ] ])
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaExtendedExplicitFunctionDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| access identifier typeVariableList patternTypePairList identifierTypePairList expression pre post |
	access := (aViennaAbstractFormatter format: self access) trim
		          ifNotEmpty: [ :string |
		          string ++ aViennaAbstractFormatter space ].
	identifier := aViennaAbstractFormatter format: self identifier.
	typeVariableList := aViennaAbstractFormatter format:
		                    self typeVariableList.
	patternTypePairList := aViennaAbstractFormatter format:
		                       self patternTypePairList.
	identifierTypePairList := aViennaAbstractFormatter format:
		                          self identifierTypePairList.
	expression := aViennaAbstractFormatter format: self expression.
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
			        ++ aViennaAbstractFormatter format: self post ]
		        ifNil: [ aViennaAbstractFormatter empty ].
	^ access ++ identifier ++ typeVariableList ++ patternTypePairList
	  ++ identifierTypePairList ++ ' ==' ++ String cr
	  ++ aViennaAbstractFormatter indent
	  ++ (aViennaAbstractFormatter indentString: expression) ++ pre ++ post
]

{ #category : 'private' }
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

{ #category : 'testing' }
ViennaExtendedExplicitFunctionDefinitionNode >> hasScope [

	^ true
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> identifier [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> identifier: aString [

	self at: 2 put: aString
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> identifierTypePairList [

	^ self at: 5
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> identifierTypePairList: aViennaIdentifierTypePairListNode [

	self at: 5 put: aViennaIdentifierTypePairListNode
]

{ #category : 'testing' }
ViennaExtendedExplicitFunctionDefinitionNode >> isFunctionDefinition [

	^ true
]

{ #category : 'testing' }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaAccessFunctionDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaExtendedExplicitFunctionDefinitionNode [

	^ true
]

{ #category : 'testing' }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaExtendedExplicitFunctionDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : 'testing' }
ViennaExtendedExplicitFunctionDefinitionNode >> isViennaFunctionDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> label [

	^ 'ExtendedExplicitFunctionDefinition'
]

{ #category : 'accessing-definitions' }
ViennaExtendedExplicitFunctionDefinitionNode >> lookupIdentifier: aString [

	self typeVariableList do: [ :typeVariable |
		(typeVariable bindsIdentifier: aString) ifTrue: [ ^ typeVariable ] ].
	self patternTypePairList patternsDo: [ :pattern |
		(pattern bindsIdentifier: aString) ifTrue: [ ^ pattern ] ].
	(self identifierTypePairList bindsIdentifier: aString) ifTrue: [
		^ self ].
	^ nil
]

{ #category : 'typechecking' }
ViennaExtendedExplicitFunctionDefinitionNode >> maximalType [

	self maximalType: self type typecheck.
	self typeVariableList typecheck.
	self patternTypePairList typecheck.
	self identifierTypePairList typecheck.
	self expression typecheck.
	self pre ifNotNil: #typecheck.
	self post ifNotNil: #typecheck.
	self measure ifNotNil: [ :measure |
		measure typecheck:
			self type argumentType typecheck -> ViennaType nat ].
	^ maximalType
]

{ #category : 'typechecking' }
ViennaExtendedExplicitFunctionDefinitionNode >> maximalTypeOfPrePostDefinition: aViennaPrePostDefinitionNode [

	self preFunction == aViennaPrePostDefinitionNode ifTrue: [
		aViennaPrePostDefinitionNode body typecheck: ViennaType bool.
		^ self argumentType asMaximalViennaType -> ViennaType bool ].
	self postFunction == aViennaPrePostDefinitionNode ifTrue: [
		aViennaPrePostDefinitionNode body typecheck: ViennaType bool.
		^ self argumentType asMaximalViennaType
		  * self returnType asMaximalViennaType -> ViennaType bool ].
	^ nil
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> measure [

	^ self at: 9
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> measure: aViennaExpressionNode [

	self at: 9 put: aViennaExpressionNode
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> parameterTypes: aViennaParameterTypesNode [

	self at: 4 put: aViennaParameterTypesNode
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> parameters [

	^ self patternTypePairList parameters
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> parametersList [

	^ ViennaParametersListNode with: self parameters copyFragment
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> patternTypePairList [

	^ self at: 4
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> patternTypePairList: aViennaPatternTypePairList [

	self at: 4 put: aViennaPatternTypePairList
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> postFunction [

	^ self at: 8
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> postFunction: aViennaPrePostFunctionDefinitionNode [

	self at: 8 put: aViennaPrePostFunctionDefinitionNode
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> preFunction [

	^ self at: 7
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> preFunction: aViennaPrePostFunctionDefinitionNode [

	self at: 7 put: aViennaPrePostFunctionDefinitionNode
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> returnIdentifiers [

	^ self identifierTypePairList identifiers
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> returnType [

	^ self identifierTypePairList type
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> type [

	^ (ViennaPartialFunctionTypeNode
		   argumentType: self argumentType copyFragment
		   returnType: self returnType copyFragment)
		  parent: self;
		  yourself
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> typeVariableList [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaExtendedExplicitFunctionDefinitionNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 3 put: aViennaTypeVariableListNode
]
