Class {
	#name : #ViennaVDM2SmalltalkObject,
	#superclass : #ViennaVDM2SmalltalkClass,
	#category : 'ViennaTalk-Transpiler-Core'
}

{ #category : #utilities }
ViennaVDM2SmalltalkObject >> createDocumentClassWithInstVars: anArrayOfString [
	^ self createDocumentClassWithInstVars: anArrayOfString stateVars: #()
]

{ #category : #utilities }
ViennaVDM2SmalltalkObject >> createDocumentClassWithInstVars: anArrayOfString1 stateVars: anArrayOfString2 [
	^ AnonymousClassInstaller
		make: [ :builder | 
			builder
				superclass: ViennaTranspiledObject;
				slots:
					(anArrayOfString1 asArray
						collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ])
						,
							(anArrayOfString2 asArray
								collect: [ :instVarName | 
									(runtimeAssertionCheck = true
										ifTrue: [ ViennaStateSlot ]
										ifFalse: [ InstanceVariableSlot ]) named: instVarName asSymbol ]);
				category: 'Auto Generated from VDM' ]
]

{ #category : #utilities }
ViennaVDM2SmalltalkObject >> createModuleClassWithInstVars: anArrayOfString1 stateVars: anArrayOfString2 forModule: aString env: aDictionary [
	^ (AnonymousClassInstaller
		make: [ :builder | 
	builder
		superclass: ViennaTranspiledObject;
		slots:
			(anArrayOfString1 asArray
				collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ])
				,
					(anArrayOfString2 asArray
						collect: [ :instVarName | 
							(runtimeAssertionCheck = true
								ifTrue: [ ViennaStateSlot ]
								ifFalse: [ InstanceVariableSlot ]) named: instVarName asSymbol ]);
		category: 'Auto Generated from VDM' ])
		viennaEnv: aDictionary;
		yourself
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkObject >> flatDocument: aViennaNode env: aDictionary [
	^ (super flatDocument: aViennaNode env: aDictionary) ifNotNil: [ :anonymousClass | anonymousClass new ]
]

{ #category : #'code generation-definitions' }
ViennaVDM2SmalltalkObject >> modularDocument: aViennaNode env: aDictionary [
	| objects |
	aViennaNode do: [ :node | self generate: node env: aDictionary ].
	objects := classes collect: [ :moduleClass | moduleClass new ].
	aViennaNode
		do: [ :moduleNode | 
			| moduleName moduleObject |
			moduleName := moduleNode first.
			moduleObject := objects at: moduleName.
			moduleNode second first
				ifNotNil: [ :importDefinitionListNode | 
					importDefinitionListNode
						do: [ :importDefinitionNode | 
							| importedModuleName importedModuleObject |
							importedModuleName := importDefinitionNode first.
							importedModuleObject := objects at: importedModuleName.
							moduleObject
								perform: (importedModuleName , ':') asSymbol
								with: importedModuleObject ] ] ].
	objects valuesDo: [ :moduleObject | moduleObject init ].
	^ (ViennaTranspiledModularDocument from: objects)
		buildViennaEnv;
		yourself
]
