var historyOver30Days = JSON.parse(JSON.stringify(mockInvestmentHistory.day.slice(0, 30)));

historyOver30Days.map(dayRecord => {
    const currentDate = new Date(dayRecord.timeIntervalStart);
    dayRecord.accountBalance = dayRecord.accountDetails.reduce((totalBalance, accountDetails) => totalBalance += accountDetails.balance, 0);
    dayRecord.startDate = {
        Y: currentDate.getFullYear(),
        M: currentDate.getMonth(),
        D: currentDate.getDate()
    };

    delete dayRecord.accountDetails;
    return dayRecord;
}).reverse();
