menu operations
loadDevelopment
	Gofer new
		smalltalkhubUser: 'tomooda' project: 'ViennaTalk';
		configurationOf: #ViennaTalk;
		load.
	(Smalltalk at: #ConfigurationOfViennaTalk) loadDevelopment