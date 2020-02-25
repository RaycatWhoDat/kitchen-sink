package;

using StringTools;

enum XmlDocument {
  Tag(name: String, ?attributes: Map<String, Dynamic>, ?children: Array<XmlDocument>);
}

class XmlGenerator {
  public static function parseTree(tree: Array<XmlDocument>): String {
    var fragments = [
      for (node in tree) {
        switch (node) {
          case Tag(name, attributes, children):
            var attributes = [
              for (attributeName => attributeValue in attributes)
                ' ${attributeName}="${attributeValue}"'
            ];
            '<${name}${attributes.join(" ")}>${(children == null || children.length == 0) ? '' : XmlGenerator.parseTree(children)}</${name}>';
        }
      }
    ];

    return fragments.join("");
  }

  public static function main() {
    var testCase = Tag("html", ["class" => "app"], [
      Tag("head", []),
      Tag("body", ["class" => "app"], [Tag("div", ["class" => "container"])])
    ]);

    trace(XmlGenerator.parseTree([testCase]));
  }
}
