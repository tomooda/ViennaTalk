Class {
	#name : #ViennaLambdaExpressionNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaLambdaExpressionNode class >> typeBindList: aViennaTypeBindListNode expression: aViennaExpressionNode [

	^ (self new: 2)
		  typeBindList: aViennaTypeBindListNode;
		  expression: aViennaExpressionNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaLambdaExpressionNode >> definitionOfLocalName: aString [

	self patternsDo: [ :pattern |
		pattern
			allDescendantsSuchThat: [ :node |
			node isViennaPatternIdentifierNode: aString ]
			do: [ :node | ^ node ] ].
	^ parent ifNotNil: [ parent definitionOfLocalName: aString ]
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> expression [

	^ self at: 2
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> expression: aViennaExpressionNode [

	self at: 2 put: aViennaExpressionNode
]

{ #category : #'accessing-definitions' }
ViennaLambdaExpressionNode >> findResolverForIdentifier: aString [

	^ (self typeBindList bindsIdentifier: aString)
		  ifTrue: [ self ]
		  ifFalse: [ super findResolverForIdentifier: aString ]
]

{ #category : #'pretty printing' }
ViennaLambdaExpressionNode >> formatWith: aViennaAbstractFormatter [

	| typeBind expression |
	typeBind := aViennaAbstractFormatter format: self typeBindList.
	expression := aViennaAbstractFormatter format: self expression.
	^ aViennaAbstractFormatter
		  indentString:
			  aViennaAbstractFormatter empty , aViennaAbstractFormatter lambda
			  , ' ' , typeBind , ' ' , aViennaAbstractFormatter dot
		  insertCrIfNeeded: expression
]

{ #category : #private }
ViennaLambdaExpressionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self typeBindList freeIdentifiersExcept: aSet do: aBlock.
	self expression
		freeIdentifiersExcept:
		aSet , self typeBindList uniqueBoundIdentifiers
		do: aBlock
]

{ #category : #testing }
ViennaLambdaExpressionNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> isViennaLambdaExpressionNode [

	^ true
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> label [

	^ 'LambdaExpression'
]

{ #category : #'accessing-definitions' }
ViennaLambdaExpressionNode >> lookupIdentifier: aString [

	self typeBindList do: [ :typeBind |
		(typeBind bindsIdentifier: aString) ifTrue: [ ^ typeBind pattern ] ].
	^ nil
]

{ #category : #typechecking }
ViennaLambdaExpressionNode >> maximalType [

	self typeBindList typecheck.
	^ (ViennaType product:
		   (self typeBindList collect: [ :typeBind |
			    typeBind pattern typecheck ])) -> self expression typecheck
]

{ #category : #typechecking }
ViennaLambdaExpressionNode >> maximalType: aViennaType [

	self typeBindList typecheck.
	self expression maximalType: aViennaType.
	super maximalType: aViennaType
]

{ #category : #'pretty printing' }
ViennaLambdaExpressionNode >> operatorPrecedence [

	^ 10
]

{ #category : #enumerating }
ViennaLambdaExpressionNode >> patternsDo: aBlock [

	self typeBindList do: [ :typeBind | aBlock value: typeBind pattern ]
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> typeBindList [

	^ self at: 1
]

{ #category : #accessing }
ViennaLambdaExpressionNode >> typeBindList: aViennaTypeBindListNode [

	self at: 1 put: aViennaTypeBindListNode
]

{ #category : #enumerating }
ViennaLambdaExpressionNode >> typeBindsDo: aBlock [

	self typeBindList do: aBlock
]
