value pane menu
valuePaneMenu: aMenu shifted: aBoolean
	aMenu
		addList:
			{{('find...(f)' translated).
			#find}.
			{('find again (g)' translated).
			#findAgain}.
			{('set search string (h)' translated).
			#setSearchString}.
			#-.
			{('do again (j)' translated).
			#again}.
			{('undo (z)' translated).
			#undo}.
			#-.
			{('copy (c)' translated).
			#copySelection}.
			{('cut (x)' translated).
			#cut}.
			{('paste (v)' translated).
			#paste}.
			{('paste...' translated).
			#pasteRecent}.
			#-.
			{('do it (d)' translated).
			#valuePaneDoIt}.
			{('print it (p)' translated).
			#valuePanePrintIt}.
			#-.
			{('accept (s)' translated).
			#valuePaneAccept}.
			{('cancel (l)' translated).
			#valuePaneCancel}.
			#-.
			{('save contents to file...' translated).
			#saveContentsInFile}}.
	^ aMenu