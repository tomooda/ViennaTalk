utilities
createDocumentClassWithInstVars: anArrayOfString1 stateVars: anArrayOfString2
	| documentClassName |
	documentClassName := self requestClassName: '' for: 'Document'.
	documentClassName ifNil: [ ^ nil ].
	^ PharoClassInstaller
		make: [ :builder | 
			builder
				name: documentClassName asSymbol;
				superclass: Object;
				slots:
						(anArrayOfString1 asArray collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ])
								, (anArrayOfString2 asArray collect: [ :instVarName | ViennaStateSlot named: instVarName asSymbol ]);
				category: 'Auto Generated from VDM' ]