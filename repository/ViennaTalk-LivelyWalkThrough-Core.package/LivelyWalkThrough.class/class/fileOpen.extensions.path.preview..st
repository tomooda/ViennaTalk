utilities
fileOpen: title extensions: exts path: path preview: preview
	"LivelyWalkThrough fileOpen: 'title' extensions: #('png' 'jpg') path: nil preview: #image"

	| ref ui fd |
	ref := path isString ifTrue: [ (FileSystem disk pathFromString: path)  asFileReference ] ifFalse: [ path  ].
	ui := UIManager default.
	fd := FileDialogWindow basicNew
		basicTheme: ui theme;
		previewType: preview;
		initialize;
		title: title;
		answerPathName.
	exts ifNotNil: [ fd validExtensions: exts ].
	path ifNotNil: [ fd selectPathName: ref parent  ].
	^ (ui openModal: fd) answer ifNotNil: [ :ans | ans asFileReference ]