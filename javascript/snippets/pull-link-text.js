var testCase1 = 'test <a>with a link</a> and more';
var testCase2 = 'test <a class="link">with a link</a> and more';
var testCase3 = 'test <a class="link">with a link</a> and <a class="link">another link</a>';
var testCase4 = 'test <span>with a link</span> and more';
var testCase5 = 'test <div class="link fa fa-lg">with a link</div> and more';
var testCase6 = 'test <div class="link">with a link</div> and <a class="link">another link</a>';

var linkExtractor = /<(\w+)\ ?(?:class\="([a-zA-Z\ \-]+)")?>([a-zA-Z\ ]+)<\/(\w+)>/;

var matches = testCase5.matchAll(linkExtractor);

for (match of matches) {
    const [_, openingTag, classes, text, closingTag] = match;
    console.log(openingTag, classes, text, closingTag);    
}
