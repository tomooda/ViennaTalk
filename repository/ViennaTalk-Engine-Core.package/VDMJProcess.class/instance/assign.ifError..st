commands
assign: aDictionary ifError: errorBlock 
	aDictionary
		ifNotEmpty: [| statement |
			statement := String new writeStream.
			statement nextPutAll: 's atomic('.
			aDictionary keys asArray
				do: [:var | statement nextPutAll: var;
						 nextPutAll: ':=';
						
						nextPutAll: (aDictionary at: var)]
				separatedBy: [statement nextPut: $;].
			statement nextPut: $).
			^ self
				send: statement contents
				responseDo: [:unit | unit]
				ifError: errorBlock]