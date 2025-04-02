Extension { #name : 'SpMenuItemPresenter' }

{ #category : '*ViennaTalk-Launcher-Core' }
SpMenuItemPresenter >> fromSpec: aPluggableMenuItemSpec [

	aPluggableMenuItemSpec label ifNotNil: [ :label | self name: label ].
	aPluggableMenuItemSpec icon ifNotNil: [ :icon | self icon: icon ].
	aPluggableMenuItemSpec action ifNotNil: [ :val | self action: val ].
	aPluggableMenuItemSpec subMenu ifNotNil: [ :sub |
		self subMenu: (self newMenu fromSpec: sub) ].
	aPluggableMenuItemSpec help ifNotNil: [ :str | self help: str ]
]
