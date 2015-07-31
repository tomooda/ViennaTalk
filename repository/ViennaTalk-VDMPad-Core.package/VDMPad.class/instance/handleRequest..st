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
			map isSymbol
				ifTrue: [ 
					^ map numArgs = 0
						ifTrue: [ self perform: map ]
						ifFalse: [ self perform: map with: aZnRequest ] ].
			map isClosure
				ifTrue: [ ^ map cull: aZnRequest ] ].
	^ self responseNotFound: aZnRequest uri