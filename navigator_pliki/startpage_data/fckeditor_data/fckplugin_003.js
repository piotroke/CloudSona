/* FCKCommands.RegisterCommand(commandName, command)
   commandName - Command name, referenced by the Toolbar, etc...
   command - Command object (must provide an Execute() function).
 */
FCKCommands.RegisterCommand( 'InsertLink', new InsertLink() ) ;

// Create the toolbar button
var oSwitchItem = new FCKToolbarButton('InsertLink', 'Link einfügen') ;
oSwitchItem.IconPath = FCKConfig.SkinPath + 'toolbar/link.gif' ;
FCKToolbarItems.RegisterItem( 'InsertLink', oSwitchItem ) ;

// SwitchToolbar Object
function InsertLink() { 
    // initialize debug window
    FCKDebug.Output('initialize InsertLink');
}

InsertLink.prototype.Execute = function()
{
    parent.addLink();
    return FCK_TRISTATE_OFF ;
}

InsertLink.prototype.GetState = function()
{
    return FCK_TRISTATE_OFF ;
}

