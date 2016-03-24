menu operations
loadStable
	Gofer new
		smalltalkhubUser: 'tomooda' project: 'ViennaTalk';
		configurationOf: #ViennaTalk;
		load.
	(Smalltalk at: #ConfigurationOfViennaTalk) load