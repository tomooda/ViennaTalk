request handling
handleRequest: aZnRequest
	| path map |
	path := aZnRequest uri isSlash
		ifTrue: [ #('/') ]
		ifFalse: [ aZnRequest uri segments ].
	map := handlerMap.
	path
		do: [ :name | 
			map := map at: name ifAbsent: [ ^ self responseNotFound: aZnRequest uri ].
			map isClosure
				ifTrue: [ ^ map cull: aZnRequest ].
			map isSymbol
				ifTrue: [ ^ self perform: map with: aZnRequest ] ].
	^ self responseNotFound: aZnRequest uri