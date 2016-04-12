utilities
createDocumentClassWithInstVars: anArrayOfString
	| documentClassName |
	documentClassName := self requestClassName: ''.
	documentClassName ifNil: [ ^ nil ].
	^ PharoClassInstaller
		make: [ :builder | 
			builder
				name: documentClassName asSymbol;
				superclass: Object;
				slots: (anArrayOfString asArray collect: [ :instVarName | InstanceVariableSlot named: instVarName asSymbol ]);
				category: 'Auto Generated from VDM' ]