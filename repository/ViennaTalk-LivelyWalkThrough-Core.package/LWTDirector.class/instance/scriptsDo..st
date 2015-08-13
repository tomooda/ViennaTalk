private
scriptsDo: aBlock
	scripts valuesDo: [ :scriptDict | scriptDict valuesDo: aBlock ]