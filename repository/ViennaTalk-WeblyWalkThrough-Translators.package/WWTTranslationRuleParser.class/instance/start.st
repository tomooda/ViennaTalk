parsing
start
	^ rule star ==> [ :pairs | WWTTranslator withAll: pairs ]