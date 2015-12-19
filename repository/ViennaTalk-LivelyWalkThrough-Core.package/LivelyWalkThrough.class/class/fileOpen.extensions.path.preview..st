utilities
fileOpen: title extensions: exts path: path preview: preview
	"LivelyWalkThrough fileOpen: 'title' extensions: #('png' 'jpg') path: nil preview: #image"

	| ui fd |
	ui := UIManager default.
	fd := FileDialogWindow basicNew
		basicTheme: ui theme;
		previewType: preview;
		initialize;
		title: title;
		answerPathName.
	exts ifNotNil: [ fd validExtensions: exts ].
	path ifNotNil: [ fd selectPathName: (FileSystem disk pathFromString: path asString) parent asFileReference fullName ].
	^ (ui openModal: fd) answer ifNotNil: [ :ans | ans asFileReference ]