Class {
	#name : #ViennaTypeSynonymNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeSynonymNode class >> identifier: aString type: aViennaTypeNode [

	^ self identifier: aString type: aViennaTypeNode inv: nil
]

{ #category : #'instance creation' }
ViennaTypeSynonymNode class >> identifier: aString type: aViennaTypeNode inv: aViennaExpression [

	^ (self new: 3)
		  identifier: aString;
		  type: aViennaTypeNode;
		  inv: aViennaExpression;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaTypeSynonymNode >> asAccessDefinition [

	^ ViennaAccessTypeDefinitionNode
		  access: (ViennaNode label: 'Access')
		  typeDefinition: self
]

{ #category : #'accessing-definitions' }
ViennaTypeSynonymNode >> asExport [

	^ ViennaTypeStructExportNode name:
		  (ViennaLocalNameNode identifier: self identifier)
]

{ #category : #'accessing-definitions' }
ViennaTypeSynonymNode >> asImportDefinitionIn: moduleNode [

	^ ViennaImportDefinitionNode
		  moduleIdentifier: self module identifier
		  importModuleSignature: (ViennaImportModuleSignatureNode with:
				   (ViennaImportTypesSignatureNode with: (ViennaTypeImportNode
						     typeName: (ViennaTypeNameNode name:
								      (ViennaLocalNameNode identifier: self identifier))
						     rename: nil)))
]

{ #category : #'pretty printing' }
ViennaTypeSynonymNode >> formatWith: aViennaAbstractFormatter [

	| typeName baseType invariant |
	typeName := aViennaAbstractFormatter format: self first.
	baseType := aViennaAbstractFormatter format: self second.
	invariant := self third
		             ifNil: [ '' ]
		             ifNotNil: [ :node |
		             aViennaAbstractFormatter format: node ].
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter
				   indentString: typeName , ' ='
				   insertCrIfNeeded: baseType)
		  insertCrIfNeeded: invariant
]

{ #category : #accessing }
ViennaTypeSynonymNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeSynonymNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #accessing }
ViennaTypeSynonymNode >> inv [

	^ self at: 3
]

{ #category : #accessing }
ViennaTypeSynonymNode >> inv: aViennaExpression [

	self at: 3 put: aViennaExpression
]

{ #category : #testing }
ViennaTypeSynonymNode >> isViennaTypeSynonymNode [

	^ true
]

{ #category : #testing }
ViennaTypeSynonymNode >> isViennaTypeSynonymNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaTypeSynonymNode >> label [

	^ 'TypeSynonym'
]

{ #category : #'accessing-definitions' }
ViennaTypeSynonymNode >> resolve [

	^ self
]

{ #category : #'accessing-definitions' }
ViennaTypeSynonymNode >> shortName [

	^ self identifier
]

{ #category : #accessing }
ViennaTypeSynonymNode >> type [

	^ self at: 2
]

{ #category : #accessing }
ViennaTypeSynonymNode >> type: aViennaTypeNode [

	self at: 2 put: aViennaTypeNode
]
