Class {
	#name : 'ViennaVDM2SmalltalkObject',
	#superclass : 'ViennaVDM2SmalltalkClass',
	#category : 'ViennaTalk-Transpiler-Core',
	#package : 'ViennaTalk-Transpiler-Core'
}

{ #category : 'utilities' }
ViennaVDM2SmalltalkObject >> createFlatDocumentClassWithInstVars: anArrayOfString1 stateVars: anArrayOfString2 [

	^ ShiftAnonymousClassInstaller make: [ :builder |
			  builder
				  superclass: self moduleBaseClass;
				  slots: (anArrayOfString1 asArray collect: [ :instVarName |
							   InstanceVariableSlot named: instVarName asSymbol ])
					  , (anArrayOfString2 asArray collect: [ :instVarName |
								   self newStateVariableSlotNamed: instVarName ]);
				  package: 'Auto Generated from VDM' ]
]

{ #category : 'utilities' }
ViennaVDM2SmalltalkObject >> createModuleClass: aString withInstVars: anArrayOfString1 stateVars: anArrayOfString2 env: aDictionary [

	^ (ShiftAnonymousClassInstaller make: [ :builder |
				   builder
					   superclass: self moduleBaseClass;
					   slots: (anArrayOfString1 asArray collect: [ :instVarName |
								    InstanceVariableSlot named: instVarName asSymbol ])
						   , (anArrayOfString2 asArray collect: [ :instVarName |
									    self newStateVariableSlotNamed: instVarName ]);
					   package: 'Auto Generated from VDM' ])
		  viennaEnv: aDictionary;
		  yourself
]

{ #category : 'class access' }
ViennaVDM2SmalltalkObject >> documentBaseClass [

	^ ViennaTranspiledModularDocument
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkObject >> flatDocument: aViennaNode env: aDictionary [
	^ (super flatDocument: aViennaNode env: aDictionary) ifNotNil: [ :anonymousClass | anonymousClass new ]
]

{ #category : 'code generation-definitions' }
ViennaVDM2SmalltalkObject >> modularDocument: aViennaNode env: aDictionary [

	| objects |
	aViennaNode do: [ :node |
			(Smalltalk globals includesKey: node identifier asSymbol) ifTrue: [
				aDictionary at: node identifier put: '_' , node identifier ] ].
	aViennaNode do: [ :node | self generate: node env: aDictionary ].
	objects := classes collect: [ :moduleClass | moduleClass new ].
	aViennaNode do: [ :moduleNode |
			| moduleName moduleObject |
			moduleName := moduleNode identifier.
			moduleObject := objects at: moduleName.
			moduleNode interface importDefinitionList ifNotNil: [
					:importDefinitionListNode |
					importDefinitionListNode do: [ :importDefinitionNode |
							| importedModuleName importedModuleObject |
							importedModuleName := importDefinitionNode first.
							importedModuleObject := objects at: importedModuleName.
							moduleObject
								perform: (importedModuleName , ':') asSymbol
								with: importedModuleObject ] ] ].
	objects valuesDo: [ :moduleObject | moduleObject initTypes ].
	objects valuesDo: [ :moduleObject | moduleObject init ].
	^ (self documentBaseClass from: objects)
		  buildViennaEnv;
		  yourself
]
