Class {
	#name : #ViennaTypeExportNode,
	#superclass : #ViennaExportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #testing }
ViennaTypeExportNode class >> isAbstract [

	^ self = ViennaTypeExportNode
]

{ #category : #'instance creation' }
ViennaTypeExportNode class >> name: aViennaNameNode [

	^ (self new: 1)
		  name: aViennaNameNode;
		  yourself
]

{ #category : #enumerating }
ViennaTypeExportNode >> exportedIdentifiersDo: aBlock [

	aBlock value: self identifier
]

{ #category : #accessing }
ViennaTypeExportNode >> identifier [

	^ self name identifier
]

{ #category : #testing }
ViennaTypeExportNode >> isViennaTypeExportNode [

	^ true
]

{ #category : #typechecking }
ViennaTypeExportNode >> maximalType [

	self name resolved
		ifNotNil: [ :def |
			def isTypeDefinition ifFalse: [
				^ ViennaTypeError
					  on: self
					  signal: 'Not a type: ' , self name source ] ]
		ifNil: [
			^ ViennaTypeError
				  on: self
				  signal: 'Unresolved type: ' , self name source ].
	^ ViennaType unit
]

{ #category : #accessing }
ViennaTypeExportNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeExportNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]

{ #category : #removing }
ViennaTypeExportNode >> removeIdentifier: aString [

	self identifier = aString ifTrue: [
		parent ifNotNil: [ parent remove: self ] ]
]
