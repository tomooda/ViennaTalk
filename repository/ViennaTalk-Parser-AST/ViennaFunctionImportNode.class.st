Class {
	#name : #ViennaFunctionImportNode,
	#superclass : #ViennaImportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaFunctionImportNode class >> name: aViennaNameNode1 typeVariableList: aViennaTypeVariableListNode type: aViennaFunctionType rename: aViennaNameNode2 [

	^ (self new: 4)
		  name: aViennaNameNode1;
		  typeVariableList: aViennaTypeVariableListNode;
		  type: aViennaFunctionType;
		  rename: aViennaNameNode2;
		  yourself
]

{ #category : #'pretty printing' }
ViennaFunctionImportNode >> formatWith: aViennaAbstractFormatter [

	| name typeVariableList type rename |
	name := aViennaAbstractFormatter format: self name.
	typeVariableList := self typeVariableList
		                    ifNil: [ '' ]
		                    ifNotNil: [ :node |
		                    aViennaAbstractFormatter format: node ].
	type := self type
		        ifNil: [ '' ]
		        ifNotNil: [ :node |
		        ': ' , (aViennaAbstractFormatter format: node) ].
	rename := self rename
		          ifNil: [ '' ]
		          ifNotNil: [ :node |
		          'renamed ' , (aViennaAbstractFormatter format: node) ].
	^ aViennaAbstractFormatter
		  indentString: name , typeVariableList , type
		  insertCrIfNeeded: rename
]

{ #category : #testing }
ViennaFunctionImportNode >> isViennaFunctionImportNode [

	^ true
]

{ #category : #testing }
ViennaFunctionImportNode >> isViennaFunctionImportNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaFunctionImportNode >> isViennaFunctionImportNodeRenamed: aString [

	^ self rename identifier = aString
]

{ #category : #accessing }
ViennaFunctionImportNode >> label [

	^ 'FunctionImport'
]

{ #category : #accessing }
ViennaFunctionImportNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaFunctionImportNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]

{ #category : #accessing }
ViennaFunctionImportNode >> rename [

	^ self at: 4
]

{ #category : #accessing }
ViennaFunctionImportNode >> rename: aViennaNameNode [

	self at: 4 put: aViennaNameNode
]

{ #category : #accessing }
ViennaFunctionImportNode >> type [

	^ self at: 3
]

{ #category : #accessing }
ViennaFunctionImportNode >> type: aViennaFunctionTypeNode [

	self at: 3 put: aViennaFunctionTypeNode
]

{ #category : #accessing }
ViennaFunctionImportNode >> typeVariableList [

	^ self at: 2
]

{ #category : #accessing }
ViennaFunctionImportNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 2 put: aViennaTypeVariableListNode
]
