menu
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder setting: #defaultRuntimeTypeCheck)
		parent: #ViennaTalkCodeGenerator;
		target: self;
		getSelector: #defaultRuntimeTypeCheck;
		setSelector: #defaultRuntimeTypeCheck:;
		description: 'runtime type checking is on by default';
		label: 'generate type check by default'.
	(aBuilder setting: #defaultRuntimeAssertionCheck)
		parent: #ViennaTalkCodeGenerator;
		target: self;
		getSelector: #defaultRuntimeAssertionCheck;
		setSelector: #defaultRuntimeAssertionCheck:;
		description: 'runtime assertion checking is on by default';
		label: 'generate assertion check by default'