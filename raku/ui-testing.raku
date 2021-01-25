use IUP;

my @argv = ("Test");

#
# initialize iup
#

my $iup = IUP.new();

$iup.image_lib_open();
$iup.open(@argv);

#
# create widgets and set their attributes
#

my $btn = $iup.button("&Ok", "");

$btn.set_callback("ACTION", &exit_callback);

$btn.set_attribute("IMAGE", "IUP_ActionOk");
$btn.set_attribute("EXPAND", "YES");
$btn.set_attribute("TIP", "Exit button");

my $lbl = $iup.label("Hello, world!");

my $vb = $iup.vbox($lbl, $btn);
$vb.set_attribute("MARGIN", "10x10");
$vb.set_attribute("GAP", "10");
$vb.set_attribute("ALIGNMENT", "ACENTER");

my $dlg = $iup.dialog($vb);
$dlg.set_attribute("TITLE", "Hello");

#
# Map widgets and show dialog
#

$dlg.show();

#
# Wait for user interaction
#

$iup.main_loop();

#
# Clean up
#

$dlg.destroy();
$iup.close();

exit();

sub exit_callback() returns Int {
    return IUP_CLOSE;
}
