Class {
	#name : 'ViennaSetComprehensionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaSetComprehensionNode class >> expression: aViennaExpressionNode1 bindList: aViennaBindListNode suchthatExpression: aViennaExpressionNode2 [

	^ (self new: 3)
		  expression: aViennaExpressionNode1;
		  bindList: aViennaBindListNode;
		  suchthatExpression: aViennaExpressionNode2;
		  yourself
]

{ #category : 'accessing' }
ViennaSetComprehensionNode >> bindList [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaSetComprehensionNode >> bindList: aViennaBindListNode [

	self at: 2 put: aViennaBindListNode
]

{ #category : 'accessing-definitions' }
ViennaSetComprehensionNode >> definitionOfLocalName: aString [

	self patternsDo: [ :pattern |
		pattern
			allDescendantsSuchThat: [ :n |
			n isViennaPatternIdentifierNode: aString ]
			do: [ :n | ^ n ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing' }
ViennaSetComprehensionNode >> expression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaSetComprehensionNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'accessing-definitions' }
ViennaSetComprehensionNode >> findResolverForIdentifier: aString [

	^ (self bindList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaSetComprehensionNode >> formatWith: aViennaAbstractFormatter [

	| expression bindList guard |
	expression := aViennaAbstractFormatter format: self expression.
	bindList := aViennaAbstractFormatter format: self bindList.
	guard := self suchthatExpression
		         ifNotNil: [ :node |
			         aViennaAbstractFormatter empty
			         ++ aViennaAbstractFormatter dot
			         ++ aViennaAbstractFormatter space
			         ++ (aViennaAbstractFormatter format: node) ]
		         ifNil: [ '' ].
	^ aViennaAbstractFormatter empty ++ '{' ++ (aViennaAbstractFormatter
		   indentString: (aViennaAbstractFormatter
				    indentString: expression
				    insertCrIfNeeded:
				    aViennaAbstractFormatter empty ++ '| ' ++ bindList)
		   insertCrIfNeeded: guard) ++ '}'
]

{ #category : 'private' }
ViennaSetComprehensionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| newBoundIdentifiers |
	self bindList freeIdentifiersExcept: aSet do: aBlock.
	newBoundIdentifiers := aSet , self bindList uniqueBoundIdentifiers.
	self suchthatExpression ifNotNil: [ :suchthat |
		suchthat freeIdentifiersExcept: newBoundIdentifiers do: aBlock ].
	self expression freeIdentifiersExcept: newBoundIdentifiers do: aBlock
]

{ #category : 'testing' }
ViennaSetComprehensionNode >> hasScope [

	^ true
]

{ #category : 'testing' }
ViennaSetComprehensionNode >> isViennaSetComprehensionNode [

	^ true
]

{ #category : 'accessing' }
ViennaSetComprehensionNode >> label [

	^ 'SetComprehension'
]

{ #category : 'accessing-definitions' }
ViennaSetComprehensionNode >> lookupIdentifier: aString [

	self bindList do: [ :multiplebind |
		multiplebind patternList do: [ :pattern |
			(pattern bindsIdentifier: aString) ifTrue: [ ^ multiplebind ] ] ].
	^ nil
]

{ #category : 'typechecking' }
ViennaSetComprehensionNode >> maximalType [

	self bindList typecheck.
	self suchthatExpression ifNotNil: [ :exp |
		exp typecheck: ViennaType bool ].
	^ self expression typecheck set
]

{ #category : 'typechecking' }
ViennaSetComprehensionNode >> maximalType: aViennaType [

	| basetype |
	self bindList typecheck.
	aViennaType isAnyType
		ifTrue: [ basetype := ViennaType any ]
		ifFalse: [
			basetype := ViennaType unit.
			aViennaType
				possibleTypesSuchThat: #isSetType
				do: [ :setType | basetype := basetype + setType basetype ] ].
	self expression maximalType: basetype.
	super maximalType: aViennaType
]

{ #category : 'enumerating' }
ViennaSetComprehensionNode >> multipleBindsDo: aBlock [

	self bindList do: aBlock
]

{ #category : 'enumerating' }
ViennaSetComprehensionNode >> patternsDo: aBlock [

	self multipleBindsDo: [ :multipleBind |
		multipleBind patternsDo: aBlock ]
]

{ #category : 'accessing' }
ViennaSetComprehensionNode >> suchthatExpression [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaSetComprehensionNode >> suchthatExpression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]
