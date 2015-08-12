workspace pane menu
workspacePaneMenu: aMenu shifted: aBoolean
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
			#workspacePaneDoIt}.
			{('print it (p)' translated).
			#workspacePanePrintIt}.
			#-.
			{('accept (s)' translated).
			#workspaceAccept}.
			{('cancel (l)' translated).
			#workspaceCancel}.
			#-.
			{('copy html' translated).
			#copyHtml}}.
	^ aMenu