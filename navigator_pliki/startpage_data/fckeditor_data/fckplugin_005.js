/* FCKCommands.RegisterCommand(commandName, command)
   commandName - Command name, referenced by the Toolbar, etc...
   command - Command object (must provide an Execute() function).
 */
FCKCommands.RegisterCommand( 'SaveMail', new SaveMail() ) ;

// Create the toolbar button
var oSwitchItem = new FCKToolbarButton('SaveMail', 'In Entwürfe speichern') ;
oSwitchItem.IconPath = FCKConfig.SkinPath + 'toolbar/save.gif' ;
FCKToolbarItems.RegisterItem( 'SaveMail', oSwitchItem ) ;

// SwitchToolbar Object
function SaveMail() { 
    // initialize debug window
    FCKDebug.Output('initialize SaveMail');
}

SaveMail.prototype.Execute = function()
{
    top.saveMail();
    return FCK_TRISTATE_OFF ;
}

SaveMail.prototype.GetState = function()
{
    return FCK_TRISTATE_OFF ;
}

