utilities
createModuleClassWithInstVars: anArrayOfString1 stateVars: anArrayOfString2 forModule: aString env: aDictionary
	| className |
	className := aDictionary at: aString ifAbsent: [ aString ].
	^ PharoClassInstaller
		make: [ :builder | 
			builder
				name: className asSymbol;
				superclass: Object;
				slots:
						(anArrayOfString1 asArray collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ])
								, (anArrayOfString2 asArray collect: [ :instVarName | ViennaStateSlot named: instVarName asSymbol ]);
				category: 'Auto Generated from VDM' ]