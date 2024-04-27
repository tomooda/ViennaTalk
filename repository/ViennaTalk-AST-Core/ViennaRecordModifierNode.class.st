Class {
	#name : #ViennaRecordModifierNode,
	#superclass : #ViennaExpressionNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaRecordModifierNode class >> expression: aViennaExpressionNode mapletList: aViennaMapletListNode [

	^ (self new: 2)
		  expression: aViennaExpressionNode;
		  mapletList: aViennaMapletListNode;
		  yourself
]

{ #category : #accessing }
ViennaRecordModifierNode >> expression [

	^ self at: 1
]

{ #category : #accessing }
ViennaRecordModifierNode >> expression: aViennaExpressionNode [

	self at: 1 put: aViennaExpressionNode
]

{ #category : #'pretty printing' }
ViennaRecordModifierNode >> formatWith: aViennaAbstractFormatter [

	| record mapletList |
	record := aViennaAbstractFormatter format: self expression.
	mapletList := aViennaAbstractFormatter format: self mapletList.
	^ aViennaAbstractFormatter empty ++ aViennaAbstractFormatter mu ++ '('
	  ++ record ++ ','
	  ++ ((aViennaAbstractFormatter needsIndent: record ++ mapletList)
			   ifTrue: [
				   aViennaAbstractFormatter cr ++ aViennaAbstractFormatter indent
				   ++ (aViennaAbstractFormatter indentString: mapletList) ]
			   ifFalse: [ mapletList ]) ++ ')'
]

{ #category : #accessing }
ViennaRecordModifierNode >> freeIdentifiersExcept: aSet do: aBlock [

	self expression freeIdentifiersExcept: aSet do: aBlock.
	self mapletList do: [ :maplet |
		maplet valueExpression freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #testing }
ViennaRecordModifierNode >> isViennaRecordModifierNode [

	^ true
]

{ #category : #accessing }
ViennaRecordModifierNode >> label [

	^ 'RecordModifier'
]

{ #category : #accessing }
ViennaRecordModifierNode >> mapletList [

	^ self at: 2
]

{ #category : #accessing }
ViennaRecordModifierNode >> mapletList: aViennaMapletListNode [

	self at: 2 put: aViennaMapletListNode
]

{ #category : #typechecking }
ViennaRecordModifierNode >> maximalType [

	| type |
	type := ViennaType unit.
	self expression typecheck possibleTypesDo: [ :recordType |
		(recordType isCompositeType and: [
			 self mapletList allSatisfy: [ :maplet |
				 (recordType
					  basetypeAtName: maplet keyExpression identifier
					  ifAbsent: [ nil ])
					 ifNotNil: [ :fieldtype |
						 maplet valueExpression typecheck isCompatibleWith: fieldtype ]
					 ifNil: [ false ] ] ]) ifTrue: [ type := type + recordType ] ].
	^ type
]
