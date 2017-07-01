utilities
createModuleClassWithInstVars: anArrayOfString1 stateVars: anArrayOfString2 forModule: aString env: aDictionary
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