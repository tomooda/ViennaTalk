Class {
	#name : #ViennaOperationExportNode,
	#superclass : #ViennaExportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaOperationExportNode class >> nameList: aViennaNameListNode type: aViennaOperationTypeNode [

	^ (self new: 2)
		  nameList: aViennaNameListNode;
		  type: aViennaOperationTypeNode;
		  yourself
]

{ #category : #adding }
ViennaOperationExportNode >> addName: aViennaNameNode [

	self nameList add: aViennaNameNode
]

{ #category : #testing }
ViennaOperationExportNode >> exportsName: aViennaNameNode [

	^ self nameList anySatisfy: [ :name | name = aViennaNameNode ]
]

{ #category : #'pretty printing' }
ViennaOperationExportNode >> formatWith: aViennaAbstractFormatter [

	| name type |
	name := aViennaAbstractFormatter format: self nameList.
	type := self type
		        ifNil: [ '' ]
		        ifNotNil: [ :node |
		        ' : ' , (aViennaAbstractFormatter format: node) ].
	^ name , type
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

{ #category : #removing }
ViennaOperationExportNode >> removeName: aViennaNameNode [

	self nameList remove: aViennaNameNode
]

{ #category : #accessing }
ViennaOperationExportNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaOperationExportNode >> type: aViennaOperationTypeNode [

	self at: 2 put: aViennaOperationTypeNode
]
