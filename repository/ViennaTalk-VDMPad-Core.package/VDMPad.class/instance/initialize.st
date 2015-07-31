initialize-release
initialize
	super initialize.
	engine := ViennaVDMJ bank: 16.
	handlerMap := Dictionary new
		at: '/' put: #mainPage;
		at: 'favicon.ico' put: #vdmpadIcon;
		at: 'about.html' put: #aboutPage;
		at: 'VDMJcopyright.html' put: #vdmjCopyrightPage;
		at: 'VDMPad.js' put: #VDMPad;
		at: 'codemirror-vdm.js' put: #codemirrorVDM;
		at: 'tabIndent.js' put: #tabIndent;
		at: 'fileSaver.js' put: #fileSaver;
		at: 'blob.js' put: #blob;
		at: 'codemirror' put: #fileService:;
		at: 'eval' put: #eval:;
		at: 'id' put: #id:;
		at: 'test' put: #test:;
		at: 'vdm2html' put: #vdm2html:;
		at: 'rootMenuOn.png' put: #rootMenuOn;
		at: 'rootMenuOff.png' put: #rootMenuOff;
		at: 'load.png' put: #loadIcon;
		at: 'save.png' put: #saveIcon;
		at: 'export.png' put: #exportIcon;
		at: 'delete.png' put: #deleteIcon;
		at: 'load.Spng' put: #loadSelectedIcon;
		at: 'saveS.png' put: #saveSelectedIcon;
		at: 'exportS.png' put: #exportSelectedIcon;
		at: 'deleteS.png' put: #deleteSelectedIcon;
		at: 'saveT.png' put: #saveTransparentIcon;
		yourself