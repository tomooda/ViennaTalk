settings
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder setting: #syntaxHighlighting)
		parent: #ViennaTalkAppearances;
		target: self;
		getSelector: #defaultHighlightingEnabled;
		setSelector: #defaultHighlightingEnabled:;
		description: 'If checked, then VDM source will be syntax-highlighted.';
		label: 'Syntax highlighting';
		order: 0.6