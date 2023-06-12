Class {
	#name : #ViennaInterfaceNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #accessing }
ViennaInterfaceNode >> exportDefinition [

	^ self at: 2
]

{ #category : #accessing }
ViennaInterfaceNode >> exportDefinition: aViennaExportDefinitionNode [

	self at: 2 put: aViennaExportDefinitionNode
]

{ #category : #'pretty printing' }
ViennaInterfaceNode >> formatWith: aViennaAbstractFormatter [

	| importDefinitionList exportDefinition |
	importDefinitionList := self importDefinitionList
		                        ifNil: [ '' ]
		                        ifNotNil: [ :defList |
		                        (aViennaAbstractFormatter format: defList)
		                        , String cr ].
	exportDefinition := aViennaAbstractFormatter format:
		                    self exportDefinition.
	^ importDefinitionList , exportDefinition
]

{ #category : #accessing }
ViennaInterfaceNode >> importDefinitionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaInterfaceNode >> importDefinitionList: aViennaImportDefinitionListNode [

	self at: 1 put: aViennaImportDefinitionListNode
]

{ #category : #testing }
ViennaInterfaceNode >> isViennaInterfaceNode [

	^ true
]

{ #category : #testing }
ViennaInterfaceNode >> label [

	^ 'Interface'
]
