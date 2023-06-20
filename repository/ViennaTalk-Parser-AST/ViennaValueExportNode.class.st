Class {
	#name : #ViennaValueExportNode,
	#superclass : #ViennaExportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaValueExportNode class >> nameList: aViennaNameListNode type: aViennaTypeNode [

	^ (self new: 2)
		  nameList: aViennaNameListNode;
		  type: aViennaTypeNode;
		  yourself
]

{ #category : #enumerating }
ViennaValueExportNode >> exportedIdentifiersDo: aBlock [

	self nameList do: [ :name | aBlock value: name identifier ]
]

{ #category : #'pretty printing' }
ViennaValueExportNode >> formatWith: aViennaAbstractFormatter [

	| nameList type |
	nameList := aViennaAbstractFormatter format: self nameList.
	type := self type
		        ifNil: [ '' ]
		        ifNotNil: [ :node |
		        ' : ' , (aViennaAbstractFormatter format: node) ].
	^ nameList , type
]

{ #category : #testing }
ViennaValueExportNode >> isEmpty [

	^ self nameList isEmpty
]

{ #category : #testing }
ViennaValueExportNode >> isViennaValueExportNode [

	^ true
]

{ #category : #testing }
ViennaValueExportNode >> label [

	^ 'ValueExport'
]

{ #category : #accessing }
ViennaValueExportNode >> nameList [

	^ self at: 1
]

{ #category : #accessing }
ViennaValueExportNode >> nameList: aViennaNameListNode [

	self at: 1 put: aViennaNameListNode
]

{ #category : #removing }
ViennaValueExportNode >> removeIdentifier: aString [

	self nameList removeIdentifier: aString.
	self nameList ifEmpty: [ parent ifNotNil: [ parent remove: self ] ]
]

{ #category : #accessing }
ViennaValueExportNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaValueExportNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
