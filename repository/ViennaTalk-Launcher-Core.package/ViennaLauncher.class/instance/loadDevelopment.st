menu operations
loadDevelopment
	self updateConfiguration.
	Smalltalk at: #ConfigurationOfViennaTalk ifPresent: [ :config | config loadDevelopment ]