//
//  ViewController.h
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


#import <UIKit/UIKit.h>
#import "MortgageCalculate.h"
#import "CapitalInterest.h"
#import "AFCircleGraph.h"
#import "PortfolioOptimizer.h"
#import "SecondViewController.h"



@interface ViewController : UIViewController


{
	MortgageCalculate* mortgageFirst;
	MortgageCalculate* mortgageSecond;
    CapitalInterest*   portfolioOriginal;
    CapitalInterest*   portfolioBalanced;
    CapitalInterest*   portfolioOptimized;
    
     
    double bankPayment;
    double loanPayment;
    
    double firstCapitalBalanced;
    double secondCapitalBalanced;
    double thirdCapitalBalanced;
    
    double firstCapitalOptimized;
    double secondCapitalOptimized;
    double thirdCapitalOptimized;
    
    PortfolioOptimizer* optimizer;
    
    
}


-(void) setMortgageFirst      :(MortgageCalculate*) f;
-(void) setMortgageSecond     :(MortgageCalculate*) s;
-(void) setPortfolioOriginal  :(CapitalInterest*) orig;
-(void) setPortfolioBalanced  :(CapitalInterest*) bal;
-(void) setPortfolioOptimized :(CapitalInterest*) opt;




// totalLoanAmount	= 50000.0;





@property double totalLoanAmount;


@property double firstCapital;
@property double secondCapital;
@property double thirdCapital;

@property double firstReturn;
@property double secondReturn;
@property double thirdReturn ;

@property double firstStdDev ;
@property double secondStdDev;
@property double thirdStdDev;

@property double contributionBank;
@property double contributionLoan;

@property double timeSteps;

@property double tax;



@property (weak, nonatomic) IBOutlet UILabel *tooHigh;



// ---------- ///

@property (weak, nonatomic) IBOutlet UILabel *monthlyPaymentBank;

@property (weak, nonatomic) IBOutlet UILabel *monthlyPaymentLoan;



@property (weak, nonatomic) IBOutlet UILabel *firstAfterLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondAfterLabel;

@property (weak, nonatomic) IBOutlet UILabel *thirdAfterLabel;


@property (weak, nonatomic) IBOutlet UILabel *firstOptimized;


@property (weak, nonatomic) IBOutlet UILabel *secondOptimized;


@property (weak, nonatomic) IBOutlet UILabel *thirdOptimized;


@property (weak, nonatomic) IBOutlet UILabel *totalPaymentBankLabel;


@property (weak, nonatomic) IBOutlet UILabel *totalPaymentLoanLabel;


@property (weak, nonatomic) IBOutlet AFCircleGraph *circleGraph;


@property (weak, nonatomic) IBOutlet AFCircleGraph *afterCircleGraph;


@property (weak, nonatomic) IBOutlet AFCircleGraph *optimizedCircleGraph;


/// input labels can be changed also ///


@property (weak, nonatomic) IBOutlet UITextField *loanAmountLabel;


@property (weak, nonatomic) IBOutlet UITextField *interestBankLabel;


@property (weak, nonatomic) IBOutlet UITextField *interestLoanLabel;


@property (weak, nonatomic) IBOutlet UITextField *timeMonthsLabel;

@property (weak, nonatomic) IBOutlet UITextField *taxLabel;

@property (weak, nonatomic) IBOutlet UITextField *contributionBankLabel;


@property (weak, nonatomic) IBOutlet UITextField *contributionLoanLabel;


@property (weak, nonatomic) IBOutlet UITextField *firstPortfolioLabel;


@property (weak, nonatomic) IBOutlet UITextField *secondPortfolioLabel;


@property (weak, nonatomic) IBOutlet UITextField *thirdPortfolioLabel;


@property (weak, nonatomic) IBOutlet UITextField *firstReturnLabel;


@property (weak, nonatomic) IBOutlet UITextField *secondReturnLabel;

@property (weak, nonatomic) IBOutlet UITextField *thirdReturnLabel;


@property (weak, nonatomic) IBOutlet UITextField *firstStdDevLabel;


@property (weak, nonatomic) IBOutlet UITextField *secondStdDevLabel;


@property (weak, nonatomic) IBOutlet UITextField *thirdStdDevLabel;






////////////////////

- (IBAction)enteredLoanAmount:(id)sender;


- (IBAction)enteredInterestBank:(id)sender;

- (IBAction)enteredInterestLoan:(id)sender;

- (IBAction)enteredMonths:(id)sender;



- (IBAction)enteredFirstPortfolio:(id)sender;

- (IBAction)enteredSecondPortfolio:(id)sender;

- (IBAction)enteredThirdPortfolio:(id)sender;


- (IBAction)enteredFirstReturn:(id)sender;

- (IBAction)enteredSecondReturn:(id)sender;

- (IBAction)enteredThirdReturn:(id)sender;


- (IBAction)enteredFirstStdDev:(id)sender;

- (IBAction)enteredSecondStdDev:(id)sender;

- (IBAction)enteredThirdStdDev:(id)sender;


- (IBAction)enteredTaxValue:(id)sender;


- (IBAction)contributionEditedBank:(id)sender;


- (IBAction)contributionEditedLoan:(id)sender;



-(void)setCircleGraphValues; 

-(void)setCircleBalanced;

-(void)setCircleOptimized;


-(IBAction)tapBackground:(id)sender;



@end

static bool viewControllerLoaded = false;


