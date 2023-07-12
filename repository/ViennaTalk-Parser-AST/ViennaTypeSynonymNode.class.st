Class {
	#name : #ViennaTypeSynonymNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaTypeSynonymNode class >> access: aViennaAccessNode identifier: aString type: aViennaTypeNode inv: aViennaInvariantNode [

	^ (self new: 4)
		  access: aViennaAccessNode;
		  identifier: aString;
		  type: aViennaTypeNode;
		  inv: aViennaInvariantNode;
		  yourself
]

{ #category : #'instance creation' }
ViennaTypeSynonymNode class >> identifier: aString type: aViennaTypeNode [

	^ self identifier: aString type: aViennaTypeNode inv: nil
]

{ #category : #'instance creation' }
ViennaTypeSynonymNode class >> identifier: aString type: aViennaTypeNode inv: aViennaInvariantNode [

	^ self
		  access: ViennaAccessNode empty
		  identifier: aString
		  type: aViennaTypeNode
		  inv: aViennaInvariantNode
]

{ #category : #accessing }
ViennaTypeSynonymNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaTypeSynonymNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #'accessing-definitions' }
ViennaTypeSynonymNode >> asAccessDefinition [

	^ self
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

{ #category : #private }
ViennaTypeSynonymNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self
]

{ #category : #'pretty printing' }
ViennaTypeSynonymNode >> formatWith: aViennaAbstractFormatter [

	| access typeName baseType invariant |
	access := (aViennaAbstractFormatter format: self access) trim
		          ifNotEmpty: [ :string | string , ' ' ].
	typeName := aViennaAbstractFormatter format: self identifier.
	baseType := aViennaAbstractFormatter format: self type.
	invariant := self inv
		             ifNil: [ '' ]
		             ifNotNil: [ :node |
		             aViennaAbstractFormatter format: node ].
	^ aViennaAbstractFormatter
		  indentString: (aViennaAbstractFormatter
				   indentString: access , typeName , ' ='
				   insertCrIfNeeded: baseType)
		  insertCrIfNeeded: invariant
]

{ #category : #private }
ViennaTypeSynonymNode >> freeIdentifiersExcept: aSet do: aBlock [

	self type freeIdentifiersExcept: aSet do: aBlock
]

{ #category : #accessing }
ViennaTypeSynonymNode >> identifier [

	^ self at: 2
]

{ #category : #accessing }
ViennaTypeSynonymNode >> identifier: aString [

	self at: 2 put: aString
]

{ #category : #accessing }
ViennaTypeSynonymNode >> inv [

	^ self at: 4
]

{ #category : #accessing }
ViennaTypeSynonymNode >> inv: aViennaInvariantNode [

	self at: 4 put: aViennaInvariantNode
]

{ #category : #testing }
ViennaTypeSynonymNode >> isTypeDefinition [

	^ true
]

{ #category : #testing }
ViennaTypeSynonymNode >> isViennaAccessTypeDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaTypeSynonymNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
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
ViennaTypeSynonymNode >> localResolve [

	^ self
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

	^ self at: 3
]

{ #category : #accessing }
ViennaTypeSynonymNode >> type: aViennaTypeNode [

	self at: 3 put: aViennaTypeNode
]
