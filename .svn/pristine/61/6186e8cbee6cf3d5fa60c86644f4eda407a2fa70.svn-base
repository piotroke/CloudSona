/* ================================ BOF ============================== */
/**
 * Provides FCKeditor plugin to handle key event
 *
 * @file        $RCSfile: fckplugin.js,v $
 * @version     $Revision: 1.7 $
 * @date        $Date: 2006/12/11 16:50:46 $
 * @access      public
 */

/* ------------------------------------------------------------------ */
function gmxHandleEventInQuotedArea(event)
{
	he = new HandleEvent(event);
	return he.doIt();
};

/* ------------------------------------------------------------------ */
/**
 * Constructor
 *
 * @param	object		Event object
 */
var HandleEvent = function(event)
{
	/* Properties */
	this.initProperties(event);
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.doIt = function()
{
	/* Mark node where the event has occured */
	this.setMarker();

	/* Exit if event did not occoured in quoted area */
	if (!this.eventOccurredInQuotedArea()) {
		return true;
	}

	/* Handle key event in quoted area */
	this.handleKeyEnter();

	/* Reset cursor */
	FCK.EditorWindow.focus();
	var sel = FCK.Selection.Delete();
	var rng = sel.getRangeAt(0);
	rng.setEndAfter(this.brnode);
	rng.setStartAfter(this.brnode);

	return true;
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.initProperties = function(event)
{
	this.event  = event;
	this.bqpre  = null;
	this.bqpost = null;
	this.marker = null;
	this.mid    = null;
	this.brnode = document.createTextNode("");
	this.debug  = false;
};

/* ------------------------------------------------------------------ */
/**
 * Append span element with current timestamp as ID to DOM tree.
 * This marks the position, where the KeyPressed-Event has been
 * triggered.
 */
HandleEvent.prototype.setMarker = function()
{
	var curtime = new Date();
	var tmpspan = FCK.EditorDocument.createElement("span");
	this.mid    = curtime.getTime();
	tmpspan.id  = this.mid;
	this.marker = FCK.InsertElementAndGetIt(tmpspan);

	return;
};

/* ------------------------------------------------------------------ */
/**
 * Remove marker node from DOM
 */
HandleEvent.prototype.removeMarker = function()
{
	if (!this.marker || !this.marker.parentNode) {
		return;
	}
	this.marker.parentNode.removeChild(this.marker);
	return;
};

/* ------------------------------------------------------------------ */
/**
 * Checks whether event has occured in a quoted area
 */
HandleEvent.prototype.eventOccurredInQuotedArea = function()
{
	var tmp = this.marker;
	while (tmp && tmp.nodeName.toUpperCase() != "BODY") {
		if (tmp.nodeName.toUpperCase() == "BLOCKQUOTE") {
			return true;
		}
		tmp = tmp.parentNode;
	}

	/* Remove marker */
	this.removeMarker();

	return false;
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.handleKeyEnter = function()
{
	var curnode   = this.marker;
	var initrun   = true;
	var postentry = null;

	/* Traverse tree from marker up to one level beneath body node */
	while (curnode.parentNode.nodeName.toUpperCase() != "BODY") {
		/* Set parent nodes for new blockquotes */
		this.setNewParentOfPreBlock(curnode.parentNode);
		this.setNewParentOfPostBlock(curnode.parentNode);
		/* Collect all siblings for PRE blockquote */
		var sibl = curnode.previousSibling;
		while (sibl) {
			if (sibl.hasChildNodes()) {
				var obj  = this.createObjFromNode(sibl);
				var chld = this.addChildsFromNodeToObj(obj, sibl);
				this.bqpre.insertBefore(chld, this.bqpre.firstChild);
			} else {
				this.addObjToPreBlockReverse(sibl);
			}
			sibl = sibl.previousSibling;
		}
		/* Only on initial loop run */
		if (initrun) {
			initrun = false;
			/* Save entry point to collect nodes for POST blockquote */
			var tmp   = curnode.parentNode;
			postentry = tmp.nextSibling;
			while (postentry == null) {
				tmp = tmp.parentNode;
				if (!tmp) {
					break;
				}
				postentry = tmp.nextSibling;
			}
			/* Collect all next siblings of marker for POST blockquote */
			var sibl = this.marker.nextSibling;
			while (sibl) {
				if (sibl.hasChildNodes()) {
					var obj  = this.createObjFromNode(sibl);
					var chld = this.addChildsFromNodeToObj(obj, sibl);
					this.bqpost.appendChild(chld);
				} else {
					this.addObjToPostBlock(sibl);
				}
				sibl = sibl.nextSibling;
			}
		}
		curnode = curnode.parentNode;
	}

	/* Save parent of current node as old body and define new body node */
	var curbdy = curnode.parentNode;
	var tmpbdy = FCK.EditorDocument.createElement("div");
	if (this.debug) {
		printDomTree(curbdy);
	}

	/* Append all nodes from postentry on to POST blockquote */
	var collectrest = false;	
	while (postentry) {
		/*
		 * If parent of node is body, we're out of respective quoting
		 * block and thus all remaining nodes are ment to be collected
		 * as rest (directly appended to tmpbdy and not to bqpost!)
		 */
		if (postentry.parentNode && postentry.parentNode.nodeName.toUpperCase() == "BODY") {
			collectrest = true;
		}
		if (postentry.hasChildNodes()) {
			var obj  = this.createObjFromNode(postentry);
			var chld = this.addChildsFromNodeToObj(obj, postentry);
			if (collectrest) {
				tmpbdy.appendChild(chld);
			} else {
				this.bqpost.appendChild(chld);
			}
		} else {
			if (collectrest) {
				tmpbdy.appendChild(this.createObjFromNode(postentry));
			} else {
				this.bqpost.appendChild(this.createObjFromNode(postentry));
			}
		}
		postentry = postentry.nextSibling;
	}

	/* Append PRE and POST blocks */
	if (collectrest) {
		tmpbdy.insertBefore(this.bqpost, tmpbdy.firstChild);
		tmpbdy.insertBefore(this.bqpre, tmpbdy.firstChild);
	} else {
		tmpbdy.appendChild(this.bqpre);
		tmpbdy.appendChild(this.bqpost);
	}

	/* Add BR node to get space between bqpre and bqpost blocks */
	tmpbdy.insertBefore(this.brnode, this.bqpost);

	/* Append all nodes previous to node where event has occured to body */
	curnode = curnode.previousSibling;
	while (curnode) {
		if (curnode.hasChildNodes()) {
			var obj  = this.createObjFromNode(curnode);
			var chld = this.addChildsFromNodeToObj(obj, curnode);
			tmpbdy.insertBefore(chld, tmpbdy.firstChild);
		} else {
			tmpbdy.insertBefore(this.createObjFromNode(curnode), tmpbdy.firstChild);
		}
		curnode = curnode.previousSibling;
	}

	/* Remove all childs of current body */
	while (curbdy.firstChild) {
		curbdy.removeChild(curbdy.firstChild);
	}

	/* Append all childs from tmpbdy to curbdy */
	initrun = true;
	for (var i = tmpbdy.childNodes.length - 1; i >= 0; --i) {
		if (initrun) {
			initrun = false;
			curbdy.appendChild(tmpbdy.childNodes[i]);
			continue;
		}
		curbdy.insertBefore(tmpbdy.childNodes[i], curbdy.firstChild);
	}

	if (this.debug) {
		printDomTree(curbdy);
	}

	return;
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.handleKeyBackspace = function()
{
	return true;
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.handleNull = function()
{
	return true;
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.addChildsFromNodeToObj = function(obj, node)
{
	for (var i = 0; i < node.childNodes.length; ++i) {
		var chld = this.createObjFromNode(node.childNodes[i]);
		var tmp  = this.addChildsFromNodeToObj(chld, node.childNodes[i]);
		obj.appendChild(tmp);
	}
	return obj;
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.addObjToPreBlockReverse = function(node)
{
	if (!this.bqpre.firstChild) {
		this.addObjToPreBlock(node);
		return;
	}
	this.bqpre.insertBefore(this.createObjFromNode(node), this.bqpre.firstChild);
	return;
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.addObjToPreBlock = function(node, convert)
{
	this.bqpre.appendChild(this.createObjFromNode(node));
	return;
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.addObjToPostBlock = function(node)
{
	this.bqpost.appendChild(this.createObjFromNode(node));
	return;
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.setNewParentOfPreBlock = function(node)
{
	if (this.bqpre == null) {
		this.bqpre = this.createObjFromNode(node);
		return;
	}
	var obj = this.createObjFromNode(node);
	obj.appendChild(this.bqpre);
	this.bqpre = null;
	this.bqpre = obj;
	return
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.setNewParentOfPostBlock = function(node)
{
	if (this.bqpost == null) {
		this.bqpost = this.createObjFromNode(node);
		return;
	}
	var obj = this.createObjFromNode(node);
	obj.appendChild(this.bqpost);
	this.bqpost = null;
	this.bqpost = obj;
	return
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.createObjFromNode = function(node)
{
	switch (node.nodeType) {
		case 1: /* Element node*/
			return this.createElementFromNode(node);
		case 3: /* Text node*/
			return FCK.EditorDocument.createTextNode(node.nodeValue);
		default: /* TODO: Handle all other nodeTypes */
			break;
	}
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.createElementFromNode = function(node)
{
	try {
		var obj = FCK.EditorDocument.createElement(node.nodeName);
		for (var i = 0; i < node.attributes.length; ++i) {
			var attr = document.createAttribute(node.attributes[i].nodeName);
			attr.value = node.attributes[i].nodeValue;
			obj.setAttributeNode(attr);
		}
		return obj;
	} catch (e) {
		return FCK.EditorDocument.createElement("DIV");
	}
};

/* ------------------------------------------------------------------ */
HandleEvent.prototype.getNewBlockquote = function(node)
{
	var bq = FCK.EditorDocument.createElement("blockquote");
	var ct = FCK.EditorDocument.createAttribute("type", "cite");
	bq.setAttributeNode(ct);
	return bq;
};

/* ------------------------------------------------------------------ */
function xdebug(obj)
{
	try {
		var str = '';
		var tmp = null;
		for (tmp in obj) {
			str += tmp + ": " + obj[tmp] + "\n";
		}
		if (FCKConfig.Debug == true) {
			FCKDebug.Output(str);
		} else {
			alert(str);
		}
	} catch (e) {
		if (FCKConfig.Debug == true) {
			FCKDebug.Output(obj + ": Cannot handle given object!\n" + e);
		} else {
			alert(obj + ": Cannot handle given object!\n" + e);
		}
	}
	return;
};

/* ------------------------------------------------------------------ */
/** 
 * Traverses dom tree
 *
 * @param	target		target document object to direct output to
 * @param	curnode		Node to start traversing with
 * @param	depth		Number of level
 */
function traverseDomTree(target, curnode, depth)
{
	if (!curnode) {
		return;
	}

	/* Print node tagName */
	if (curnode.tagName) {
		target.writeln("&lt;" + curnode.tagName + "&gt;");
	} else {
		target.writeln(curnode.nodeValue);
	}

	/* Traverse the tree */
	for (var i = 0; i < curnode.childNodes.length; ++i) {
		printTreeHelpLines(target, depth, curnode.childNodes[i]);
		printTreeHelpLines(target, depth, curnode.childNodes[i]);
		target.write("`-&nbsp;");

		/* Recursively traverse the tree structure of the child node */
		traverseDomTree(target, curnode.childNodes[i], depth + 1);
	}

	return;
};

/* ------------------------------------------------------------------ */
/**
 * Prints linebreak and vertical lines depending on given number 
 *
 * @param	target		target document object to direct output to
 * @param	num			Number of lines to print
 */
function printTreeHelpLines(target, num, node, help)
{
	var ln = "";
	var vl = "";
	target.write("<br />\n");
	while (num-- > 0) {
		var vl = node.nextSibling ? "&#166;" : "&nbsp;";
		var ln = "&nbsp;&nbsp;" + vl + ln;
		var node = node.parentNode;
	}								
	target.write(ln);

	return;
};

/* ------------------------------------------------------------------ */
/**
 * Prints dom tree.
 *
 * @param	node		Node to start printing tree
 * @param	dest		Optional destination object to direct output to.
 *                      If no object is given, a new window will be
 *                      created.
 */
function printDomTree(node, dest)
{
	if (!dest) {
		var dest = window.open();
	}

	dest.document.open("text/html", "replace");
	dest.document.writeln("<html>");
	dest.document.writeln("<head>");
	dest.document.writeln("<title>DOM-Tree</title>");
	dest.document.writeln("<body>");
	dest.document.writeln("<code>");
	traverseDomTree(dest.document, node, 1);
	dest.document.writeln("</code>");
	dest.document.writeln("</body>");
	dest.document.writeln("</html>");

	/* Close to document or Gecko-based browsers are loading forever! */
	dest.document.close();

	return;
};

/* ------------------------------------------------------------------ */
var gmxIE_OnKeyDown = function()
{
	var e      = FCK.EditorWindow.event;
	var called = false;

	if (e.keyCode == 13 && !e.shiftKey && !e.ctrlKey && !e.altKey) {
		if (called == false) {
			gmxHandleEventInQuotedArea(e);
			called = true;
		}
	}
	return true;
};

/* ------------------------------------------------------------------ */
var gmxGecko_OnKeyDown = function(e)
{
	var called = false;

	if (e.which == 13 && !e.shiftKey && !e.ctrlKey && !e.altKey) {
		if (called == false) {
			gmxHandleEventInQuotedArea(e);
			called = true;
		}
	}
	return true;
};

/* ------------------------------------------------------------------ */
if (document.all) { /* IE */
	FCK.EditorDocument.attachEvent("onkeypress", gmxIE_OnKeyDown);
} else { /* Gecko */
	FCK.EditorDocument.addEventListener("keypress", gmxGecko_OnKeyDown, true);
}
/* ================================ EOF ============================== */
