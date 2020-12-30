package;

import DiscordJs;
import Config;


class TestApp {
  public static function main() {
    var client = new DiscordJs.Client();
    var config = Config.load();
    
    client.once(EventType.Ready, () -> {
      trace(client.user.tag);
      for (guild in client.guilds) trace(guild.name);
    });

    client.on(EventType.Message, (message) -> {
      var parsedCommand = message.content.split(config.prefix)[1];
      switch (parsedCommand) {
      case "ping": message.channel.send("pong");
      case _: 
      }
    });

    client.login(config.token);
  }
}
