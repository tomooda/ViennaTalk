Class {
	#name : #ViennaTypeNameExportNode,
	#superclass : #ViennaTypeExportNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'pretty printing' }
ViennaTypeNameExportNode >> formatWith: aViennaAbstractFormatter [

	| name |
	name := self name.
	^ name isViennaGlobalNameNode
		  ifTrue: [
			  (aViennaAbstractFormatter moduleName: name moduleIdentifier)
			  , '`' , (aViennaAbstractFormatter typeName: name identifier) ]
		  ifFalse: [ aViennaAbstractFormatter typeName: name identifier ]
]

{ #category : #testing }
ViennaTypeNameExportNode >> isViennaTypeNameExportNode [

	^ true
]

{ #category : #testing }
ViennaTypeNameExportNode >> label [

	^ 'TypeNameExport'
]
