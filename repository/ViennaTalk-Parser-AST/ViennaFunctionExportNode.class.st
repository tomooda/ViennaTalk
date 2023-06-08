Class {
	#name : #ViennaFunctionExportNode,
	#superclass : #ViennaExportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaFunctionExportNode class >> nameList: aViennaNameListNode typeVariableList: aViennaTypeVariableListNode functionType: aViennaFunctionTypeNode [

	^ (self new: 3)
		  nameList: aViennaNameListNode;
		  typeVariableList: aViennaTypeVariableListNode;
		  functionType: aViennaFunctionTypeNode;
		  yourself
]

{ #category : #adding }
ViennaFunctionExportNode >> addName: aViennaNameNode [

	self nameList add: aViennaNameNode
]

{ #category : #testing }
ViennaFunctionExportNode >> exportsName: aViennaNameNode [

	^ self nameList anySatisfy: [ :name | name sameAs: aViennaNameNode ]
]

{ #category : #'pretty printing' }
ViennaFunctionExportNode >> formatWith: aViennaAbstractFormatter [

	| nameList typeVarList functionType |
	nameList := aViennaAbstractFormatter format: self nameList.
	typeVarList := aViennaAbstractFormatter format: self typeVariableList.
	functionType := aViennaAbstractFormatter format: self functionType.
	^ aViennaAbstractFormatter
		  indentString: nameList , typeVarList
		  insertCrIfNeeded: ': ' , functionType
]

{ #category : #accessing }
ViennaFunctionExportNode >> functionType [

	^ self at: 3
]

{ #category : #accessing }
ViennaFunctionExportNode >> functionType: aViennaFunctionTypeNode [

	self at: 3 put: aViennaFunctionTypeNode
]

{ #category : #testing }
ViennaFunctionExportNode >> isEmpty [

	^ self nameList isEmpty
]

{ #category : #testing }
ViennaFunctionExportNode >> isViennaFunctionExportNode [

	^ true
]

{ #category : #accessing }
ViennaFunctionExportNode >> label [

	^ 'FunctionExport'
]

{ #category : #accessing }
ViennaFunctionExportNode >> nameList [

	^ self at: 1
]

{ #category : #accessing }
ViennaFunctionExportNode >> nameList: aViennaNameListNode [

	self at: 1 put: aViennaNameListNode
]

{ #category : #enumerating }
ViennaFunctionExportNode >> namesDo: aBlock [

	self nameList do: aBlock
]

{ #category : #adding }
ViennaFunctionExportNode >> removeName: aViennaNameNode [

	self nameList remove: aViennaNameNode
]

{ #category : #accessing }
ViennaFunctionExportNode >> typeVariableList [

	^ self at: 2
]

{ #category : #accessing }
ViennaFunctionExportNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 2 put: aViennaTypeVariableListNode
]
