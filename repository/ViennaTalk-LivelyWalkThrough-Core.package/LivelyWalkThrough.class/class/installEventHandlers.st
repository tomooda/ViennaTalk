class initialization
installEventHandlers
	ExternalDropHandler
		registerHandler:
			(ExternalDropHandler
				type: nil
				extension: 'lwt'
				action: [ :stream :pasteUp :event | LivelyWalkThrough openDefault director loadStream: stream ])