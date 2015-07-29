adding/removing
remove: aViennaBankEngine ifAbsent: errorBlock
	lock critical: [ ^ engines remove: aViennaBankEngine ifAbsent: errorBlock ]