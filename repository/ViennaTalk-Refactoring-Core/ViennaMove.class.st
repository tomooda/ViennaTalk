Class {
	#name : 'ViennaMove',
	#superclass : 'ViennaRefactoring',
	#instVars : [
		'definitionNode',
		'newDefinitionNode',
		'sourceModule',
		'destinationModule',
		'okToAddImports'
	],
	#category : 'ViennaTalk-Refactoring-Core',
	#package : 'ViennaTalk-Refactoring-Core'
}

{ #category : 'testing' }
ViennaMove class >> isAbstract [
	^ self == ViennaMove
]

{ #category : 'operations' }
ViennaMove >> check [

	ast ifNil: [ ^ false ].
	self definitionNode ifNil: [ ^ false ].
	destinationModule ifNotNil: [
		(self definitionNames anySatisfy: [ :identifier |
			 (destinationModule resolveIdentifier: identifier) notNil ])
			ifTrue: [ ^ false ] ].
	^ true
]

{ #category : 'operations' }
ViennaMove >> defineDestination [

	newDefinitionNode := self definitionNode copyFragment.
	self migrate: newDefinitionNode into: self destinationModule.
	self addDefinition: newDefinitionNode in: self destinationModule.
	self ensureExport: newDefinitionNode.
	(self sourceModule moduleBody hasAnyDescendantsSuchThat: [ :node |
		 node isViennaLocalNameNode and: [
			 node resolve == self definitionNode ] ]) ifTrue: [
		self ensureImport: newDefinitionNode in: self sourceModule ].
	self updateName: self sourceModule moduleBody.
	self updateName: self destinationModule moduleBody
]

{ #category : 'accessing' }
ViennaMove >> definitionNames [

	^ Array with: self definitionNode identifier
]

{ #category : 'accessing' }
ViennaMove >> definitionNode [
	^ definitionNode ifNil: [ definitionNode := self findDefinitionNode ]
]

{ #category : 'accessing' }
ViennaMove >> definitionNode: aViennaNode [
	definitionNode := aViennaNode
]

{ #category : 'accessing' }
ViennaMove >> destinationModule [
	^ destinationModule ifNil: [ destinationModule := self findDestinationModule ]
]

{ #category : 'accessing' }
ViennaMove >> destinationModule: aViennaNode [
	destinationModule := aViennaNode
]

{ #category : 'operations' }
ViennaMove >> execute [

	self destinationModule ifNil: [ ^ nil ].
	self sourceModule ifNil: [ ^ nil ].
	self
		defineDestination;
		removeImportInDestination;
		removeExportInSource;
		rewriteImports;
		removeSource.
	^ newDefinitionNode
]

{ #category : 'accessing' }
ViennaMove >> findDefinitionNode [
	^ self subclassResponsibility 
]

{ #category : 'accessing' }
ViennaMove >> findDestinationModule [
	| choices |
	choices := Array
		streamContents: [ :stream | 
			ast
				modulesDo: [ :moduleNode | 
					moduleNode ~~ self definitionNode module
						ifTrue: [ (self definitionNames
								allSatisfy: [ :localName | 
									| localDef |
									localDef := moduleNode resolveIdentifier: localName.
									localDef isNil or: [ localDef == self definitionNode ] ])
								ifTrue: [ stream nextPut: moduleNode first ] ] ] ].
	^ ast
		moduleNamed:
			(UIManager default
				chooseFrom: choices
				values: choices
				title:
					'Select the destination to move '
						, (',' join: self definitionNames) , ' to.')
]

{ #category : 'operations' }
ViennaMove >> findOkToAddImports [

	^ UIManager default confirm:
		  'OK to add import in ' , self destinationModule identifier
]

{ #category : 'testing' }
ViennaMove >> isForDefinitionList [

	^ true
]

{ #category : 'accessing' }
ViennaMove >> name [

	^ 'Move ' asText , (', ' asText join:
		   (self definitionNames collect: [ :name | (name ifNil: [ '-' ]) asText allBold ]))
	  , ' to ' , (destinationModule
		   ifNil: [ 'another module' ]
		   ifNotNil: [ 'module ' , destinationModule name ]) asText
]

{ #category : 'accessing' }
ViennaMove >> okToAddImports [
	^ okToAddImports ifNil: [ okToAddImports := self findOkToAddImports ]
]

{ #category : 'accessing' }
ViennaMove >> okToAddImports: aBoolean [
	okToAddImports := aBoolean
]

{ #category : 'operations' }
ViennaMove >> removeExportInSource [
	^ self retractExport: self definitionNode
]

{ #category : 'operations' }
ViennaMove >> removeImportInDestination [

	self retractImport: self definitionNode in: self destinationModule
]

{ #category : 'operations' }
ViennaMove >> removeSource [

	| section |
	section := self definitionNode parent.
	section remove: self definitionNode.
	section ifEmpty: [ section parent remove: section ]
]

{ #category : 'operations' }
ViennaMove >> rewriteImports [

	| names |
	names := self definitionNames asSet.
	newDefinitionNode modulesDo: [ :moduleNode |
		| imports newImportModuleSignature |
		imports := Array streamContents: [ :stream |
			           moduleNode
				           importsFrom: self sourceModule identifier
				           do: [ :importModuleSignature |
					           importModuleSignature do: [ :importSignature |
						           importSignature do: [ :import |
							           (names includes: import name) ifTrue: [
								           stream nextPut: import ] ] ] ] ].
		newImportModuleSignature := ViennaImportModuleSignatureNode empty.
		imports do: [ :import |
			(newImportModuleSignature isEmpty or: [
				 newImportModuleSignature last class ~= import parent class ])
				ifTrue: [ newImportModuleSignature add: import parent class empty ].
			newImportModuleSignature last add: import copyFragment ].
		imports do: [ :import |
			| signature |
			signature := import parent.
			signature remove: import.
			signature ifEmpty: [
				| moduleSignature |
				moduleSignature := signature parent.
				moduleSignature remove: signature.
				moduleSignature ifEmpty: [
					| importDefinition importDefinitionList |
					importDefinition := moduleSignature parent.
					importDefinitionList := importDefinition parent.
					importDefinitionList remove: importDefinition ] ] ].
		newImportModuleSignature ifNotEmpty: [
			moduleNode addImportDefinition: (ViennaImportDefinitionNode
					 moduleIdentifier: self destinationModule name
					 importModuleSignature: newImportModuleSignature) ] ]
]

{ #category : 'accessing' }
ViennaMove >> sortingOrder [
	^ 0.0
]

{ #category : 'accessing' }
ViennaMove >> sourceModule [
	^ sourceModule ifNil: [ sourceModule := ast ifNotNil: #module ]
]

{ #category : 'accessing' }
ViennaMove >> sourceModule: aViennaNode [
	sourceModule := aViennaNode
]

{ #category : 'operations' }
ViennaMove >> updateName: aViennaNode [

	aViennaNode = self definitionNode ifTrue: [ ^ self ].
	aViennaNode = newDefinitionNode ifTrue: [ ^ self ].
	aViennaNode isViennaNameNode ifTrue: [
		^ aViennaNode resolve ifNotNil: [ :node |
			  node == self definitionNode ifTrue: [
				  ^ self replaceNode: aViennaNode with: (self
						     nameForGlobalName: (aViennaNode asGlobalName copyFragment
								      moduleIdentifier: self destinationModule identifier;
								      yourself)
						     in: aViennaNode module) ] ] ].
	aViennaNode do: [ :node |
		node isViennaNode ifTrue: [ self updateName: node ] ]
]
