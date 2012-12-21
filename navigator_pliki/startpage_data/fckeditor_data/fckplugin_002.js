/* FCKCommands.RegisterCommand(commandName, command)
   commandName - Command name, referenced by the Toolbar, etc...
   command - Command object (must provide an Execute() function).
 */
FCKCommands.RegisterCommand( 'AddSmiley', new AddSmiley() ) ;

// Create the toolbar button
var oSwitchItem = new FCKToolbarButton('AddSmiley', 'Smiley einfügen') ;
oSwitchItem.IconPath = FCKConfig.SkinPath + 'toolbar/smiley.gif' ;
FCKToolbarItems.RegisterItem( 'AddSmiley', oSwitchItem ) ;

function AddSmiley() { 
    // initialize debug window
    FCKDebug.Output('initialize AddSmiley');
}

AddSmiley.prototype.Execute = function()
{
    parent.addSmiley();
    return FCK_TRISTATE_OFF ;
}

AddSmiley.prototype.GetState = function()
{
    return FCK_TRISTATE_OFF ;
}

