code pane
acceptCode: aStringOrText
	^ self acceptCode: aStringOrText newModuleAndSourceDo: [ :module | self saveModule: module ]