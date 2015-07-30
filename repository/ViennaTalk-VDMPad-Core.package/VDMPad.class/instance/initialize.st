initialize-release
initialize
	super initialize.
	engine := ViennaVDMJ bank: 16.
	handlerMap := Dictionary new.
	handlerMap at: '/' put: [ self responseHtml: self mainPage ].
	handlerMap at: 'about.html' put: [ self responseHtml: self aboutPage ].
	handlerMap at: 'VDMJcopyright.html' put: [ self responseHtml: self vdmjCopyrightPage ].
	handlerMap at: 'eval' put: #eval: