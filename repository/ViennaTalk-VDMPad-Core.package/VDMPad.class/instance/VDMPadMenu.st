request handling-javascript
VDMPadMenu
	^ '
VDMPad.fileItemsExpanded = false;
VDMPad.currentFileItemNode = null;

VDMPad.files = function () {
    if (localStorage) {
        return JSON.parse(localStorage.getItem("`files"));
    }
    return [];
};

VDMPad.setupMenuNodes = function () {
    VDMPad.menuNode = document.getElementById("menu");
    VDMPad.rootMenuNode = document.getElementById("root_menu");
    VDMPad.rootMenuIconNode = document.getElementById("rootMenuIcon");
    VDMPad.fileItemsNode = document.getElementById("file_items");
    VDMPad.rootMenuNode.onmouseover = function () {
        VDMPad.expandFileItems();
    };
    VDMPad.mainNode.onmouseover = function () {
        VDMPad.currentFileItemNode = null;
        if (!VDMPad.fileItemsExpanded)
            VDMPad.shrinkFileItems();
    };
    VDMPad.rootMenuNode.onclick = function () {
        if (VDMPad.fileItemsExpanded) {
            VDMPad.rootMenuIconNode.src = "/rootMenuOff.png";
            VDMPad.fileItemsExpanded = false;
        } else {
            VDMPad.rootMenuIconNode.src = "/rootMenuOn.png";
            VDMPad.fileItemsExpanded = true;
        }
    };
};

VDMPad.updateFileItems = function () {
    if (VDMPad.fileItemsNode.firstChild) {
        while (VDMPad.fileItemsNode.firstChild)
            VDMPad.fileItemsNode.removeChild(VDMPad.fileItemsNode.firstChild);
        VDMPad.node.style.width = "850px";
        VDMPad.menuNode.style.width = "230px";
        var files = VDMPad.files();
        for (var i = 0; i < files.length; i++)
            VDMPad.fileItemsNode.appendChild(VDMPad.createFileNode(files[i]));
        VDMPad.fileItemsNode.appendChild(VDMPad.createSaveAsInputNode());
        VDMPad.fileItemsNode.appendChild(VDMPad.createConfigNode());
    }
};

VDMPad.expandFileItems = function () {
    if (!VDMPad.fileItemsNode.firstChild) {
        VDMPad.node.style.width = "850px";
        VDMPad.menuNode.style.width = "230px";
        var files = VDMPad.files();
        for (var i = 0; i < files.length; i++)
            VDMPad.fileItemsNode.appendChild(VDMPad.createFileNode(files[i]));
        VDMPad.fileItemsNode.appendChild(VDMPad.createSaveAsInputNode());
        VDMPad.fileItemsNode.appendChild(VDMPad.createConfigNode());
    }
};

VDMPad.shrinkFileItems = function () {
    if (VDMPad.fileItemsNode.firstChild) {
        while (VDMPad.fileItemsNode.firstChild)
            VDMPad.fileItemsNode.removeChild(VDMPad.fileItemsNode.firstChild);
        VDMPad.menuNode.style.width = "80px";
        setTimeout(function () {VDMPad.node.style.width = "750px";}, 20);
        setTimeout(function () {VDMPad.node.style.width = "700px";}, 40);
        setTimeout(function () {VDMPad.node.style.width = "650px";}, 60);
        setTimeout(function () {VDMPad.node.style.width = "640px";}, 80);
    }
};

VDMPad.createFileNode = function (name) {
    var node = document.createElement("div");
    var labelNode = document.createElement("div");
    var buttonsNode = document.createElement("div");
    var loadNode = document.createElement("img");
    var saveNode = document.createElement("img");
    var exportNode = document.createElement("img");
    var deleteNode = document.createElement("img");
    var defaultBackgroundColor = "white";
    if (VDMPad.currentSpec == name)
        defaultBackgroundColor = "Gainsboro";
    node.id = name;
    node.style.width = "280px";
    node.marginLeft = "10px";
    node.style.color = "black";
    node.style.padding = "10px 4px";

    node.style.backgroundColor = defaultBackgroundColor;
    node.defaultBackgroundColor = defaultBackgroundColor;
    labelNode.style.width = "100%";
    labelNode.innerText = name;
    labelNode.textContent = name;
    node.appendChild(labelNode);
    buttonsNode.style.float = "top";
    buttonsNode.style.width = "60px";
    buttonsNode.style.marginLeft = "20px";
    loadNode.src = "/load.png";
    loadNode.style.padding = "5px 5px";
    buttonsNode.appendChild(loadNode);
    saveNode.src = "/save.png";
    saveNode.style.padding = "5px 5px";
    buttonsNode.appendChild(saveNode);
    exportNode.src = "/export.png";
    exportNode.style.padding = "5px 5px";
    buttonsNode.appendChild(exportNode);
    deleteNode.src = "/delete.png";
    deleteNode.style.padding = "5px 5px";
    buttonsNode.appendChild(deleteNode);
    node.isOpen = false;
    node.onclick = function () {
        VDMPad.menuButtonsNode = buttonsNode;
        if (!node.isOpen) {
            node.appendChild(buttonsNode);
            node.isOpen = true;
        } else {
            node.removeChild(buttonsNode);
            node.isOpen = false;
        }
    };
    loadNode.onclick = function () {
        VDMPad.load(name);
    };
    saveNode.onclick = function () {
        VDMPad.saveAs(name, false);
    };
    exportNode.onclick = function () {
        VDMPad.saveAs(name, true);
    };
    deleteNode.onclick = function () {
        VDMPad.remove(name);
    };
    return node;

};

VDMPad.createSaveAsInputNode = function () {
    var node = document.createElement("div");
    var inputNode = document.createElement("input");
    var saveNode = document.createElement("img");
    
    node.style.width = "280px";
    node.style.height = "30px";
    inputNode.style.width = "100%";
    node.appendChild(inputNode);
    saveNode.style.visibility = "collapse";
    saveNode.src = "/save.png";
    node.appendChild(saveNode);
    inputNode.onkeyup = function () {
        if (inputNode.value)
            saveNode.style.visibility = "visible";
        else
            saveNode.style.visibility = "hidden";
    };
    saveNode.onmouseover = function () {
        saveNode.src = "/saveS.png";
    };
    saveNode.onmouseout = function () {
        saveNode.src = "/save.png";
    };
    saveNode.onclick = function () {
        VDMPad.saveAs(inputNode.value, false);
    };
    return node;
};

VDMPad.createConfigNode = function () {
	var configNode = document.createElement("div");
	configNode.style.border="1px solid lightgrey";
	configNode.style.borderRadius = "5px";
	configNode.style.paddingLeft = "10px";
	configNode.style.width = "270px";
	configNode.innerText = "Config";
	configNode.textContent = "Config";
	var unittestNode = document.createElement("div");
	var unittestCheckbox = document.createElement("input");
	unittestCheckbox.type = "checkbox";
	unittestCheckbox.style.PaddingRight = "10px";
	unittestCheckbox.checked = VDMPad.unittestEnabled;
	unittestCheckbox.onclick = function () {if (this.checked) VDMPad.enableUnittest(); else VDMPad.disableUnittest();};
	unittestNode.appendChild(unittestCheckbox);
	unittestNode.appendChild(document.createTextNode("Unit Testing"));
	configNode.appendChild(unittestNode);
	var visualNode = document.createElement("div");
	var visualCheckbox = document.createElement("input");
	visualCheckbox.type = "checkbox";
	visualCheckbox.style.PaddingRight = "10px";
	visualCheckbox.checked = VDMPad.visualEnabled;
	visualCheckbox.onclick = function () {if (this.checked) VDMPad.enableVisual(); else VDMPad.disableVisual();};
	visualNode.appendChild(visualCheckbox);
	visualNode.appendChild(document.createTextNode("Visual Expressions"));
	configNode.appendChild(visualNode);
	var invExceptionsNode = document.createElement("div");
	var invExceptionsCheckbox = document.createElement("input");
	invExceptionsCheckbox.type = "checkbox";
	invExceptionsCheckbox.style.PaddingRight = "10px";
	invExceptionsCheckbox.checked = VDMPad.invExceptionsEnabled;
	invExceptionsCheckbox.onclick = function () {if (this.checked) VDMPad.enableInvExceptions(); else VDMPad.disableInvExceptions();};
	invExceptionsNode.appendChild(invExceptionsCheckbox);
	invExceptionsNode.appendChild(document.createTextNode("Assertion errors as exceptions"));
	configNode.appendChild(invExceptionsNode);
	var vdmClassicNode = document.createElement("div");
	var vdmClassicCheckbox = document.createElement("input");
	vdmClassicCheckbox.type = "checkbox";
	vdmClassicCheckbox.style.PaddingRight = "10px";
	vdmClassicCheckbox.checked = VDMPad.vdmClassicEnabled;
	vdmClassicCheckbox.onclick = function () {if (this.checked) VDMPad.enableVDMClassic(); else VDMPad.disableVDMClassic();};
	vdmClassicNode.appendChild(vdmClassicCheckbox);
	vdmClassicNode.appendChild(document.createTextNode("VDM classic"));
	configNode.appendChild(vdmClassicNode);

	var runtimeCheckingNode = document.createElement("div");
	var runtimeCheckingCheckbox = document.createElement("input");
	runtimeCheckingCheckbox.type = "checkbox";
	runtimeCheckingCheckbox.style.PaddingRight = "10px";
	runtimeCheckingCheckbox.checked = VDMPad.runtimeCheckingEnabled;
	runtimeCheckingCheckbox.onclick = function () {if (this.checked) VDMPad.enableRuntimeChecking(); else VDMPad.disableRuntimeChecking();};
	runtimeCheckingNode.appendChild(runtimeCheckingCheckbox);
	runtimeCheckingNode.appendChild(document.createTextNode("runtime checking"));
	configNode.appendChild(runtimeCheckingNode);

	return configNode;
};

' copyReplaceAll: String cr with: String crlf