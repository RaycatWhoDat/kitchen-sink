package love.event;
@:enum
abstract Event (String)
{
	var Focus = "focus";
	var Joystickaxis = "joystickaxis";
	var Joystickhat = "joystickhat";
	var Joystickpressed = "joystickpressed";
	var Joystickreleased = "joystickreleased";
	var Keypressed = "keypressed";
	var Keyreleased = "keyreleased";
	var Mousefocus = "mousefocus";
	var Mousepressed = "mousepressed";
	var Mousereleased = "mousereleased";
	var Resize = "resize";
	var Threaderror = "threaderror";
	var Quit = "quit";
	var Visible = "visible";
}