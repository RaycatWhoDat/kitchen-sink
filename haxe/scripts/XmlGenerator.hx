package;

enum XmlTree {
  Tag(name: String, ?attributes: Map<String, Dynamic>, ?children:Array<XmlTree>);
}

class XmlGenerator {
  public static function parseTree(tree: Array<XmlTree>, document: String = ""): String {
    switch (tree[0]) {
      case Tag(name, attributes, children):
        var openingTag = '<${name}';

        for (attributeName => attributeValue in attributes) {
          openingTag += ' ${attributeName}="${attributeValue}"';
        };

        openingTag += ">";
        
        var closingTag = '</${name}>';
        document = '${openingTag}${document}${closingTag}';

        if (children == null || children.length == 0) return document;
        return XmlGenerator.parseTree(children, document);
    }
  }
  
  public static function main() {
    // BUG: It creates the tree backwards.
    var testCase = Tag("html", ["class" => "app"], [
        Tag("body", ["class" => "app"], [
            Tag("div", ["class" => "container"])
                                         ])
                                                    ]);
    
    trace(XmlGenerator.parseTree([testCase]));
  }
}