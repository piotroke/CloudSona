/*
 * Folder Menu
 *
 */

// Do we need to provide iframes?
var iframeCover = document.all && !window.opera && navigator.appName == 'Microsoft Internet Explorer' && navigator.appVersion.search(/MSIE 7\.0/) == -1;

// Wrapper for foldunfoldMenu
//
function unfoldMenu(node, msec) {
	foldunfoldMenu(node, msec, 'block');
	return false;
}

// Wrapper for foldunfoldMenu
//
function foldMenu(node, msec) {
	foldunfoldMenu(node, msec, 'none');
	return false;
}

// Displays submenu triggered by mouseover/mouseout event
//
function foldunfoldMenu(node, msec, type) {
	var sub  = getSubMenu(node);
	if (!sub || sub.style.display == type) {
		return false;
	}
	// flickering opera
	if (!window.opera)
		delay(msec);

	sub.style.display = type;

	if (type == 'block') {
		node.getElementsByTagName("a")[0].style.backgroundColor = '#EAF1F8';
	} else {
		node.getElementsByTagName("a")[0].style.backgroundColor = 'transparent';
	}
	if (iframeCover) {
		if (type == 'block') {
			addIframe(sub);
			sub.style.borderRight  = 'none';
			sub.style.borderBottom = 'none';
			sub.lastChild.style.borderBottom = 'solid 1px #1C449B';

		} else {
			removeIframe(sub);
			sub.style.borderRight = 'solid 1px #1C449B';
			sub.style.borderBottom = 'solid 1px #1C449B';
		}
	}
	return false;
}

// Gets subnode of type UL for given node
//
function getSubMenu(node) {
	var subNode = node.firstChild;
	while (subNode) {
		if (subNode.nodeName.toUpperCase() == 'UL') {
			return subNode;
		}
		subNode = subNode.nextSibling;
	}
	return null;
}
// Removes iframe node from given node
//
function removeIframe(node) {
	var subNode = node.firstChild;
	while (subNode) {
		if (subNode.nodeName.toUpperCase() == 'IFRAME') {
			node.removeChild(subNode);
			return true;
		}
		subNode = subNode.nextSibling;
	}
	return false;
}

// Delay execution for given milliseconds
//
function delay(msec) {
	var wait = parseInt(msec);
	var max  = 10000;
	if (wait == 'NaN' || wait < 0) {
		return false;
	}
	if (wait > max) {
		wait = max;
	}
	var start = new Date();
	var now   = new Date();;
	while (now.getTime() - wait < start.getTime()) {
		now = new Date();
	}
	return false;
}

// Adds Iframe as firstChild to given node
//
function addIframe(node) {
	var height = node.childNodes.length * 18 + node.childNodes.length;
	var iframe = document.createElement('iframe');
	iframe.height = height;
	iframe.frameBorder = 0;
	iframe.src = $("base").attr("href") + '0.gif';
	iframe.scrolling = 'no';
	iframe.style.marginBottom = '-' + height + 'px';
	iframe.width = '101%';
	node.insertBefore(iframe, node.firstChild);
	return true;
}
