utilities
createModuleClassWithInstVars: anArrayOfString forModule: aString env: aDictionary
	^ AnonymousClassInstaller
		make: [ :builder | 
			builder
				superclass: Object;
				slots: (anArrayOfString asArray collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ]);
				category: 'Auto Generated from VDM' ]