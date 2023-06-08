Class {
	#name : #ViennaTypeNameExportNode,
	#superclass : #ViennaTypeExportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaTypeNameExportNode >> formatWith: aViennaAbstractFormatter [

	^ aViennaAbstractFormatter format: self name
]

{ #category : #testing }
ViennaTypeNameExportNode >> isViennaTypeNameExportNode [

	^ true
]

{ #category : #testing }
ViennaTypeNameExportNode >> label [

	^ 'TypeNameExport'
]
