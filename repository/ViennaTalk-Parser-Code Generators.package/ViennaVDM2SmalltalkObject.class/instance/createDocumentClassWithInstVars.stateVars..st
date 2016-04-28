utilities
createDocumentClassWithInstVars: anArrayOfString1 stateVars: anArrayOfString2
	^ AnonymousClassInstaller
		make: [ :builder | 
			builder
				superclass: Object;
				slots:
						(anArrayOfString1 asArray collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ])
								, (anArrayOfString2 asArray collect: [ :instVarName | ViennaStateSlot named: instVarName asSymbol ]);
				category: 'Auto Generated from VDM' ]
