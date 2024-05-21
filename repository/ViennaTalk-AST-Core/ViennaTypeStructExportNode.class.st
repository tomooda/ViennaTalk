Class {
	#name : 'ViennaTypeStructExportNode',
	#superclass : 'ViennaTypeExportNode',
	#type : 'variable',
	#category : 'ViennaTalk-AST-Core',
	#package : 'ViennaTalk-AST-Core'
}

{ #category : 'pretty printing' }
ViennaTypeStructExportNode >> formatWith: aViennaAbstractFormatter [

	| name |
	name := self name.
	^ (aViennaAbstractFormatter keyword: 'struct ')
	  ++ (name isViennaGlobalNameNode
			   ifTrue: [
				   (aViennaAbstractFormatter moduleName: name moduleIdentifier)
				   ++ '`' ++ (aViennaAbstractFormatter typeName: name identifier) ]
			   ifFalse: [ aViennaAbstractFormatter typeName: name identifier ])
]

{ #category : 'testing' }
ViennaTypeStructExportNode >> isViennaTypeStructExportNode [

	^ true
]

{ #category : 'testing' }
ViennaTypeStructExportNode >> label [

	^ 'TypeStructExport'
]
