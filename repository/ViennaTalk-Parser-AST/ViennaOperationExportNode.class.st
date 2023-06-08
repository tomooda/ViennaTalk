Class {
	#name : #ViennaOperationExportNode,
	#superclass : #ViennaExportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaOperationExportNode class >> nameList: aViennaNameListNode operationType: aViennaOperationTypeNode [

	^ (self new: 2)
		  nameList: aViennaNameListNode;
		  operationType: aViennaOperationTypeNode;
		  yourself
]

{ #category : #adding }
ViennaOperationExportNode >> addName: aViennaNameNode [

	self nameList add: aViennaNameNode
]

{ #category : #testing }
ViennaOperationExportNode >> exportsName: aViennaNameNode [

	^ self nameList anySatisfy: [ :name | name sameAs: aViennaNameNode ]
]

{ #category : #'pretty printing' }
ViennaOperationExportNode >> formatWith: aViennaAbstractFormatter [

	| name operationType |
	name := aViennaAbstractFormatter format: self nameList.
	operationType := self operationType
		                 ifNil: [ '' ]
		                 ifNotNil: [ :node |
		                 ' : ' , (aViennaAbstractFormatter format: node) ].
	^ name , operationType
]

{ #category : #testing }
ViennaOperationExportNode >> isEmpty [

	^ self nameList isEmpty
]

{ #category : #testing }
ViennaOperationExportNode >> isViennaOperationExportNode [

	^ true
]

{ #category : #testing }
ViennaOperationExportNode >> label [

	^ 'OperationExport'
]

{ #category : #accessing }
ViennaOperationExportNode >> nameList [

	^ self at: 1
]

{ #category : #accessing }
ViennaOperationExportNode >> nameList: aViennaNameListNode [

	self at: 1 put: aViennaNameListNode
]

{ #category : #enumerating }
ViennaOperationExportNode >> namesDo: aBlock [

	self nameList do: aBlock
]

{ #category : #accessing }
ViennaOperationExportNode >> operationType [

	^ self at: 2
]

{ #category : #accessing }
ViennaOperationExportNode >> operationType: aViennaOperationTypeNode [

	self at: 2 put: aViennaOperationTypeNode
]

{ #category : #removing }
ViennaOperationExportNode >> removeName: aViennaNameNode [

	self nameList remove: aViennaNameNode
]
