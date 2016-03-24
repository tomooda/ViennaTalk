menu operations
updateConfiguration
	Smalltalk at: #ConfigurationOfViennaTalk ifPresent: [ :config | config possiblyNewerVersions ifEmpty: [ ^ self ] ].
	Gofer new
		smalltalkhubUser: 'tomooda' project: 'ViennaTalk';
		configurationOf: #ViennaTalk;
		load