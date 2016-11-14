class initialization
installEventHandlers
	ExternalDropHandler
		registerHandler:
			(ExternalDropHandler
				type: nil
				extension: 'vdmsl'
				action: [ :stream :pasteUp :event | 
					(ViennaBrowser on: ViennaAnimation default)
						openLabel: stream name;
						acceptCode: stream contents ])