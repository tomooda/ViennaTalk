Class {
	#name : #ViennaFunctionExportNode,
	#superclass : #ViennaExportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaFunctionExportNode class >> nameList: aViennaNameListNode typeVariableList: aViennaTypeVariableListNode type: aViennaFunctionTypeNode [

	^ (self new: 3)
		  nameList: aViennaNameListNode;
		  typeVariableList: aViennaTypeVariableListNode;
		  type: aViennaFunctionTypeNode;
		  yourself
]

{ #category : #enumerating }
ViennaFunctionExportNode >> exportedIdentifiersDo: aBlock [

	self nameList do: [ :name | aBlock value: name identifier ]
]

{ #category : #'pretty printing' }
ViennaFunctionExportNode >> formatWith: aViennaAbstractFormatter [

	| nameList typeVarList functionType |
	nameList := aViennaAbstractFormatter format: self nameList.
	typeVarList := aViennaAbstractFormatter format: self typeVariableList.
	functionType := aViennaAbstractFormatter format: self type.
	^ aViennaAbstractFormatter
		  indentString: nameList , typeVarList
		  insertCrIfNeeded: ': ' , functionType
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

{ #category : #typechecking }
ViennaFunctionExportNode >> maximalType [

	self nameList do: [ :name |
		name typecheck.
		name resolve
			ifNotNil: [ :def |
				def isFunctionDefinition ifFalse: [
					^ ViennaTypeError
						  on: self
						  signal: 'Not a function: ' , name source ].
				def typeVariableList = self typeVariableList ifFalse: [
					^ ViennaTypeError
						  on: self
						  signal:
							  'Type variables mismatch: defined '
							  , def typeVariableList source , ' but exported '
							  , self typeVariableList source ].
				def type = self type ifFalse: [
					^ ViennaTypeError
						  on: self
						  signal: 'Function type mismatch: defined ' , def type source
							  , ' but exported ' , self type source ] ]
			ifNil: [
				^ ViennaTypeError
					  on: self
					  signal: 'Unresolved function: ' , name source ] ].
	^ ViennaType unit
]

{ #category : #accessing }
ViennaFunctionExportNode >> nameList [

	^ self at: 1
]

{ #category : #accessing }
ViennaFunctionExportNode >> nameList: aViennaNameListNode [

	self at: 1 put: aViennaNameListNode
]

{ #category : #removing }
ViennaFunctionExportNode >> removeIdentifier: aString [

	self nameList removeIdentifier: aString.
	self nameList ifEmpty: [ parent ifNotNil: [ parent remove: self ] ]
]

{ #category : #accessing }
ViennaFunctionExportNode >> type [

	^ self at: 3
]

{ #category : #accessing }
ViennaFunctionExportNode >> type: aViennaFunctionTypeNode [

	self at: 3 put: aViennaFunctionTypeNode
]

{ #category : #accessing }
ViennaFunctionExportNode >> typeVariableList [

	^ self at: 2
]

{ #category : #accessing }
ViennaFunctionExportNode >> typeVariableList: aViennaTypeVariableListNode [

	self at: 2 put: aViennaTypeVariableListNode
]
