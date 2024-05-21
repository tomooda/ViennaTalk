Class {
	#name : 'ViennaSequenceComprehensionNode',
	#superclass : 'ViennaExpressionNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'instance creation' }
ViennaSequenceComprehensionNode class >> expression: aViennaExpressionNode1 setSeqBind: aViennaSetSeqBindNode suchthatExpression: aViennaExpressionNode2 [

	^ (self new: 3)
		  expression: aViennaExpressionNode1;
		  setSeqBind: aViennaSetSeqBindNode;
		  suchthatExpression: aViennaExpressionNode2;
		  yourself
]

{ #category : 'accessing-definitions' }
ViennaSequenceComprehensionNode >> definitionOfLocalName: aString [

	self pattern
		allDescendantsSuchThat: [ :n |
		n isViennaPatternIdentifierNode: aString ]
		do: [ :n | ^ n ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : 'accessing' }
ViennaSequenceComprehensionNode >> expression [

	^ self at: 1
]

{ #category : 'accessing' }
ViennaSequenceComprehensionNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : 'accessing-definitions' }
ViennaSequenceComprehensionNode >> findResolverForIdentifier: aString [

	^ (self setSeqBind bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : 'pretty printing' }
ViennaSequenceComprehensionNode >> formatWith: aViennaAbstractFormatter [

	| expression setBind guard |
	expression := aViennaAbstractFormatter format: self expression.
	setBind := aViennaAbstractFormatter format: self setSeqBind.
	guard := self suchthatExpression
		         ifNotNil: [ :node |
			         aViennaAbstractFormatter empty
			         ++ aViennaAbstractFormatter dot
			         ++ aViennaAbstractFormatter space
			         ++ (aViennaAbstractFormatter format: node) ]
		         ifNil: [ aViennaAbstractFormatter empty ].
	^ aViennaAbstractFormatter empty ++ '[' ++ (aViennaAbstractFormatter
		   indentString: expression
		   insertCrIfNeeded: (aViennaAbstractFormatter
				    indentString: '| ' ++ setBind
				    insertCrIfNeeded: guard)) ++ ']'
]

{ #category : 'private' }
ViennaSequenceComprehensionNode >> freeIdentifiersExcept: aSet do: aBlock [

	| newBoundIdentifiers |
	self setSeqBind freeIdentifiersExcept: aSet do: aBlock.
	newBoundIdentifiers := aSet , self setSeqBind uniqueBoundIdentifiers.
	self suchthatExpression ifNotNil: [ :exp |
		exp freeIdentifiersExcept: newBoundIdentifiers do: aBlock ].
	self expression freeIdentifiersExcept: newBoundIdentifiers do: aBlock
]

{ #category : 'testing' }
ViennaSequenceComprehensionNode >> hasScope [

	^ true
]

{ #category : 'testing' }
ViennaSequenceComprehensionNode >> isViennaSequenceComprehensionNode [

	^ true
]

{ #category : 'accessing' }
ViennaSequenceComprehensionNode >> label [

	^ 'SequenceComprehension'
]

{ #category : 'accessing-definitions' }
ViennaSequenceComprehensionNode >> lookupIdentifier: aString [

	(self setSeqBind pattern bindsIdentifier: aString) ifTrue: [
		^ self setSeqBind pattern ].
	^ nil
]

{ #category : 'typechecking' }
ViennaSequenceComprehensionNode >> maximalType [

	self setSeqBind typecheck.
	self suchthatExpression ifNotNil: [ :exp |
		exp typecheck: ViennaType bool ].
	^ self expression typecheck seq
]

{ #category : 'typechecking' }
ViennaSequenceComprehensionNode >> maximalType: aViennaType [

	| basetype |
	self setSeqBind typecheck.
	aViennaType isAnyType
		ifTrue: [ basetype := ViennaType any ]
		ifFalse: [
			basetype := ViennaType unit.
			aViennaType
				possibleTypesSuchThat: #isSeqType
				do: [ :seqType | basetype := basetype + seqType basetype ] ].
	self expression maximalType: basetype.
	super maximalType: aViennaType
]

{ #category : 'accessing' }
ViennaSequenceComprehensionNode >> pattern [

	^ self setSeqBind pattern
]

{ #category : 'accessing' }
ViennaSequenceComprehensionNode >> setSeqBind [

	^ self at: 2
]

{ #category : 'accessing' }
ViennaSequenceComprehensionNode >> setSeqBind: aViennaSetSeqBindNode [

	self at: 2 put: aViennaSetSeqBindNode
]

{ #category : 'accessing' }
ViennaSequenceComprehensionNode >> suchthatExpression [

	^ self at: 3
]

{ #category : 'accessing' }
ViennaSequenceComprehensionNode >> suchthatExpression: aViennaExpressionNode [

	self at: 3 put: aViennaExpressionNode
]
