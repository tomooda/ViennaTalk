request handling-api
format: aZnRequest
	| params source formattedSource message json |
	params := self getParamsFrom: aZnRequest.
	source := (params at: 'source' ifAbsent: [ String new ]) trimmed copyReplaceAll: String lf with: String cr.
	message := String new.
	formattedSource := [ ViennaVDMParser new format: source width: 70 ]
		on: Error
		do: [ :ex | source ].
	formattedSource isPetitFailure
		ifTrue: [ 
			message := formattedSource printString.
			formattedSource := source ].
	json := params copy.
	json
		at: 'source' put: (formattedSource copyReplaceAll: String cr with: String lf);
		at: 'message' put: message;
		at: 'value' put: (params at: 'value' ifAbsent: [ String new ]).
	^ self responseJSON: json