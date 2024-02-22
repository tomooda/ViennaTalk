Class {
	#name : #ViennaTypeImportNode,
	#superclass : #ViennaImportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeImportNode class >> typeName: aViennaTypeNameNode rename: aViennaNameNode [

	^ (self new: 2)
		  typeName: aViennaTypeNameNode;
		  rename: aViennaNameNode;
		  yourself
]

{ #category : #'pretty printing' }
ViennaTypeImportNode >> formatWith: aViennaAbstractFormatter [

	| type rename |
	type := aViennaAbstractFormatter format: self typeName.
	rename := self rename
		          ifNil: [ '' ]
		          ifNotNil: [ :node |
		          'renamed ' , (aViennaAbstractFormatter format: node) ].
	^ aViennaAbstractFormatter
		  indentString: type
		  insertCrIfNeeded: rename
]

{ #category : #accessing }
ViennaTypeImportNode >> identifier [

	^ self name identifier
]

{ #category : #testing }
ViennaTypeImportNode >> isViennaTypeImportNode [

	^ true
]

{ #category : #testing }
ViennaTypeImportNode >> isViennaTypeImportNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaTypeImportNode >> isViennaTypeImportNodeRenamed: aString [

	^ self rename identifier = aString
]

{ #category : #testing }
ViennaTypeImportNode >> label [

	^ 'TypeImport'
]

{ #category : #typechecking }
ViennaTypeImportNode >> maximalType [

	^ (self document moduleNamed: self moduleIdentifier)
		  ifNotNil: [ :module |
			  (module exportsIdentifier: self identifier)
				  ifTrue: [
					  self asGlobalName resolve
						  ifNotNil: [ :def |
							  def isTypeDefinition
								  ifTrue: [
									  def typecheck.
									  ViennaType unit ]
								  ifFalse: [
									  ViennaTypeError
										  on: self
										  signal: 'Not a type:' , self asGlobalName source ] ]
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
ViennaTypeImportNode >> name [

	^ self typeName isViennaTypeNameNode
		  ifTrue: [ self typeName name ]
		  ifFalse: [
			  (ViennaLocalNameNode identifier: self typeName identifier)
				  parent: self;
				  yourself ]
]

{ #category : #accessing }
ViennaTypeImportNode >> rename [

	^ self at: 2
]

{ #category : #accessing }
ViennaTypeImportNode >> rename: aViennaNameNode [

	self at: 2 put: aViennaNameNode
]

{ #category : #accessing }
ViennaTypeImportNode >> typeName [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeImportNode >> typeName: aViennaTypeNameNode [

	self at: 1 put: aViennaTypeNameNode
]
