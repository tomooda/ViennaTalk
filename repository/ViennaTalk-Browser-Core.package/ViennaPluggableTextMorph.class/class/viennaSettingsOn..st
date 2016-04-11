settings
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder setting: #syntaxHighlighting)
		parent: #ViennaTalkAppearances;
		target: self;
		getSelector: #defaultHighlightingEnabled;
		setSelector: #defaultHighlightingEnabled:;
		description: 'If checked, then VDM source will be syntax-highlighted by default.';
		label: 'Syntax highlighting enabled by default';
		order: 0.6