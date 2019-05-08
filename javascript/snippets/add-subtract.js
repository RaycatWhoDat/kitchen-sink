function addSubtract(prevNumber) {
    console.log(arguments);
    //if (this.arguments <= 1) return;
    return nextNumber => {
        let _prevNumber = prevNumber || 0;
        let _nextNumber = nextNumber || 0;
        let newTotal = _prevNumber + _nextNumber;
        return nextNumber ? addSubtract(newTotal) : addSubtract(newTotal)();
    }
}

addSubtract(1)(2)(3)(4)(5)
