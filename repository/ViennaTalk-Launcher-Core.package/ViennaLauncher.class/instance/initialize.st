initialize-release
initialize
	| toolsMenu devMenu tools dock image extent |
	super initialize.
	self title: self defaultTitle.
	toolsMenu := self newMenu
		addAllFromPragma: #ViennaToolsMenu target: self;
		addLine;
		add: 'settings...' target: self selector: #showSettingBrowser;
		addLine;
		add: 'update to the latest stable' target: self selector: #loadStable;
		add: 'update to the bleeding edge' target: self selector: #loadDevelopment;
		addLine;
		add: 'reopen' target: self selector: #reopen;
		add: 'close' target: self selector: #close;
		yourself.
	devMenu := self newMenu
		addAllFromPragma: #ViennaDev target: self;
		yourself.
	tools := OrderedCollection new.
	Smalltalk
		at: #VDMPad
		ifPresent: [ :vdmpad | 
			tools
				add:
					(self
						newButtonFor: vdmpad
						getState: #isRunning
						action: #toggleStartStop
						arguments: nil
						getEnabled: nil
						label: 'VDMPad'
						help: 'start/stop VDMPad server' translated) ].
	dock := self newToolDockingBar
		add: 'Tools' translated
			font: self theme menuBarFont
			icon: nil
			help: 'ViennaTalk tools'
			subMenu: toolsMenu;
		add: 'Dev' translated
			font: self theme menuBarFont
			icon: nil
			help: 'ViennaTalk developers'' utilities'
			subMenu: devMenu;
		addMorphBack: (self newToolbar: tools);
		yourself.
	image := self newImage: self viennaLogo.
	extent := image extent + (4 @ (dock minExtent y + 32)).
	self
		addMorph: dock fullFrame: ((0 @ 0 corner: 1 @ 0) asLayoutFrame bottomOffset: dock minExtent y);
		addMorph: image fullFrame: ((0 @ 0 corner: 1 @ 1) asLayoutFrame topOffset: dock minExtent y);
		beUnresizeable;
		extent: extent;
		maximumExtent: extent;
		minimumExtent: extent;
		themeChanged