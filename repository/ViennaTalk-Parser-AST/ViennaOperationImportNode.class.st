Class {
	#name : #ViennaOperationImportNode,
	#superclass : #ViennaImportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaOperationImportNode class >> name: aViennaNameNode1 type: aViennaOperationTypeNode rename: aViennaNameNode2 [

	^ (self new: 3)
		  name: aViennaNameNode1;
		  type: aViennaOperationTypeNode;
		  rename: aViennaNameNode2;
		  yourself
]

{ #category : #'pretty printing' }
ViennaOperationImportNode >> formatWith: aViennaAbstractFormatter [

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
ViennaOperationImportNode >> isViennaOperationImportNode [

	^ true
]

{ #category : #testing }
ViennaOperationImportNode >> isViennaOperationImportNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaOperationImportNode >> isViennaOperationImportNodeRenamed: aString [

	^ self rename identifier = aString
]

{ #category : #testing }
ViennaOperationImportNode >> label [

	^ 'OperationImport'
]

{ #category : #typechecking }
ViennaOperationImportNode >> maximalType [

	^ (self document moduleNamed: self moduleIdentifier)
		  ifNotNil: [ :module |
			  (module exportsIdentifier: self name identifier)
				  ifTrue: [
					  self asGlobalName resolve
						  ifNotNil: [ :def |
							  def isOperationDefinition
								  ifTrue: [
									  def type = self type
										  ifTrue: [
											  def typecheck.
											  ViennaType unit ]
										  ifFalse: [
											  ViennaTypeError
												  on: self
												  signal:
													  'Type mismatch: defined ' , def type source
													  , ' but imported as ' , self type source ] ]
								  ifFalse: [
									  ViennaTypeError
										  on: self
										  signal: 'Not an operation: ' , self asGlobalName source ] ]
						  ifNil: [
							  ViennaTypeError
								  on: self
								  signal: 'Unresolved import: ' , self asGlobalName source ] ]
				  ifFalse: [
					  ViennaTypeError
						  on: self
						  signal: 'Not exported: ' , self asGlobalName source ] ]
		  ifNil: [
			  ViennaTypeError
				  on: self
				  signal: 'Unresolved module: ' , self moduleIdentifier ]
]

{ #category : #accessing }
ViennaOperationImportNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaOperationImportNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]

{ #category : #accessing }
ViennaOperationImportNode >> rename [

	^ self at: 3
]

{ #category : #accessing }
ViennaOperationImportNode >> rename: aViennaNameNode [

	self at: 3 put: aViennaNameNode
]

{ #category : #accessing }
ViennaOperationImportNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaOperationImportNode >> type: aViennaOperationTypeNode [

	self at: 2 put: aViennaOperationTypeNode
]
