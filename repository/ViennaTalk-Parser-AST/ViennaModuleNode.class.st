Class {
	#name : #ViennaModuleNode,
	#superclass : #ViennaNode,
	#type : #variable,
	#category : #'ViennaTalk-Parser-AST'
}

{ #category : #'instance creation' }
ViennaModuleNode class >> identifier: aString interface: aViennaInterfaceNode moduleBody: aViennaModuleBodyNode [

	^ (self new: 3)
		  identifier: aString;
		  interface: aViennaInterfaceNode;
		  moduleBody: aViennaModuleBodyNode;
		  yourself
]

{ #category : #'accessing-definitions' }
ViennaModuleNode >> addImportDefinition: aViennaImportDefinitionNode [

	| interface |
	interface := self interface.
	(interface importDefinitionList ifNil: [
		 | node |
		 node := ViennaImportDefinitionListNode empty.
		 interface importDefinitionList: node.
		 node ]) add: aViennaImportDefinitionNode
]

{ #category : #private }
ViennaModuleNode >> boundIdentifiersDo: aBlock [

	aBlock value: self identifier
]

{ #category : #'accessing-definitions' }
ViennaModuleNode >> deepResolveIdentifier: aString [

	| node |
	node := self resolveIdentifier: aString.
	node ifNil: [ ^ nil ].
	node isViennaImportNode ifTrue: [
		(self moduleNamed: node moduleIdentifier) ifNotNil: [ :module |
			^ module deepResolveIdentifier: node identifier ] ].
	^ node
]

{ #category : #'accessing-definitions' }
ViennaModuleNode >> definitionOfLocalName: aString [

	self moduleBody do: [ :defBlock |
		defBlock definition isViennaStateDefinitionNode
			ifTrue: [
				| state |
				state := defBlock definition.
				state identifier = aString ifTrue: [ ^ defBlock ].
				state fieldList do: [ :field |
					field identifier = aString ifTrue: [ ^ field ] ] ]
			ifFalse: [
				defBlock first do: [ :def |
					| defItem |
					defItem := def second.
					(defItem isViennaTypeSynonymNode: aString) ifTrue: [ ^ defItem ].
					(defItem isViennaRecordTypeDefinitionNode: aString) ifTrue: [
						^ defItem ].
					defItem isViennaValueDefinitionNode ifTrue: [
						defItem pattern
							allDescendantsSuchThat: [ :n |
							n isViennaPatternIdentifierNode: aString ]
							do: [ :n | ^ n ] ].
					(defItem isViennaFunctionDefinitionNode: aString) ifTrue: [
						^ defItem definition ].
					(defItem isViennaOperationDefinitionNode: aString) ifTrue: [
						^ defItem definition ] ] ] ].
	self interface importDefinitionList ifNotNil: [ :imports |
		imports do: [ :importDef |
			importDef second isViennaImportModuleSignatureNode ifTrue: [
				importDef second do: [ :imps |
					imps do: [ :import |
						(import at: import size) ifNotNil: [ :rename |
							rename first = aString ifTrue: [ ^ import ] ] ] ] ] ] ].
	^ nil
]

{ #category : #accessing }
ViennaModuleNode >> exportDefinition [

	^ self interface exportDefinition
]

{ #category : #'pretty printing' }
ViennaModuleNode >> formatWith: aViennaAbstractFormatter [

	| identifier interface moduleBody |
	identifier := aViennaAbstractFormatter format: self first.
	interface := aViennaAbstractFormatter format: self second.
	moduleBody := self third
		              ifNil: [ '' ]
		              ifNotNil: [ :node |
		              String cr , (aViennaAbstractFormatter format: node) ].
	^ 'module ' , identifier , String cr , interface , moduleBody
	  , String cr , 'end ' , identifier
]

{ #category : #private }
ViennaModuleNode >> freeIdentifiersExcept: aSet do: aBlock [

	self moduleBody
		freeIdentifiersExcept:
			aSet , self moduleBody uniqueBoundIdentifiers
			, self uniqueImportedIdentifiers
		do: aBlock
]

{ #category : #testing }
ViennaModuleNode >> hasScope [

	^ true
]

{ #category : #accessing }
ViennaModuleNode >> identifier [

	^ self at: 1
]

{ #category : #accessing }
ViennaModuleNode >> identifier: aString [

	self at: 1 put: aString
]

{ #category : #enumerating }
ViennaModuleNode >> importDefinitionsDo: aBlock [

	self interface importDefinitionList ifNotNil: [ :importDefinitionList |
		importDefinitionList do: aBlock ]
]

{ #category : #accessing }
ViennaModuleNode >> importsIdentifier: aString [

	self interface boundIdentifiersDo: [ :string |
		string = aString ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #accessing }
ViennaModuleNode >> interface [

	^ self at: 2
]

{ #category : #accessing }
ViennaModuleNode >> interface: aViennaInterfaceNode [

	self at: 2 put: aViennaInterfaceNode
]

{ #category : #testing }
ViennaModuleNode >> isViennaModuleNode [

	^ true
]

{ #category : #testing }
ViennaModuleNode >> isViennaModuleNode: aString [

	^ self identifier = aString
]

{ #category : #testing }
ViennaModuleNode >> label [

	^ 'Module'
]

{ #category : #accessing }
ViennaModuleNode >> moduleBody [

	^ self at: 3
]

{ #category : #accessing }
ViennaModuleNode >> moduleBody: aViennaModuleBodyNode [

	self at: 3 put: aViennaModuleBodyNode
]

{ #category : #'accessing-definitions' }
ViennaModuleNode >> resolveIdentifier: aString [

	self toplevelDefinitionsDo: [ :definition |
		(definition bindsIdentifier: aString) ifTrue: [ ^ definition ] ].
	self importDefinitionsDo: [ :importDefinition |
		importDefinition importsDo: [ :import |
			import rename identifier = aString ifTrue: [ ^ import ] ] ].
	^ nil
]

{ #category : #enumerating }
ViennaModuleNode >> sectionsDo: aBlock [

	self moduleBody sectionsDo: aBlock
]

{ #category : #testing }
ViennaModuleNode >> shortName [

	^ self identifier
]

{ #category : #enumerating }
ViennaModuleNode >> toplevelDefinitionsDo: aBlock [

	self moduleBody toplevelDefinitionsDo: aBlock
]

{ #category : #accessing }
ViennaModuleNode >> uniqueImportedIdentifiers [

	^ self interface uniqueBoundIdentifiers
]
