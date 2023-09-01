Class {
	#name : #ViennaRecordTypeDefinitionNode,
	#superclass : #ViennaTopLevelDefinitionNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaRecordTypeDefinitionNode class >> access: aViennaAccessNode identifier: aString fieldList: aViennaFieldListNode inv: aViennaInvariantNode [

	^ (self new: 4)
		  access: aViennaAccessNode;
		  identifier: aString;
		  fieldList: aViennaFieldListNode;
		  inv: aViennaInvariantNode;
		  yourself
]

{ #category : #'instance creation' }
ViennaRecordTypeDefinitionNode class >> identifier: aString fieldList: aViennaFieldListNode inv: aViennaInvariantNode [

	^ self
		  access: ViennaAccessNode empty
		  identifier: aString
		  fieldList: aViennaFieldListNode
		  inv: aViennaInvariantNode
]

{ #category : #accessing }
ViennaRecordTypeDefinitionNode >> access [

	^ self at: 1
]

{ #category : #accessing }
ViennaRecordTypeDefinitionNode >> access: aViennaAccessNode [

	self at: 1 put: aViennaAccessNode
]

{ #category : #'accessing-definitions' }
ViennaRecordTypeDefinitionNode >> asAccessDefinition [

	^ self
]

{ #category : #'accessing-definitions' }
ViennaRecordTypeDefinitionNode >> asExport [

	^ ViennaTypeStructExportNode name:
		  (ViennaLocalNameNode identifier: self identifier)
]

{ #category : #'accessing-definitions' }
ViennaRecordTypeDefinitionNode >> asImportDefinitionIn: moduleNode [

	^ ViennaImportDefinitionNode
		  moduleIdentifier: self module identifier
		  importModuleSignature: (ViennaImportModuleSignatureNode with:
				   (ViennaImportTypesSignatureNode with: (ViennaTypeImportNode
						     typeName: (ViennaTypeNameNode name:
								      (ViennaLocalNameNode identifier: self identifier))
						     rename: nil)))
]

{ #category : #private }
ViennaRecordTypeDefinitionNode >> boundIdentifiersDo: aBlock [

	aBlock cull: self identifier cull: self
]

{ #category : #accessing }
ViennaRecordTypeDefinitionNode >> fieldList [

	^ self at: 3
]

{ #category : #accessing }
ViennaRecordTypeDefinitionNode >> fieldList: aViennaFieldListNode [

	self at: 3 put: aViennaFieldListNode
]

{ #category : #'pretty printing' }
ViennaRecordTypeDefinitionNode >> formatWith: aViennaAbstractFormatter [

	| access identifier fieldList invariant |
	access := (aViennaAbstractFormatter format: self access) trim
		          ifNotEmpty: [ :string | string , ' ' ].
	identifier := aViennaAbstractFormatter format: self identifier.
	fieldList := aViennaAbstractFormatter format: self fieldList.
	invariant := self inv
		             ifNotNil: [
			             String cr , aViennaAbstractFormatter indent
			             , (aViennaAbstractFormatter indentString:
					              (aViennaAbstractFormatter format: self third)) ]
		             ifNil: [ '' ].
	^ access , identifier , ' ::'
	  , ((aViennaAbstractFormatter needsIndent: identifier , fieldList)
			   ifTrue: [
				   String cr , aViennaAbstractFormatter indent
				   , (aViennaAbstractFormatter indentString: fieldList) ]
			   ifFalse: [ String space , fieldList ]) , invariant
]

{ #category : #private }
ViennaRecordTypeDefinitionNode >> freeIdentifiersExcept: aSet do: aBlock [

	self fieldList freeIdentifiersExcept: aSet do: aBlock.
	self inv ifNotNil: [ :inv |
		inv freeIdentifiersExcept: aSet do: aBlock ]
]

{ #category : #accessing }
ViennaRecordTypeDefinitionNode >> identifier [

	^ self at: 2
]

{ #category : #accessing }
ViennaRecordTypeDefinitionNode >> identifier: aString [

	self at: 2 put: aString
]

{ #category : #accessing }
ViennaRecordTypeDefinitionNode >> inv [

	^ self at: 4
]

{ #category : #accessing }
ViennaRecordTypeDefinitionNode >> inv: aViennaInvariantNode [

	self at: 4 put: aViennaInvariantNode
]

{ #category : #testing }
ViennaRecordTypeDefinitionNode >> isTypeDefinition [

	^ true
]

{ #category : #testing }
ViennaRecordTypeDefinitionNode >> isViennaAccessTypeDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaRecordTypeDefinitionNode >> isViennaExportableTopLevelDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaRecordTypeDefinitionNode >> isViennaRecordTypeDefinitionNode [

	^ true
]

{ #category : #testing }
ViennaRecordTypeDefinitionNode >> isViennaRecordTypeDefinitionNode: aString [

	^ self identifier = aString
]

{ #category : #accessing }
ViennaRecordTypeDefinitionNode >> label [

	^ 'RecordTypeDefinition'
]

{ #category : #'accessing-definitions' }
ViennaRecordTypeDefinitionNode >> shortName [

	^ self identifier
]

{ #category : #accessing }
ViennaRecordTypeDefinitionNode >> type [

	^ nil
]
