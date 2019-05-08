var sample = {
    "client": [{
        "key": "Martina A Cerutie-McBride",
        "value": 1851639.5700000003
    }, {
        "key": "WHOAAA TEST Whoa So Test1",
        "value": 6160622.5475699995
    }, {
        "key": "Naters G Smith",
        "value": 474349.3
    }, {
        "key": "Newer Contact",
        "value": 50000
    }, {
        "key": "Vanner Johnson",
        "value": 1533.39
    }, {
        "key": "Joe First Me",
        "value": 1729494.04919
    }, {
        "key": "testone one",
        "value": 524349.3
    }, {
        "key": "testtwo two",
        "value": 56589.2
    }, {
        "key": "testthree three",
        "value": 300000
    }, {
        "key": "testfour four",
        "value": 100000
    }, {
        "key": "this works",
        "value": 524349.3
    }, {
        "key": "TestF TestL",
        "value": 68332.75
    }, {
        "key": "Sam Smith",
        "value": 66847.12
    }, {
        "key": "Lee's SuperAccount",
        "value": 2329494.0491899997
    }, {
        "key": "Charles Chong",
        "value": 1071822.68
    }],
    "prospect": [{
        "key": "Jack Harrigan",
        "value": 5439981
    }, {
        "key": "TESTS ETSESETS",
        "value": 347732.45999999996
    }, {
        "key": "113Wei 1135Han",
        "value": 34783.12
    }],
    "timeIntervalStart": "2018-08-30T00:00:00.000Z",
    "timeIntervalEnd": "2018-08-31T00:00:00.000Z"
};

var multipleSamples = [Object.assign({}, sample), Object.assign({}, sample), Object.assign({}, sample)];

var formatSample = (previousValue, sampleToFormat) => {
    if (!previousValue) previousValue = {};
    const newSample = {};
    const newKey = new Date(sampleToFormat.timeIntervalStart).getTime();
    const allOtherProps = Object.keys(sampleToFormat).filter(propName=>!/timeInterval(Start|End)/.test(propName));

    allOtherProps.forEach(propName => {
        if (!sampleToFormat[propName] || !sampleToFormat[propName].length <= 0)
            newSample[propName] = [];
        newSample[propName] = sampleToFormat[propName].map(keyValuePair => keyValuePair.value);
    }
    );

    previousValue[newKey] = newSample;
    return previousValue;
};

multipleSamples.reduce(formatSample, {});
