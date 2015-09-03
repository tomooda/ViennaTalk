request handling
value: aZnRequest
	^ (aZnRequest uri segments ifNotNil: [ :segments | segments at: 2 ifAbsent: [  ] ])
		ifNil: [ ZnResponse notFound: aZnRequest uri ]
		ifNotNil: [ :widgetName | 
			(self morphNamed: widgetName ifAbsent: [  ])
				ifNil: [ ZnResponse notFound: aZnRequest uri ]
				ifNotNil: [ :morph | 
					aZnRequest entity
						ifNotNil: [ :entity | 
							ZnResponse
								ok:
									(ZnEntity
										text:
											(morph
												value: entity contents;
												value)) ]
						ifNil: [ ZnResponse ok: (ZnEntity text: morph value) ] ] ]