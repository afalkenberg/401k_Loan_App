//
//  ViewController.m
//  Calculate401kLoan
//
//
//  Created by Andreas Falkenberg on 7/8/15.
//  Copyright (c) 2015 Andreas Falkenberg. All rights reserved.
//
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.

//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.

//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.
//


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //NSLog(@" in view Controller A ");

    if(viewControllerLoaded == false)
    {
        
        //NSLog(@" in view Controller B ");

        
        viewControllerLoaded = true;
        
        
        mortgageFirst      = [[MortgageCalculate alloc] init];
        mortgageSecond     = [[MortgageCalculate alloc] init];
        
        portfolioOriginal  = [[CapitalInterest   alloc] init];
        portfolioBalanced  = [[CapitalInterest   alloc] init];
        portfolioOptimized = [[CapitalInterest   alloc] init];
        
        
        optimizer          = [[PortfolioOptimizer alloc] init];
        
        [portfolioOriginal  initialize];
        [portfolioBalanced  initialize];
        [portfolioOptimized initialize];
        
        
        [mortgageFirst  setTotalAmount:[[NSNumber alloc] initWithDouble:50000.0]];
        [mortgageSecond setTotalAmount:[[NSNumber alloc] initWithDouble:50000.0]];
        
        
        [mortgageFirst  setPrincipal : [[NSNumber alloc] initWithDouble:50000.0]];
        [mortgageSecond setPrincipal : [[NSNumber alloc] initWithDouble:50000.0]];
        
        ///  timeUnit
        [mortgageFirst   setTimeUnit:1];
        [mortgageSecond  setTimeUnit:1];
        
        
        /// timeSteps
        _timeSteps = 36.0;
        [mortgageFirst   setTimeSteps: [[NSNumber alloc] initWithDouble: _timeSteps]];
        [mortgageSecond  setTimeSteps: [[NSNumber alloc] initWithDouble: _timeSteps]];
        
        
        double oldInterest;
        double midInterest;
        double newInterest;
        
        oldInterest = 6.0;
        midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/12.0);
        newInterest = (midInterest - 1.0) * 100.0;
        [mortgageFirst   setInterestPercent:[[NSNumber alloc] initWithDouble: newInterest]];
        
        oldInterest = 4.0;
        midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/12.0);
        newInterest = (midInterest - 1.0) * 100.0;
        [mortgageSecond  setInterestPercent: [[NSNumber alloc] initWithDouble: newInterest]];
        
        
        [mortgageFirst   setDownPayUnit:0];
        [mortgageSecond  setDownPayUnit:0];
        
        [mortgageFirst   setDownPayment:[[NSNumber alloc] initWithDouble:0.0]];
        [mortgageSecond  setDownPayment:[[NSNumber alloc] initWithDouble:0.0]];
        
        
        
        [mortgageFirst   setPointUnit:0];
        [mortgageSecond  setPointUnit:0];
        
        //pointPayment
        
        [mortgageFirst   setPointPayment:[[NSNumber alloc] initWithDouble:0.0]];
        [mortgageSecond  setPointPayment:[[NSNumber alloc] initWithDouble:0.0]];
        
        
        
        // afterValue
        
        [mortgageFirst   setAfterValue: 1];
        [mortgageSecond  setAfterValue: 1];

        
        //////
        
        _totalLoanAmount	= 50000.0;
        
        _firstCapital  = 35000.0;
        _secondCapital = 25000.0;
        _thirdCapital  = 30000.0;
        
        _firstReturn   = 7.0;
        _secondReturn   = 8.0;
        _thirdReturn   = 9.0;
        
        _firstStdDev   = 4.0;
        _secondStdDev   = 6.0;
        _thirdStdDev   = 11.0;
        
        _contributionBank = 300.0;
        _contributionLoan = 342.89;
        
        _tax  = 25.0; 

        [self triggerAll];   // new
        [self setAllGuiValues];
        
        
        
        _tooHigh.hidden = true;
        
    }
    else
    {
        
        //NSLog(@" in view Controller C ");

        
        optimizer          = [[PortfolioOptimizer alloc] init];
        
        [self presetInputLabels]; 
        
        [self triggerAll];   // new
        [self setAllGuiValues];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)getNSIntegerFromSender:(id)sender
{
    UITextField* p;
    p = (UITextField*)sender;
    
    NSString* pr;
    pr = [p text];
    
    NSInteger x;
    x = [pr integerValue];
    
    return x;
    
}


-(NSNumber*)getNSNumberFromSender:(id)sender
{
    UITextField* p;
    p = (UITextField*)sender;
    
    NSString* pr;
    pr = [p text];
    
    double x;
    x = [pr doubleValue];
    
    NSNumber* prin;
    prin = [[NSNumber alloc] initWithDouble:x];
    return prin;
    
}




- (IBAction)enteredLoanAmount:(id)sender
{

    _totalLoanAmount = [[self getNSNumberFromSender:sender] doubleValue];
    
    [mortgageFirst  setTotalAmount : [self getNSNumberFromSender:sender]];
    [mortgageSecond setTotalAmount : [self getNSNumberFromSender:sender]];

    
    
    [self triggerAll];
}

- (IBAction)enteredInterestBank:(id)sender
{
    
    double oldInterest;
    double midInterest;
    double newInterest;
    
    
    oldInterest = [[self getNSNumberFromSender:sender] doubleValue];
    
    
    midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/12.0);
    
    newInterest = (midInterest - 1.0) * 100.0;
    
    //NSLog(@"   old %f %f new ",oldInterest, newInterest );
    
    
    [mortgageFirst setInterestPercent: [[NSNumber alloc] initWithDouble : newInterest]];
    
    [self triggerAll];


}

- (IBAction)enteredInterestLoan:(id)sender
{
    
    double oldInterest;
    double midInterest;
    double newInterest;
    
    oldInterest = [[self getNSNumberFromSender:sender] doubleValue];
    
    midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/12.0);
    newInterest = (midInterest - 1.0) * 100.0;
    
    [mortgageSecond setInterestPercent : [[NSNumber alloc] initWithDouble : newInterest]];

    [self triggerAll];

}

- (IBAction)enteredMonths:(id)sender
{
    
    NSNumber* tnum;
    
    _timeSteps = [[self getNSNumberFromSender:sender] doubleValue];
    if(_timeSteps <= 0.0)
    {
        _timeSteps = 1.0;
    }
    
    tnum = [[NSNumber alloc] initWithDouble: _timeSteps];
    
    // NSLog(@"<><><><><>>><>><><><>< ><> >< >< ><><><<> <> <>>< %@", tnum);
    
    
    
    [mortgageFirst  setTimeSteps: tnum];
    [mortgageSecond setTimeSteps: tnum];
    
    
    [self triggerAll];

}



/****************/




- (IBAction)enteredFirstPortfolio:(id)sender
{
    
    _firstCapital = [[self getNSNumberFromSender:sender] doubleValue];

    [self triggerAll];
    
}

- (IBAction)enteredSecondPortfolio:(id)sender
{
    
    _secondCapital = [[self getNSNumberFromSender:sender] doubleValue];

    [self triggerAll];

}

- (IBAction)enteredThirdPortfolio:(id)sender
{
    
    _thirdCapital = [[self getNSNumberFromSender:sender] doubleValue];
    [self triggerAll];

}

- (IBAction)enteredFirstReturn:(id)sender
{
    
    _firstReturn = [[self getNSNumberFromSender:sender] doubleValue]  ;
    [self triggerAll];
}

- (IBAction)enteredSecondReturn:(id)sender
{
    _secondReturn = [[self getNSNumberFromSender:sender] doubleValue];
    [self triggerAll];
}

- (IBAction)enteredThirdReturn:(id)sender
{
    _thirdReturn = [[self getNSNumberFromSender:sender] doubleValue];
    [self triggerAll];
}

- (IBAction)enteredFirstStdDev:(id)sender
{
    
    _firstStdDev = [[self getNSNumberFromSender:sender] doubleValue];
    [self triggerAll];
}

- (IBAction)enteredSecondStdDev:(id)sender
{
    
    _secondStdDev = [[self getNSNumberFromSender:sender] doubleValue];
    [self triggerAll];
}

- (IBAction)enteredThirdStdDev:(id)sender
{
    _thirdStdDev = [[self getNSNumberFromSender:sender] doubleValue];
   
    [self triggerAll];
}

- (IBAction)enteredTaxValue:(id)sender
{
    _tax = [[self getNSNumberFromSender:sender] doubleValue];
    
    [self triggerAll];

}

- (IBAction)contributionEditedBank:(id)sender
{
    _contributionBank = [[self getNSNumberFromSender:sender] doubleValue];
    
    
    [self triggerAll];
}


- (IBAction)contributionEditedLoan:(id)sender
{

    _contributionLoan = [[self getNSNumberFromSender:sender] doubleValue];
    
    
    [self triggerAll];

}


/// this is no subtraction ///


-(void)setAllPortfolioValuesOriginal
{
    
    [portfolioOriginal initialize];
    
    
    // calculate balance based on initial values //
    
    double norm;
    norm = _firstCapital + _secondCapital + _thirdCapital;
    
    double fb;
    double sb;
    double tb;
    fb = 100*_firstCapital/norm;
    sb = 100*_secondCapital/norm;
    tb = 100*_thirdCapital/norm;
    
    
    [portfolioOriginal addParameters :_firstCapital interest  : _firstReturn stdDev : _firstStdDev time : _timeSteps balance : fb];

    [portfolioOriginal addParameters :_secondCapital interest : _secondReturn stdDev : _secondStdDev time : _timeSteps balance : sb];
    
    [portfolioOriginal addParameters :_thirdCapital interest  : _thirdReturn stdDev : _thirdStdDev time : _timeSteps balance : tb];

    
    // no loan from 401k so no payback to 401k set here //
    
    [portfolioOriginal setPayBack    : 0.0];
    [portfolioOriginal setContribute : _contributionBank];
    
    
    [portfolioOriginal setTax          : _tax];
    
    [portfolioOriginal calculateAll];
    
    
    
    [portfolioOriginal sumResultsAndAdd : 0 index1 : 3 index2 : 6];  // result in 9
    [portfolioOriginal sumResultsAndAdd : 1 index1 : 4 index2 : 7];  // result in 10
    [portfolioOriginal sumResultsAndAdd : 2 index1 : 5 index2 : 8];  // result in 11
    
    
    
   // [portfolioOriginal print];
    
    
}



-(void)setAllPortfolioValuesBalanced
{
    
    [portfolioBalanced initialize];
    
    
    // calculate balance based on initial values //
    
    double norm;
    norm = firstCapitalBalanced + secondCapitalBalanced + thirdCapitalBalanced;
    
    double fb;
    double sb;
    double tb;
    fb = 100*firstCapitalBalanced/norm;
    sb = 100*secondCapitalBalanced/norm;
    tb = 100*thirdCapitalBalanced/norm;
    
    
    [portfolioBalanced addParameters :firstCapitalBalanced interest  : _firstReturn stdDev : _firstStdDev time : _timeSteps balance : fb];
    
    [portfolioBalanced addParameters :secondCapitalBalanced interest : _secondReturn stdDev : _secondStdDev time : _timeSteps balance : sb];
    
    [portfolioBalanced addParameters :thirdCapitalBalanced interest  : _thirdReturn stdDev : _thirdStdDev time : _timeSteps balance : tb];
    
    
    
    [portfolioBalanced setPayBack    : loanPayment];
    [portfolioBalanced setContribute : _contributionLoan];
    
    
    [portfolioBalanced setTax          : _tax];
    
    [portfolioBalanced calculateAll];
    
    
    
    [portfolioBalanced sumResultsAndAdd : 0 index1 : 3 index2 : 6];  // result in 9
    [portfolioBalanced sumResultsAndAdd : 1 index1 : 4 index2 : 7];  // result in 10
    [portfolioBalanced sumResultsAndAdd : 2 index1 : 5 index2 : 8];  // result in 11
    
    
    
    // [portfolioBalanced print];
    
    
}






-(void)setAllPortfolioValuesOptimized
{
    
    [portfolioOptimized initialize];
    
    
    // calculate balance based on initial values //
    
    double norm;
    norm =    (_firstCapital  - firstCapitalOptimized)
            + (_secondCapital - secondCapitalOptimized)
            + (_thirdCapital  - thirdCapitalOptimized);
    
    
    double fb;
    double sb;
    double tb;
    fb = 100*(_firstCapital  - firstCapitalOptimized)/norm;
    sb = 100*(_secondCapital - secondCapitalOptimized)/norm;
    tb = 100*(_thirdCapital  - thirdCapitalOptimized)/norm;
    
    
    [portfolioOptimized addParameters :firstCapitalOptimized interest  : _firstReturn stdDev : _firstStdDev time : _timeSteps balance : fb];
    
    [portfolioOptimized addParameters :secondCapitalOptimized interest : _secondReturn stdDev : _secondStdDev time : _timeSteps balance : sb];
    
    [portfolioOptimized addParameters :thirdCapitalOptimized interest  : _thirdReturn stdDev : _thirdStdDev time : _timeSteps balance : tb];
    

    // here you contribute both the payback and your monthly cont to 401k //
    [portfolioOptimized setPayBack :    loanPayment];
    [portfolioOptimized setContribute:  _contributionLoan];
    
    
    [portfolioOptimized setTax          : _tax];
    
    [portfolioOptimized calculateAll];
    
    
    
    [portfolioOptimized sumResultsAndAdd : 0 index1 : 3 index2 : 6];  // result in 9
    [portfolioOptimized sumResultsAndAdd : 1 index1 : 4 index2 : 7];  // result in 10
    [portfolioOptimized sumResultsAndAdd : 2 index1 : 5 index2 : 8];  // result in 11
    
    
    
    //[portfolioOptimized print];
    
    
}






-(void)setResultPortfolio  // after parameters are received
{
    double tempCap[3];
    double tempInt[3];
    tempCap[0] = _firstCapital;
    tempCap[1] = _secondCapital;
    tempCap[2] = _thirdCapital;
    
    tempInt[0] = _firstReturn;
    tempInt[1] = _secondReturn;
    tempInt[2] = _thirdReturn;
    
    [optimizer setCapital  : tempCap];
    [optimizer setInterest : tempInt];
    
    [optimizer setTotalLoan:_totalLoanAmount];
    
    [optimizer calculatePortfolioBalanced];
    [optimizer calculatePortfolioOptimized];
    
    firstCapitalBalanced   = [optimizer getCapitalBalanced:0];
    secondCapitalBalanced  = [optimizer getCapitalBalanced:1];
    thirdCapitalBalanced   = [optimizer getCapitalBalanced:2];
    
    firstCapitalOptimized  = [optimizer getCapitalOptimized:0] ;
    secondCapitalOptimized = [optimizer getCapitalOptimized:1];
    thirdCapitalOptimized  = [optimizer getCapitalOptimized:2];

    
    
}



-(void)triggerAll
{
    [mortgageFirst  calculateAll];
    [mortgageSecond calculateAll];
    
    bankPayment = [[mortgageFirst paymentPerUnit] doubleValue];
    loanPayment	= [[mortgageSecond paymentPerUnit] doubleValue];
    
    [self setResultPortfolio];
    
    [self setAllPortfolioValuesOriginal];  // here we also call calculateAll
    [self setAllPortfolioValuesBalanced];
    [self setAllPortfolioValuesOptimized];
    
    
    [self setAllGuiValues];
}


-(void)setCircleGraphValues
{
    
    NSMutableArray *aValues;
    aValues = [[NSMutableArray alloc] init];
    
    NSMutableArray *val;
    val = [[NSMutableArray alloc] init];
    
    NSMutableArray *lab;
    lab = [[NSMutableArray alloc] init];
    
    
    // normalize
    
    double norm;
    norm = _firstCapital + _secondCapital + _thirdCapital;
    double num;
    num = 100*_firstCapital/norm;
    [val addObject:[NSNumber numberWithDouble:num]];

    [lab addObject: [NSString stringWithFormat: @"%.02f %%", num]];
    
    
    num = 100*_secondCapital/norm;
    [val addObject:[NSNumber numberWithDouble:num]];
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", num]];
    
    
    num = 100*_thirdCapital/norm;
    [val addObject:[NSNumber numberWithDouble:num]];
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", num]];
    
    [aValues addObject:val];
    
    [_circleGraph setaValues : aValues];
    [_circleGraph setXLabels:  lab];
    
    
}


-(void)setCircleBalanced
{
    NSMutableArray *aValues;
    aValues = [[NSMutableArray alloc] init];
    
    NSMutableArray *val;
    val = [[NSMutableArray alloc] init];
    
    NSMutableArray *lab;
    lab = [[NSMutableArray alloc] init];
    
    
    // normlaize
    
    
    double norm;
    norm = firstCapitalBalanced + secondCapitalBalanced + thirdCapitalBalanced;
    double num;
    num = 100*firstCapitalBalanced/norm;
    [val addObject:[NSNumber numberWithDouble:num]];
    
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", num]];
    
    
    num = 100*secondCapitalBalanced/norm;
    [val addObject:[NSNumber numberWithDouble:num]];
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", num]];
    
    
    num = 100*thirdCapitalBalanced/norm;
    [val addObject:[NSNumber numberWithDouble:num]];
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", num]];
    
    [aValues addObject:val];
    
    [_afterCircleGraph setaValues : aValues];
    [_afterCircleGraph setXLabels:  lab];

}




-(void)setCircleOptimized
{
    NSMutableArray *aValues;
    aValues = [[NSMutableArray alloc] init];
    
    NSMutableArray *val;
    val = [[NSMutableArray alloc] init];
    
    NSMutableArray *lab;
    lab = [[NSMutableArray alloc] init];
    
    
    // normlaize
    
    double norm;
    
    
    norm = firstCapitalOptimized + secondCapitalOptimized + thirdCapitalOptimized;
    double num;
    num = 100*firstCapitalOptimized/norm;
    [val addObject:[NSNumber numberWithDouble:num]];
    
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", num]];
    
    
    num = 100*secondCapitalOptimized/norm;
    [val addObject:[NSNumber numberWithDouble:num]];
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", num]];
    
    
    num = 100*thirdCapitalOptimized/norm;
    [val addObject:[NSNumber numberWithDouble:num]];
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", num]];
    
    [aValues addObject:val];
    
    [_optimizedCircleGraph setaValues : aValues];
    [_optimizedCircleGraph setXLabels:  lab];
    
    
    
    

}

- (IBAction)tapBackground:(id)sender
{
    
    [self dismissKeyboard];
    
    [self triggerAll];
    
}


-(void)dismissKeyboard
{
    [_loanAmountLabel resignFirstResponder];
    [_interestBankLabel resignFirstResponder];
    [_interestLoanLabel resignFirstResponder];
    [_timeMonthsLabel resignFirstResponder];
    [_taxLabel resignFirstResponder];
    [_contributionBankLabel resignFirstResponder];
    [_contributionLoanLabel resignFirstResponder];
    [_firstPortfolioLabel resignFirstResponder];
    [_secondPortfolioLabel resignFirstResponder];
    [_thirdPortfolioLabel  resignFirstResponder];
    [_firstReturnLabel resignFirstResponder];
    [_secondReturnLabel resignFirstResponder];
    [_thirdReturnLabel  resignFirstResponder];
    [_firstStdDevLabel resignFirstResponder];
    [_secondStdDevLabel resignFirstResponder];
    [_thirdStdDevLabel  resignFirstResponder];
    
    
}




-(void)presetInputLabels
{
    _loanAmountLabel.text   = [NSString stringWithFormat: @"%.02f",_totalLoanAmount];
    _interestLoanLabel.text = [NSString stringWithFormat: @"%.02f",_totalLoanAmount];
    
    
    _timeMonthsLabel.text   = [NSString stringWithFormat: @"%.02f",_timeSteps];
    
    _taxLabel.text               = [NSString stringWithFormat: @"%.02f",_tax];
    _contributionBankLabel.text  = [NSString stringWithFormat: @"%.02f",_contributionBank];
    _contributionLoanLabel.text  = [NSString stringWithFormat: @"%.02f",_contributionLoan];
    
    
    
    double oldInterest;
    double midInterest;
    double newInterest;
    
    
    oldInterest = [[mortgageFirst interestPercent] doubleValue];
    midInterest	= pow((1.0 + 0.01 * oldInterest), 12.0);
    newInterest = (midInterest - 1.0) * 100.0;

    _interestBankLabel.text = [NSString stringWithFormat: @"%.02f",newInterest];
    
    oldInterest = [[mortgageSecond interestPercent] doubleValue];
    midInterest	= pow((1.0 + 0.01 * oldInterest), 12.0);
    newInterest = (midInterest - 1.0) * 100.0;
    
    _interestLoanLabel.text = [NSString stringWithFormat: @"%.02f",newInterest];
    
    
    _firstPortfolioLabel.text = [NSString stringWithFormat: @"%.02f",_firstCapital];
    _secondPortfolioLabel.text = [NSString stringWithFormat: @"%.02f",_secondCapital];
    _thirdPortfolioLabel.text  = [NSString stringWithFormat: @"%.02f",_thirdCapital];
    
    _firstReturnLabel.text =     [NSString stringWithFormat: @"%.02f",_firstReturn];
    _secondReturnLabel.text =    [NSString stringWithFormat: @"%.02f",_secondReturn];
    _thirdReturnLabel.text =     [NSString stringWithFormat: @"%.02f",_thirdReturn];
    
    _firstStdDevLabel.text =     [NSString stringWithFormat: @"%.02f",_firstStdDev];
    _secondStdDevLabel.text =    [NSString stringWithFormat: @"%.02f",_secondStdDev];
    _thirdStdDevLabel.text =     [NSString stringWithFormat: @"%.02f",_thirdStdDev];
    
    
    
}










-(void)setAllGuiValues
{
    
    
    
    
    _monthlyPaymentBank.text = [NSString stringWithFormat: @"%.02f",[[mortgageFirst paymentPerUnit] doubleValue]];
    
    _monthlyPaymentLoan.text = [NSString stringWithFormat: @"%.02f",[[mortgageSecond paymentPerUnit] doubleValue]];
    
   // _monthlyPaymentLoan.text = [NSString stringWithFormat: @"%.02f",[[mortgageSecond paymentPerUnit] doubleValue]];
    
    
    double tbl;
    tbl = [[mortgageFirst  paymentPerUnit] doubleValue] + _contributionBank;
    double tll;
    tll = [[mortgageSecond paymentPerUnit] doubleValue] + _contributionLoan;
    
    
    
    _totalPaymentBankLabel.text = [NSString stringWithFormat: @"%.02f", tbl];
    
    _totalPaymentLoanLabel.text = [NSString stringWithFormat: @"%.02f", tll];
    
    
    
    _firstAfterLabel.text = [NSString stringWithFormat: @"%.02f", firstCapitalBalanced];
    _secondAfterLabel.text = [NSString stringWithFormat: @"%.02f", secondCapitalBalanced];
    _thirdAfterLabel.text = [NSString stringWithFormat: @"%.02f", thirdCapitalBalanced];
    
    _firstOptimized.text = [NSString stringWithFormat: @"%.02f", firstCapitalOptimized];
    _secondOptimized.text = [NSString stringWithFormat: @"%.02f", secondCapitalOptimized];
    _thirdOptimized.text = [NSString stringWithFormat: @"%.02f", thirdCapitalOptimized];

    

    [self setCircleGraphValues];
    [self setCircleBalanced];
    [self setCircleOptimized];
    
    [_circleGraph somethingChanged]; 
    [_afterCircleGraph somethingChanged];
    [_optimizedCircleGraph somethingChanged]; 
    
    
    
    
    if(_totalLoanAmount > (_firstCapital + _secondCapital + _thirdCapital))
    {
        _tooHigh.hidden = false;
    }
    else
    {
        _tooHigh.hidden = true;
    }
    
    
    
    
    
}



-(void) setMortgageFirst   :(MortgageCalculate*) f
{
    mortgageFirst = f;
}

-(void) setMortgageSecond  :(MortgageCalculate*) s
{
    mortgageSecond = s;
}

-(void) setPortfolioOriginal  :(CapitalInterest*) orig
{
    portfolioOriginal = orig;
}

-(void) setPortfolioBalanced  :(CapitalInterest*) bal
{
    portfolioBalanced = bal;
}

-(void) setPortfolioOptimized :(CapitalInterest*) opt
{
    portfolioOptimized = opt;
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // gotoResultSegue
    
    // NSLog(@"In the Seque !!!!!! >>>>>> >>>> >> >> >>>> >>> >> > ");
    
    
    if([[segue identifier] isEqualToString:@"gotoSecondSegue"] ||
       [[segue identifier] isEqualToString:@"swipeToSecondSegue"])
    {
        
        
        SecondViewController *rv = [segue destinationViewController];
        //NSLog(@"bla 2");

        [rv setMortgageFirst : mortgageFirst]; //    : [portfolioOriginal : result]];
        [rv setMortgageSecond: mortgageSecond];
        [rv setPortfolioOriginal:portfolioOriginal];
        [rv setPortfolioBalanced:portfolioBalanced];
        [rv setPortfolioOptimized:portfolioOptimized];
        
        
        rv.totalLoanAmount = _totalLoanAmount;
        
        rv.firstCapital    = _firstCapital;
        rv.secondCapital   = _secondCapital;
        rv.thirdCapital    = _thirdCapital;
        
        rv.firstReturn     = _firstReturn;
        rv.secondReturn    = _secondReturn;
        rv.thirdReturn     = _thirdReturn;
        
        rv.firstStdDev     = _firstStdDev;
        rv.secondStdDev    = _secondStdDev;
        rv.thirdStdDev     = _thirdStdDev;
        
        rv.contributionBank = _contributionBank;
        rv.contributionLoan = _contributionLoan;
        
        rv.timeSteps        = _timeSteps;
        
        rv.tax              = _tax;

        
        
        
    }
    
    // Pass the selected object to the new view controller.
}



@end
