Class {
	#name : #ViennaValueExportNode,
	#superclass : #ViennaExportNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
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
		        ifNil: [ aViennaAbstractFormatter empty ]
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

{ #category : #typechecking }
ViennaValueExportNode >> maximalType [

	self nameList do: [ :name |
		name typecheck.
		name resolve
			ifNotNil: [ :def |
				def isValueDefinition ifFalse: [
					^ ViennaTypeError
						  on: self
						  signal: 'Not a value definition: ' , name source ].
				self type ifNotNil: [ :t |
					(name typecheck isCompatibleWith: t typecheck) ifFalse: [
						^ ViennaTypeError
							  on: self
							  signal:
								  'Type mismatch: defined ' , def type source
								  , ' but exported ' , self type source ] ] ]
			ifNil: [
				^ ViennaTypeError
					  on: self
					  signal: 'Unresolved function: ' , name source ] ].
	^ ViennaType unit
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
