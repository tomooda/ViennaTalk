json
widgetsToJsonObject
	^ (submorphs select: [ :m | m isKindOf: LWTWidget ] thenCollect: [ :m | m asJsonObject ]) asArray