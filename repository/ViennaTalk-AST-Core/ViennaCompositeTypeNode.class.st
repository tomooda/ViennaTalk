Class {
	#name : #ViennaCompositeTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaCompositeTypeNode class >> identifier: aString fieldList: aViennaFieldListNode [

	^ (self new: 2)
		  identifier: aString;
		  fieldList: aViennaFieldListNode;
		  yourself
]

{ #category : #converting }
ViennaCompositeTypeNode >> asMaximalViennaType [

	self maximalType: (ViennaType
			 compose: self identifier
			 of: (self fieldList collect: #asMaximalViennaTypeAny)).
	^ maximalType
		  basetypes: self fieldList asMaximalViennaType;
		  yourself
]

{ #category : #accessing }
ViennaCompositeTypeNode >> fieldList [

	^ self at: 2
]

{ #category : #accessing }
ViennaCompositeTypeNode >> fieldList: aViennaFieldListNode [

	self at: 2 put: aViennaFieldListNode
]

{ #category : #'pretty printing' }
ViennaCompositeTypeNode >> formatWith: aViennaAbstractFormatter [

	| constructor fields |
	constructor := aViennaAbstractFormatter format: self identifier.
	fields := aViennaAbstractFormatter format: self fieldList.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   indentString:
					   (aViennaAbstractFormatter keyword: 'compose ') ++ constructor
					   ++ (aViennaAbstractFormatter keyword: ' of')
				   insertCrIfNeeded: fields)
		  insertCrIfNeeded: (aViennaAbstractFormatter keyword: 'end')
]

{ #category : #private }
ViennaCompositeTypeNode >> freeIdentifiersExcept: aSet do: aBlock [

	self fieldList freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaCompositeTypeNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaCompositeTypeNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #testing }
ViennaCompositeTypeNode >> isViennaCompositeTypeNode [

	^ true
]

{ #category : #accessing }
ViennaCompositeTypeNode >> label [

	^ 'CompositeType'
]
