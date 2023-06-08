Class {
	#name : #ViennaCompositeTypeNode,
	#superclass : #ViennaTypeNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaCompositeTypeNode class >> name: aViennaNameNode fieldList: aViennaFieldListNode [

	^ (self new: 2)
		  name: aViennaNameNode;
		  fieldList: aViennaFieldListNode;
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
	constructor := aViennaAbstractFormatter format: self name.
	fields := aViennaAbstractFormatter format: self fieldList.
	^ aViennaAbstractFormatter
		  noIndentString: (aViennaAbstractFormatter
				   indentString: 'compose ' , constructor , ' of'
				   insertCrIfNeeded: fields)
		  insertCrIfNeeded: 'end'
]

{ #category : #testing }
ViennaCompositeTypeNode >> isViennaCompositeTypeNode [

	^ true
]

{ #category : #accessing }
ViennaCompositeTypeNode >> label [

	^ 'CompositeType'
]

{ #category : #accessing }
ViennaCompositeTypeNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaCompositeTypeNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]
