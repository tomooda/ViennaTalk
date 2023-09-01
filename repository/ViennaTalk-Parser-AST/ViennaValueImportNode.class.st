Class {
	#name : #ViennaValueImportNode,
	#superclass : #ViennaImportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaValueImportNode class >> name: aViennaNameNode1 type: aViennaTypeNode rename: aViennaNameNode2 [

	^ (self new: 3)
		  name: aViennaNameNode1;
		  type: aViennaTypeNode;
		  rename: aViennaNameNode2;
		  yourself
]

{ #category : #'pretty printing' }
ViennaValueImportNode >> formatWith: aViennaAbstractFormatter [

	| name type rename |
	name := aViennaAbstractFormatter format: self name.
	type := self type
		        ifNil: [ '' ]
		        ifNotNil: [ :node |
		        ': ' , (aViennaAbstractFormatter format: node) ].
	rename := self rename
		          ifNil: [ '' ]
		          ifNotNil: [ :node |
		          'renamed ' , (aViennaAbstractFormatter format: node) ].
	^ aViennaAbstractFormatter
		  indentString: name , type
		  insertCrIfNeeded: rename
]

{ #category : #testing }
ViennaValueImportNode >> isViennaValueImportNode [

	^ true
]

{ #category : #testing }
ViennaValueImportNode >> isViennaValueImportNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaValueImportNode >> isViennaValueImportNodeRenamed: aString [

	^ self rename identifier = aString
]

{ #category : #testing }
ViennaValueImportNode >> label [

	^ 'ValueImport'
]

{ #category : #accessing }
ViennaValueImportNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaValueImportNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]

{ #category : #accessing }
ViennaValueImportNode >> rename [

	^ self at: 3
]

{ #category : #accessing }
ViennaValueImportNode >> rename: aViennaNameNode [

	self at: 3 put: aViennaNameNode
]

{ #category : #accessing }
ViennaValueImportNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaValueImportNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
