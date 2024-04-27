Class {
	#name : #ViennaInterfaceNode,
	#superclass : #ViennaInterfaceComponentNode,
	#type : #variable,
	#category : #'ViennaTalk-AST-Core'
}

{ #category : #'instance creation' }
ViennaInterfaceNode class >> exportsAll [

	^ self
		  importDefinitionList: ViennaImportDefinitionListNode empty
		  exportDefinition: ViennaExportDefinitionNode all
]

{ #category : #'instance creation' }
ViennaInterfaceNode class >> importDefinitionList: aViennaImportDefinitionListNode exportDefinition: aViennaExportDefinitionNode [

	^ (self new: 2)
		  importDefinitionList: aViennaImportDefinitionListNode;
		  exportDefinition: aViennaExportDefinitionNode;
		  yourself
]

{ #category : #private }
ViennaInterfaceNode >> boundIdentifiersDo: aBlock [

	self importDefinitionList ifNotNil: [ :importDefinitionList |
		importDefinitionList boundIdentifiersDo: aBlock ]
]

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
		                        ifNil: [ aViennaAbstractFormatter empty ]
		                        ifNotNil: [ :defList |
			                        (aViennaAbstractFormatter format: defList)
			                        ++ aViennaAbstractFormatter cr ].
	exportDefinition := aViennaAbstractFormatter format:
		                    self exportDefinition.
	^ importDefinitionList ++ exportDefinition
]

{ #category : #accessing }
ViennaInterfaceNode >> importDefinitionList [

	^ self at: 1
]

{ #category : #accessing }
ViennaInterfaceNode >> importDefinitionList: aViennaImportDefinitionListNode [

	self at: 1 put: aViennaImportDefinitionListNode
]

{ #category : #enumerating }
ViennaInterfaceNode >> importSignaturesDo: aBlock [

	self importDefinitionList ifNotNil: [ :importDefinitionList |
		importDefinitionList importSignaturesDo: aBlock ]
]

{ #category : #testing }
ViennaInterfaceNode >> isViennaInterfaceNode [

	^ true
]

{ #category : #testing }
ViennaInterfaceNode >> label [

	^ 'Interface'
]

{ #category : #typechecking }
ViennaInterfaceNode >> maximalType [

	self importDefinitionList ifNotNil: #typecheck.
	self exportDefinition typecheck.
	^ ViennaType unit
]
