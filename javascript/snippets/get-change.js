function getChange(moneyGiven, itemProvided) {
    var denominations = [1, 5, 10, 25, 50, 100];
    var changeOwed = (moneyGiven - itemProvided) * 100;
    if (changeOwed <= 0) return [0, 0, 0, 0, 0, 0];

    return denominations.reduceRight((_change, denomination) => {
        var changeToBeReturned = Math.floor(changeOwed / denomination);
        changeOwed -= changeToBeReturned * 100;
        return [changeToBeReturned].concat(_change);
    }, []);
}

getChange(5, 0.99);
