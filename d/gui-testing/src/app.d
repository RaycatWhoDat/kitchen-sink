import gtk.MainWindow;
import gtk.Label;
import gtk.Main;
import gtk.Button;

void main(string[] args)
{
  Main.init(args);

  MainWindow win = new MainWindow("Hello World");
  win.setDefaultSize(200, 100);

  Button quitButton = new Button("Quit");
  quitButton.addOnClicked(delegate void(Button button) { Main.quit(); });
  win.add(quitButton);
  
  win.showAll();

  Main.run();
}
