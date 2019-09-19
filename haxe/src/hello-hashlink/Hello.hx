package;

class Hello extends hxd.App {
    override function init() {
        var message = new h2d.Text(hxd.res.DefaultFont.get(), s2d);
        message.text = "Hello, HashLink!";
        message.x = 10;
        message.y = 10;
    }
    
    static function main() {
        new Hello();
    }
}

// Local Variables:
// compile-command: "cd ../.. && haxe HelloHashlink.hxml"
// End:
