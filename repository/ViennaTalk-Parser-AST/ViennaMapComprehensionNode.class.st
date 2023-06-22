Class {
	#name : #ViennaMapComprehensionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaMapComprehensionNode class >> keyExpression: aViennaExpressionNode1 valueExpression: aViennaExpressionNode2 bindList: aViennaBindListNode suchthatExpression: aViennaExpressionNode3 [

	^ (self new: 4)
		  keyExpression: aViennaExpressionNode1;
		  valueExpression: aViennaExpressionNode2;
		  bindList: aViennaBindListNode;
		  suchthatExpression: aViennaExpressionNode3;
		  yourself
]

{ #category : #accessing }
ViennaMapComprehensionNode >> bindList [

	^ self at: 3
]

{ #category : #accessing }
ViennaMapComprehensionNode >> bindList: aViennaBindListNode [

	self at: 3 put: aViennaBindListNode
]

{ #category : #'accessing-definitions' }
ViennaMapComprehensionNode >> definitionOfLocalName: aString [

	self patternsDo: [ :pattern |
		pattern
			allDescendantsSuchThat: [ :n |
			n isViennaPatternIdentifierNode: aString ]
			do: [ :n | ^ n ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #'pretty printing' }
ViennaMapComprehensionNode >> formatWith: aViennaAbstractFormatter [

	| keyExpression valueExpression bindList guard |
	keyExpression := aViennaAbstractFormatter format: self keyExpression.
	valueExpression := aViennaAbstractFormatter format:
		                   self valueExpression.
	bindList := aViennaAbstractFormatter format: self bindList.
	guard := self suchthatExpression ifNil: [ '' ] ifNotNil: [ :node |
		         aViennaAbstractFormatter dot , ' '
		         , (aViennaAbstractFormatter format: node) ].
	(aViennaAbstractFormatter needsIndent:
		 keyExpression , valueExpression , bindList , guard) ifFalse: [
		^ '{' , keyExpression , ' ' , aViennaAbstractFormatter maplet , ' '
		  , valueExpression , ' | ' , bindList , guard , '}' ].
	^ '{' , (aViennaAbstractFormatter
		   noIndentString: (aViennaAbstractFormatter
				    noIndentString: keyExpression
				    insertCrIfNeeded:
				    aViennaAbstractFormatter maplet , ' ' , valueExpression)
		   insertCrIfNeeded: (aViennaAbstractFormatter
				    noIndentString: '| ' , bindList
				    insertCrIfNeeded: guard)) , '}'
]

{ #category : #private }
ViennaMapComprehensionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| boundIdentifiers |
	boundIdentifiers := aSet , self bindList uniqueBoundIdentifiers.
	self bindList freeIdentifiersExcept: aSet do: aBlock.
	self suchthatExpression
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock.
	self keyExpression freeIdentifiersExcept: boundIdentifiers do: aBlock.
	self valueExpression
		freeIdentifiersExcept: boundIdentifiers
		do: aBlock
]

{ #category : #testing }
ViennaMapComprehensionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaMapComprehensionNode >> isViennaMapComprehensionNode [

	^ true
]

{ #category : #accessing }
ViennaMapComprehensionNode >> keyExpression [

	^ self at: 1
]

{ #category : #accessing }
ViennaMapComprehensionNode >> keyExpression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaMapComprehensionNode >> label [

	^ 'MapComprehension'
]

{ #category : #enumerating }
ViennaMapComprehensionNode >> multipleBindsDo: aBlock [

	self bindList do: aBlock
]

{ #category : #enumerating }
ViennaMapComprehensionNode >> patternsDo: aBlock [

	self multipleBindsDo: [ :multipleBind |
		multipleBind patternsDo: aBlock ]
]

{ #category : #'accessing-definitions' }
ViennaMapComprehensionNode >> resolveIdentifier: aString [

	^ (self bindList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super resolveIdentifier: aString ]
]

{ #category : #accessing }
ViennaMapComprehensionNode >> suchthatExpression [

	^ self at: 4
]

{ #category : #accessing }
ViennaMapComprehensionNode >> suchthatExpression: aViennaExpressionNode [

	self at: 4 put: aViennaExpressionNode
]

{ #category : #accessing }
ViennaMapComprehensionNode >> valueExpression [

	^ self at: 2
]

{ #category : #accessing }
ViennaMapComprehensionNode >> valueExpression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]
