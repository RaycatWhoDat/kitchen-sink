/*
  Finance.js (now with more TypeScript). 

  For more information on the original implementation, visit:
  `http://financejs.org`. 

  Copyright 2014 - 2015 Essam Al Joubori, MIT license. Refactored by
  Ray Perry, 2019.

  Note regarding BigInts: I was thinking about adding support for
  them but I realized that it would require reworking the whole
  library. On top of that, the loss of precision with unknowing users
  throwing BigInts into libraries that don't use them would be a bit
  troublesome. So, I've opted to leave them out.
*/

enum ValueType {
    PRESENT = 'present',
    FUTURE = 'future'
}

enum AmortizationType {
    YEAR = 0,
    MONTH = 1
}

const YEAR_IN_MILLIS = 1000 * 3600 * 24 * 365;

const ERROR_DEFAULT_LIMIT_PASSED = '[limitIterations] has stopped a looping function.';
const ERROR_IRR_MISSING_SIGNUM = '[Internal Rate of Return] requires at least one positive value and at least one negative value.';
const ERROR_IRR_BEYOND_LIMIT = '[Internal Rate of Return] could not find a result.';
const ERROR_PP_NO_NUMBER_OF_PERIODS = '[Payback Period] requires a number of periods to calculate.';
const ERROR_AM_NO_YEAR_OR_MONTH = '[Amortization] needs to know whether to calculate in years or months. For help on usage, visit: http://financejs.org.'
const ERROR_XIRR_MISMATCHING_DATASETS = '[Irregular Internal Rate of Return] requires the number of cash flows be the same as the number of dates provided.';
const ERROR_XIRR_MISSING_SIGNUM = '[Irregular Internal Rate of Return] requires at least one positive value and at least one negative value.';
const WARN_XIRR_MISMATCHED_GUESS = '[Irregular Internal Rate of Return] did not have a matching guess.';

const roundResult = (result: number, multiple: number = 100, divisor: number = 100): number => Math.round(result * multiple) / divisor;

// Any similar implementations will be combined into one (as needed).
const calculateCashFlowValue = (valueType: ValueType) => (rate: number, cashFlow: number, numberOfPeriods?: number): number => {
    if (!numberOfPeriods) numberOfPeriods = 1;

    const formattedRate = rate / 100;
    const intermediateValue = valueType === ValueType.PRESENT
        ? cashFlow / Math.pow(1 + formattedRate, numberOfPeriods)
        : cashFlow * Math.pow(1 + formattedRate, numberOfPeriods);

    return roundResult(intermediateValue);
};

// I don't really understand this function since it seems like you could be caught in an infinite loop.
// EDIT: This function tries to get as close as it can but the function being called MUST terminated itself.
const seekZero = (fn: Function): number => {
    let target = 1;
    while (fn(target) > 0) {
        target += 1;
    }
    while (fn(target) < 0) {
        target -= 0.01;
    }
    return target + 0.01;
};

// To address the above problem, I've made this function:
const limitIterations = (fn: Function, iterationLimit: number, errorMessage: string = ERROR_DEFAULT_LIMIT_PASSED) => {
    let numberOfIterations = 1;
    return (...args: any[]) => {
        numberOfIterations++;
        if (numberOfIterations > iterationLimit) {
            console.info('Last iteration: ', args);
            throw new Error(errorMessage);
        }
        return fn.apply(null, args);
    };
};

const sumEq = (cashFlows: number[], durations: number[], guess: number) => {
    const sumFx = cashFlows.reduce((_sumFx: number, cashFlow, index) => {
        const newNumber = (cashFlow / Math.pow(1 + guess, -1 - (durations[index] || 0)));
        // Polyfill NaN check.
        _sumFx += newNumber !== newNumber ? 0 : newNumber;
        return _sumFx;
    }, 0);

    const sumFdx = cashFlows.reduce((_sumFdx: number, cashFlow, index) => {
        const newNumber = (-cashFlow * (durations[index] || 0) * Math.pow(1 + guess, -1 - (durations[index] || 0)));
        _sumFdx += newNumber !== newNumber ? 0 : newNumber;
        return _sumFdx;
    }, 0);

    return sumFx / sumFdx;
}

const durationInYears = (date1: Date, date2: Date): number => (Math.abs(date2.getTime() - date1.getTime())) / YEAR_IN_MILLIS;

/**
 *  Present Value (PV)
 *
 *  @param rate
 *  @param cashFlow
 *  @param numberOfPeriods
 *
 *  @returns The current worth of a future sum of money or stream of
 *  cash flows, given a specified rate of return.
 */
export const presentValue = calculateCashFlowValue(ValueType.PRESENT);

/**
 *  Future Value (FV)
 *  
 *  @param rate
 *  @param cashFlow
 *  @param numberOfPeriods
 *
 *  @returns The current worth of a future sum of money or stream of
 *  cash flows, given a specified rate of return.
 */
export const futureValue = calculateCashFlowValue(ValueType.FUTURE);

/**
 *  Net Present Value (NPV)
 *
 *  @remarks It's based on the principal of time value of money (TVM),
 *  which explains how time affects monetary value.
 *
 *  @param rate
 *  @param initialInvestment
 *  @param cashFlows
 *
 *  @returns A comparison of the money received in the future to an
 *  amount of money received today, while accounting for time and
 *  interest [through the discount rate].
 */
export const netPresentValue = (rate: number, initialInvestment: number, ...cashFlows: number[]): number => {
    const formattedRate = rate / 100;

    const netPresentValue = cashFlows
        .reduce((_netPresentValue, cashFlow, index) => _netPresentValue += cashFlow / Math.pow(1 + formattedRate, index + 1), initialInvestment);
    return roundResult(netPresentValue);
};

/**
 *  Internal Rate of Return (IRR)
 *
 *  @param initialInvestment
 *  @param cashFlows
 *
 *  @returns The discount rate often used in capital budgeting that
 *  makes the net present value of all cash flows from a particular
 *  project equal to zero.
 */
export const internalRateOfReturn = (initialInvestment: number, ...cashFlows: number[]): number => {
    let hasPositiveValue = false;
    let hasNegativeValue = false;

    const allCashValues = [initialInvestment].concat(cashFlows);

    allCashValues.forEach(cashValue => {
        if (cashValue > 0) hasPositiveValue = true;
        if (cashValue < 0) hasNegativeValue = true;
    });

    if (!hasPositiveValue || !hasNegativeValue) throw new Error(ERROR_IRR_MISSING_SIGNUM);

    // Tried to reuse the previous definition using `.bind` but I couldn't manage. Moving on for now.
    // DONE: Come back and figure out why `.bind` wouldn't work.
    // EDIT: It's good that I didn't. This function needs to not round.
    // EDIT 2: This function signature is a bit funky but it allows `seekZero` to do its work.
    const _netPresentValue = (initialInvestment: number, ...cashFlows: number[]) => (rate: number): number => {
        const formattedRate = (1 + rate / 100);
        return cashFlows
            .reduce((_netPresentValue, cashFlow, index) => _netPresentValue += cashFlow / Math.pow(formattedRate, index + 1), initialInvestment);
    };

    const limitedNPV = limitIterations(_netPresentValue(initialInvestment, ...cashFlows), 10000, ERROR_IRR_BEYOND_LIMIT);

    return roundResult(seekZero(limitedNPV));
};

/**
 *  Payback Period (PP)
 *  
 *  @param numberOfPeriods
 *  @param cashFlows
 *
 *  @returns The length of time required to recover the cost of an
 *  investment.
 */
export const paybackPeriod = (numberOfPeriods: number, ...cashFlows: number[]): number => {
    if (numberOfPeriods == null) throw new Error(ERROR_PP_NO_NUMBER_OF_PERIODS);
    if (numberOfPeriods === 0) return Math.abs(cashFlows[0]) / cashFlows[1];

    let [cumulativeCashFlow, ...otherCashFlows] = cashFlows;
    let numberOfYears = 1;
    otherCashFlows.forEach(cashFlow => {
        if (cumulativeCashFlow > 0) return;
        cumulativeCashFlow += cashFlow;
        numberOfYears += (cumulativeCashFlow > 0) ? (cumulativeCashFlow - cashFlow) / cashFlow : 1;
    });
    return numberOfYears;
};

/**
 *  Return on Investment (ROI)
 *
 *  @param initialInvestment
 *  @param earnings
 *
 *  @returns A simple calculation that tells you the bottom line
 *  return of any investment.
 */
export const returnOnInvestment = (initialInvestment: number, earnings: number): number => {
    const _returnOnInvestment = (earnings - Math.abs(initialInvestment)) / Math.abs(initialInvestment) * 100;
    return roundResult(_returnOnInvestment);
};

/**
 *  Amortization (AM)
 *
 *  @param principal
 *  @param rate
 *  @param period
 *  @param yearOrMonth
 *  @param payAtBeginning
 *
 *  @returns The paying off of debt with a fixed repayment schedule in regular installments over a period of time
 */
export const amortization = (principal: number, rate: number, period: number, yearOrMonth: AmortizationType, payAtBeginning?: boolean): number => {
    const ratePerPeriod = rate / 12 / 100;
    let numerator;
    let denominator;

    const buildNumerator = (numberOfInterestAccruals: number) => ratePerPeriod * Math.pow((1 + ratePerPeriod), payAtBeginning ? numberOfInterestAccruals - 1 : numberOfInterestAccruals);
    const buildDenominator = (numberOfInterestAccruals: number) => Math.pow((1 + ratePerPeriod), numberOfInterestAccruals) - 1;

    if (yearOrMonth === AmortizationType.YEAR) {
        numerator = buildNumerator(period * 12);
        denominator = buildDenominator(period * 12);
    }

    if (yearOrMonth === AmortizationType.MONTH) {
        numerator = buildNumerator(period)
        denominator = buildDenominator(period);
    }

    if (!numerator || !denominator) throw new Error(ERROR_AM_NO_YEAR_OR_MONTH);

    const _amortization = principal * (numerator / denominator);
    return roundResult(_amortization);
};

/**
 *  Profitability Index (PI)
 *  
 *  @param rate
 *  @param initialInvestment
 *  @param cashFlows
 *
 *  @returns An index that attempts to identify the relationship
 *  between the costs and benefits of a proposed project through the
 *  use of a ratio calculated.
 */
export const profitabilityIndex = (rate: number, initialInvestment: number, ...cashFlows: number[]): number => {
    const totalOfProfitabilityValues = cashFlows
        .reduce((_totalOfProfitabilityValues: number, cashFlow, index) => {
            const discountFactor = 1 / Math.pow(1 + rate / 100, index + 1);
            return _totalOfProfitabilityValues += cashFlow * discountFactor;
        }, 0)

    const _profitabilityIndex = totalOfProfitabilityValues / Math.abs(initialInvestment);
    return roundResult(_profitabilityIndex);
};

/**
 *  Discount Factor (DF)
 *
 *  @param rate
 *  @param numberOfPeriods
 *
 *  @returns The factor by which a future cash flow must be multiplied
 *  in order to obtain the present value.
 */
export const discountFactor = (rate: number, numberOfPeriods: number): number | number[] => {
    const allDiscountFactors = [];
    for (let index = 1; index < numberOfPeriods; index++) {
        const discountFactor = 1 / Math.pow(1 + rate / 100, index - 1);
        const roundedDiscountFactor = Math.ceil(discountFactor * 1000) / 1000;
        allDiscountFactors.push(roundedDiscountFactor);
    }
    return allDiscountFactors.length === 1 ? allDiscountFactors[0] : allDiscountFactors;
};

/**
 *  Compound Interest (CI)
 *
 *  @param rate
 *  @param numberOfCompoundings
 *  @param principal
 *  @param numberOfPeriods
 *
 *  @returns The interest calculated on the initial principal and also
 *  on the accumulated interest of previous periods of a deposit or
 *  loan.
 */
export const compoundInterest = (rate: number, numberOfCompoundings: number, principal: number, numberOfPeriods: number): number => {
    const _compoundInterest = principal * Math.pow(1 + rate / 100 / numberOfCompoundings, numberOfCompoundings * numberOfPeriods);
    return roundResult(_compoundInterest);
};

/**
 *  Compound Annual Growth Rate (CAGR)
 *
 *  @param beginningValue
 *  @param endingValue
 *  @param numberOfPeriods
 *
 *  @returns The year-over-year growth rate of an investment over a
 *  specified period of time.
 */
export const compoundAnnualGrowthRate = (beginningValue: number, endingValue: number, numberOfPeriods: number): number => {
    const _compoundAnnualGrowthRate = Math.pow(endingValue / beginningValue, 1 / numberOfPeriods) - 1;
    return roundResult(_compoundAnnualGrowthRate, 10000);
};

/**
 *  Leverage Ratio (LR)
 *
 *  @remarks
 *  TODO: See if division by zero is really acceptable here.
 *
 *  @param totalLiabilities
 *  @param totalDebts
 *  @param totalIncome
 *
 *  @returns The financial leverage of a company or individual to get
 *  an idea of the methods of financing or to measure ability to meet
 *  financial obligations.
 */
export const leverageRatio = (totalLiabilities: number, totalDebts: number, totalIncome: number): number => (totalLiabilities + totalDebts) / totalIncome;

/**
 *  Rule of 72 (R72)
 *
 *  @remarks
 *  A rule stating that in order to find the number of years
 *  required to double your money at a given interest rate, you divide
 *  the compound return into 72.
 *
 *  @param rate
 *
 *  @returns 72 / rate
 */
export const ruleOf72 = (rate: number): number => 72 / rate;

/**
 *  Weighted Average Cost of Capital (WACC)
 *
 *  @param equityMarketValue
 *  @param debtMarketValue
 *  @param equityCost
 *  @param debtCost
 *  @param taxRate
 *
 *  @returns The rate that a company is expected to pay on average to
 *  all its security holders to finance its assets.
 */
export const weightedAverageCostOfCapital = (equityMarketValue: number, debtMarketValue: number, equityCost: number, debtCost: number, taxRate: number) => {
    /* 
       I'm not a fan of less-than-three-letter variable names but the
       original author has the right idea. This formula gets gnarly
       with long names.
    */
    const E = equityMarketValue;
    const D = debtMarketValue;
    const V = E + D;
    const Re = equityCost;
    const Rd = debtCost;
    const T = taxRate;

    const _weightedAverageCostOfCapital = ((E / V) * Re / 100) + (((D / V) * Rd / 100) * (1 - T / 100));
    return roundResult(_weightedAverageCostOfCapital, 1000, 10);
};

/**
 *  Loan Payment Per Period (PMT)
 * 
 *  @param rate
 *  @param numberOfPayments
 *  @param principal
 *
 *  @returns Payment amount for a loan based on constant payments and
 *  a constant interest rate.
 */
export const loanPaymentPerPeriod = (rate: number, numberOfPayments: number, principal: number) => {
    const formattedRate = rate / 100;
    const _loanPaymentPerPeriod = -(principal * formattedRate) / (1 - Math.pow(1 + formattedRate, -numberOfPayments));
    return roundResult(_loanPaymentPerPeriod);
};

/**
 *  Inflation-adjusted Return (IAR)
 *
 *  @param investmentReturn
 *  @param inflationRate
 *
 *  @returns The return taking into account the time period's
 *  inflation rate.
 */
export const inflationAdjustedReturn = (investmentReturn: number, inflationRate: number) => 100 * (((1 + investmentReturn) / (1 + inflationRate)) - 1);

/**
*  Capital Asset Pricing Model (CAPM)
*
*  @param riskFreeRate
*  @param investmentBeta
*  @param expectedMarketReturn
*  @param expectedInvestmentReturn
*
*  @returns The expected return of an asset.
*/
export const capitalAssetPricingModel = (riskFreeRate: number, investmentBeta: number, expectedMarketReturn: number): number => riskFreeRate / 100 + investmentBeta * (expectedMarketReturn / 100 - riskFreeRate / 100);

/**
*  Stock Present Value (Stock PV)
*
*  @param growthRate
*  @param ke I can't rename this variable because I don't know what it is.
*  @param dividendValue
*
*  @returns the value of stock with dividend growing at a constant
*  growth rate to perpetuity.
*/
export const stockPresentValue = (growthRate: number, ke: number, dividendValue: number): number => {
    const _stockPresentValue = (dividendValue * (1 + growthRate / 100)) / ((ke / 100) - (growthRate / 100));
    return Math.round(_stockPresentValue);
};

/**
*  Irregular Internal Rate Of Return (XIRR)
*
*  @param cashFlows
*  @param dates
*  @param guess
*
*  @returns The closest estimation of internal rate of return based on
*  the provided dates.
*/
export const irregularInternalRateOfReturn = (cashFlows: number[], dates: Date[], guess: number = 0): number => {
    if (cashFlows.length !== dates.length) throw new Error(ERROR_XIRR_MISMATCHING_DATASETS);

    let hasPositiveValue = false;
    let hasNegativeValue = false;

    cashFlows.forEach(cashFlow => {
        if (cashFlow > 0) hasPositiveValue = true;
        if (cashFlow < 0) hasNegativeValue = true;
    });

    if (!hasPositiveValue || !hasNegativeValue) throw new Error(ERROR_XIRR_MISSING_SIGNUM);

    let iterationLimit = 100;
    let lastGuess = 0;

    const durations = dates.reduce((_durations: number[], date, index) => {
        if (index + 1 < dates.length) _durations.push(durationInYears(date, dates[index + 1]));
        return _durations;
    }, [0]);

    const hasMatchingGuesses = lastGuess.toFixed(5) == guess.toFixed(5);

    for (let index = 1; index < iterationLimit; index++) {
        lastGuess = guess;
        guess = lastGuess - sumEq(cashFlows, durations, lastGuess);
        if (lastGuess.toFixed(5) == guess.toFixed(5)) break;
    }

    if (!hasMatchingGuesses) console.warn(WARN_XIRR_MISMATCHED_GUESS);
    const _irregularRateOfReturn = hasMatchingGuesses ? guess * 100 : 0;
    return roundResult(_irregularRateOfReturn);
};


// Local Variables:
// compile-command: "npm run build"
// End:
