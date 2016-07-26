request handling-file
binaryFileService: aZnRequest
	| url |
	url := aZnRequest uri path.
	url first = $/
		ifTrue: [ url := url copyFrom: 2 to: url size ].
	(FileStream isAFileNamed: url)
		ifTrue: [ 
			FileStream
				readOnlyFileNamed: url
				do: [ :stream | 
					stream binary.
					^ self responseBinary: stream contents mimeType: (ZnMimeType applicationOctetStream ) ] ].
	^ self responseNotFound: aZnRequest uri