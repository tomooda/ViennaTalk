instance creation
named: aString on: performer source: source notifying: requestor ifFail: errorBlock
	^ self new
		setName: aString
			performer: performer
			source: source
			notifying: requestor
			ifFail: errorBlock;
		yourself