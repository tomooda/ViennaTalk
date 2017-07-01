settings
viennaSettingsOn: aBuilder
	<systemsettings>
	(aBuilder setting: #viennaTalkAlwaysUseServer)
		parent: #ViennaTalkServices;
		target: self;
		getSelector: #alwaysUsesViennaServerAsDefault;
		setSelector: #alwaysUsesViennaServerAsDefault:;
		description: 'If checked, "ViennaEngine default" always chooses the vienna server via HTTP even when a local VDMJ process is available.';
		label: 'Always uses vienna Server via HTTP';
		order: 0.5