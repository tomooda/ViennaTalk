request handling
handleApi: aZnRequest
	| args path |
	args := self argsFrom: aZnRequest.
	path := aZnRequest uri segments.
	path size = 1
		ifTrue: [ ^ self apiCall: path first in: nil withArguments: args ].
	path size = 2
		ifTrue: [ ^ self apiCall: path second in: path first withArguments: args ].
	^ self responseNotFound: aZnRequest uri