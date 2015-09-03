accessing
remoteWidget
	^ remoteWidget
		ifNil: [ 
			remoteWidget := LWTRemoteWidget new
				freeze;
				name: 'Remote';
				nameColor: Color black;
				nameFont: self nameFontForWidgets;
				yourself ]