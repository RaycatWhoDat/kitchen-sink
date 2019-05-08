var testCase1 = "This is a test.";
var testCase2 = "This is <% message %> and this is <% message2 %>.";
var testCase3 = "<% messages %>";
var testCase4 = "<%= for (message in messages) { return message; } %>";

var options = {
    message: 'a test',
    message2: 'another test',
    messages: [
        'yet',
        'another',
        'test'
    ]
};

var evaluateTemplate = (template, options) => {
    var keywords = ['for'];
    var keywordsRegex = new RegExp(keywords.join('|'));
    var templateRegex = /\w*(<%=?[^%]*%>)\w*/g;

    var parsedTemplate = template
        .split(templateRegex)
        .map(_fragment => {
            if (_fragment[0] !== '<') return _fragment;
            var currentMode = _fragment[2] === '='
                ? 'EVALUATE'
                : 'INTERPOLATE';
            var fragment = _fragment.replace(/[<%=>]/g, '').trim();
            if (keywordsRegex.test(fragment)) return fragment;
            return options ? options[fragment] : undefined;
        });

    var evaluatedTemplate = parsedTemplate.reduce((_evaluatedTemplate, fragment) => {
        _evaluatedTemplate += `r.push('${fragment}');`;
        return _evaluatedTemplate;
    }, 'var r = [];');

    return new Function(evaluatedTemplate + "return r.join('');");
};

evaluateTemplate(testCase3, options)();



