/* FCKCommands.RegisterCommand(commandName, command)
   commandName - Command name, referenced by the Toolbar, etc...
   command - Command object (must provide an Execute() function).
 */
FCKCommands.RegisterCommand( 'AddImage', new AddImage() ) ;

// Create the toolbar button
var oSwitchItem = new FCKToolbarButton('AddImage', 'Bild einfügen/editieren') ;
oSwitchItem.IconPath = FCKConfig.SkinPath + 'toolbar/image.gif' ;
FCKToolbarItems.RegisterItem( 'AddImage', oSwitchItem ) ;

// SwitchToolbar Object
function AddImage() { 
    // initialize debug window
    FCKDebug.Output('initialize SaveMail');
}

AddImage.prototype.Execute = function()
{
    parent.addImage();
    return FCK_TRISTATE_OFF ;
}

AddImage.prototype.GetState = function()
{
    return FCK_TRISTATE_OFF ;
}

