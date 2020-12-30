package;

enum abstract EventType(String) {
  var Ready = "ready";
  var Message = "message";
}

typedef Token = String;

typedef ClientOptions = js.lib.Object;

typedef User = {
  var tag: String;
  var bot: Bool;
};

typedef Channel = {
  function send(message: String): Void;
};

typedef DiscordMessage = {
  var content: String;
  var author: User;
  var channel: Channel;
};

typedef Guild = {
  var id: String;
  var name: String;
};

extern class DiscordJs {
  @:overload(function (): Client {})
  static function Client(options: ClientOptions): Client;
}

@:jsRequire("discord.js", "Client")
extern class Client {
  public function new();

  public var user: User;
  public var guilds: Array<Guild>;

  @:overload(function (eventType: EventType, callback: DiscordMessage -> Void): Void {})
  public function on(eventType: EventType, callback: () -> Void): Void;

  public function once(eventType: EventType, callback: () -> Void): Void;
  public function login(token: Token): Void;
}
