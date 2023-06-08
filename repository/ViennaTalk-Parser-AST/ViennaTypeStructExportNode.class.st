Class {
	#name : #ViennaTypeStructExportNode,
	#superclass : #ViennaTypeExportNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'pretty printing' }
ViennaTypeStructExportNode >> formatWith: aViennaAbstractFormatter [

	^ 'struct ' , (aViennaAbstractFormatter format: self name)
]

{ #category : #testing }
ViennaTypeStructExportNode >> isViennaTypeStructExportNode [

	^ true
]

{ #category : #testing }
ViennaTypeStructExportNode >> label [

	^ 'TypeStructExport'
]
