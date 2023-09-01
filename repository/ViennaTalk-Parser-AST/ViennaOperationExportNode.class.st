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

{ #category : #enumerating }
ViennaOperationExportNode >> exportedIdentifiersDo: aBlock [

	self nameList do: [ :name | aBlock value: name identifier ]
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

{ #category : #removing }
ViennaOperationExportNode >> removeIdentifier: aString [

	self nameList removeIdentifier: aString.
	self nameList ifEmpty: [ parent ifNotNil: [ parent remove: self ] ]
]

{ #category : #accessing }
ViennaOperationExportNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaOperationExportNode >> type: aViennaOperationTypeNode [

	self at: 2 put: aViennaOperationTypeNode
]
