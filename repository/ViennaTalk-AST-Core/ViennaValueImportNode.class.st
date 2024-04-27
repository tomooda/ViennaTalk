Class {
	#name : #ViennaValueImportNode,
	#superclass : #ViennaImportNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
	rename := self rename ifNil: [ '' ] ifNotNil: [ :node |
		          (aViennaAbstractFormatter keyword: 'renamed ')
		          , (aViennaAbstractFormatter format: node) ].
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

{ #category : #typechecking }
ViennaValueImportNode >> maximalType [

	^ (self document moduleNamed: self moduleIdentifier)
		  ifNotNil: [ :module |
			  (module exportsIdentifier: self name identifier)
				  ifTrue: [
					  self asGlobalName resolve
						  ifNotNil: [ :def |
							  def isValueDefinition
								  ifTrue: [
									  def type typecheck = self type typecheck
										  ifTrue: [ def typecheck ]
										  ifFalse: [
											  ViennaTypeError
												  on: self
												  signal:
													  'Type mismatch: defined ' , def type source
													  , ' but imported as ' , self type source ] ]
								  ifFalse: [
									  ViennaTypeError
										  on: self
										  signal:
										  'Not a value definition: ' , self asGlobalName source ] ]
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
