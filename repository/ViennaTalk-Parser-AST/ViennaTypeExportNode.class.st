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

{ #category : #testing }
ViennaTypeExportNode >> exportsName: aViennaNameNode [

	^ self name sameAs: aViennaNameNode
]

{ #category : #accessing }
ViennaTypeExportNode >> identifier [

	^ self name identifier
]

{ #category : #testing }
ViennaTypeExportNode >> isViennaTypeExportNode [

	^ true
]

{ #category : #accessing }
ViennaTypeExportNode >> name [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeExportNode >> name: aViennaNameNode [

	self at: 1 put: aViennaNameNode
]

{ #category : #enumerating }
ViennaTypeExportNode >> namesDo: aBlock [

	aBlock value: self name
]
