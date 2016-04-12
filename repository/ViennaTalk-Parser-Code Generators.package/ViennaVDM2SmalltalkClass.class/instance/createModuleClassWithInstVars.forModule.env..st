utilities
createModuleClassWithInstVars: anArrayOfString forModule: aString env: aDictionary
	| className |
	className := aDictionary at: aString ifAbsent: [ aString ].
	^ PharoClassInstaller
		make: [ :builder | 
			builder
				name: className asSymbol;
				superclass: Object;
				slots: (anArrayOfString asArray collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ]);
				category: 'Auto Generated from VDM' ]