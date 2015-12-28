parsers
jsonValue
	^ PPJsonParser new value flatten
		==> [ :json | 
			WWTTranslationObjectMatcher
				with:
					((NeoJSONReader on: json readStream)
						listClass: OrderedCollection;
						next) ]