Class {
	#name : 'ViennaMapComprehensionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaMapComprehensionNode class >> keyExpression: aViennaExpressionNode1 valueExpression: aViennaExpressionNode2 bindList: aViennaBindListNode suchthatExpression: aViennaExpressionNode3 [

	^ (self new: 4)
		  keyExpression: aViennaExpressionNode1;
		  valueExpression: aViennaExpressionNode2;
		  bindList: aViennaBindListNode;
		  suchthatExpression: aViennaExpressionNode3;
		  yourself
]

{ #category : 'accessing' }
ViennaMapComprehensionNode >> bindList [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaMapComprehensionNode >> bindList: aViennaBindListNode [

	self at: 3 put: aViennaBindListNode
]

{ #category : 'accessing-definitions' }
ViennaMapComprehensionNode >> definitionOfLocalName: aString [

	self patternsDo: [ :pattern |
		pattern
			allDescendantsSuchThat: [ :n |
			n isViennaPatternIdentifierNode: aString ]
			do: [ :n | ^ n ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing-definitions' }
ViennaMapComprehensionNode >> findResolverForIdentifier: aString [

	^ (self bindList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaMapComprehensionNode >> formatWith: aViennaAbstractFormatter [

	| keyExpression valueExpression bindList guard |
	keyExpression := aViennaAbstractFormatter format: self keyExpression.
	valueExpression := aViennaAbstractFormatter format:
		                   self valueExpression.
	bindList := aViennaAbstractFormatter format: self bindList.
	guard := self suchthatExpression ifNil: [ '' ] ifNotNil: [ :node |
		         aViennaAbstractFormatter dot ++ ' '
		         ++ (aViennaAbstractFormatter format: node) ].
	(aViennaAbstractFormatter needsIndent:
		 keyExpression ++ valueExpression ++ bindList ++ guard) ifFalse: [
		^ '{' ++ keyExpression ++ ' ' ++ aViennaAbstractFormatter maplet ++ ' '
		  ++ valueExpression ++ ' | ' ++ bindList ++ guard ++ '}' ].
	^ aViennaAbstractFormatter empty ++ '{' ++ (aViennaAbstractFormatter
		   noIndentString: (aViennaAbstractFormatter
				    noIndentString: keyExpression
				    insertCrIfNeeded:
				    aViennaAbstractFormatter maplet ++ ' ' ++ valueExpression)
		   insertCrIfNeeded: (aViennaAbstractFormatter
				    noIndentString:
				    aViennaAbstractFormatter empty ++ '| ' ++ bindList
				    insertCrIfNeeded: guard)) ++ '}'
]

{ #category : 'private' }
ViennaMapComprehensionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet , self bindList uniqueBoundIdentifiers.
	self bindList freeIdentifiersExcept: aSet do: aBlock.
	self suchthatExpression ifNotNil: [ :suchthat |
		suchthat freeIdentifiersExcept: boundIdentifiers do: aBlock ].
	self keyExpression freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self valueExpression
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock
]

{ #category : 'testing' }
ViennaMapComprehensionNode >> hasScope [

	^ true
]

{ #category : 'accessing' }
ViennaMapComprehensionNode >> isViennaMapComprehensionNode [

	^ true
]

{ #category : 'accessing' }
ViennaMapComprehensionNode >> keyExpression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaMapComprehensionNode >> keyExpression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'accessing' }
ViennaMapComprehensionNode >> label [

	^ 'MapComprehension'
]

{ #category : 'accessing-definitions' }
ViennaMapComprehensionNode >> lookupIdentifier: aString [

	self bindList do: [ :multiplebind |
		multiplebind patternList do: [ :pattern |
			(pattern bindsIdentifier: aString) ifTrue: [ ^ pattern ] ] ].
	^ nil
]

{ #category : 'typechecking' }
ViennaMapComprehensionNode >> maximalType [

	self bindList typecheck.
	self suchthatExpression ifNotNil: [ :exp |
		exp typecheck: ViennaType bool ].
	^ self keyExpression typecheck mapTo: self valueExpression typecheck
]

{ #category : 'typechecking' }
ViennaMapComprehensionNode >> maximalType: aViennaType [

	| keytype valuetype |
	self bindList typecheck.
	keytype := ViennaType unit.
	valuetype := ViennaType unit.
	aViennaType isAnyType
		ifTrue: [ keytype := valuetype := ViennaType any ]
		ifFalse: [
			aViennaType possibleTypesSuchThat: #isMapType do: [ :mapType |
				keytype := keytype + mapType keytype.
				valuetype := valuetype + mapType valuetype ] ].
	self keyExpression maximalType: keytype.
	self valueExpression maximalType: valuetype.
	super maximalType: aViennaType
]

{ #category : 'enumerating' }
ViennaMapComprehensionNode >> multipleBindsDo: aBlock [

	self bindList do: aBlock
]

{ #category : 'enumerating' }
ViennaMapComprehensionNode >> patternsDo: aBlock [

	self multipleBindsDo: [ :multipleBind |
		multipleBind patternsDo: aBlock ]
]

{ #category : 'accessing' }
ViennaMapComprehensionNode >> suchthatExpression [

	^ self at: 4
]

{ #category : 'accessing' }
ViennaMapComprehensionNode >> suchthatExpression: aViennaExpressionNode [

	self at: 4 put: aViennaExpressionNode
]

{ #category : 'accessing' }
ViennaMapComprehensionNode >> valueExpression [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaMapComprehensionNode >> valueExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]
