menu operations
loadStable
	self updateConfiguration.
	Smalltalk at: #ConfigurationOfViennaTalk ifPresent: [ :config | config load ]