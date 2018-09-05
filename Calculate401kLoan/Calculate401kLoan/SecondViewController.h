//
//  SecondViewController.h
//  Calculate401kLoan
//
//
//  Created by Andreas Falkenberg on 7/17/15.
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
#import <iAd/iAd.h>

#import "AFMultiGraph.h"
#import "CapitalInterest.h"
#import "MortgageCalculate.h"
#import "ViewController.h"


@interface SecondViewController : UIViewController<ADBannerViewDelegate>

{
    MortgageCalculate* mortgageFirst;
    MortgageCalculate* mortgageSecond;
    CapitalInterest*   portfolioOriginal;
    CapitalInterest*   portfolioBalanced;
    CapitalInterest*   portfolioOptimized;
    
    int loanSelect;
    int portfolioSelect;
    int methodSelect;
    
    int portfolioSelectSecond;
    int methodSelectSecond;
    
    
}


@property(nonatomic, retain) IBOutlet ADBannerView *firstAdBanner;


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





-(void) setMortgageFirst      :(MortgageCalculate*) f;
-(void) setMortgageSecond     :(MortgageCalculate*) s;
-(void) setPortfolioOriginal  :(CapitalInterest*) orig;
-(void) setPortfolioBalanced  :(CapitalInterest*) bal;
-(void) setPortfolioOptimized :(CapitalInterest*) opt;


@property (weak, nonatomic) IBOutlet AFCircleGraph *firstCircle;


@property (weak, nonatomic) IBOutlet AFMultiGraph *FirstGraph;


@property (weak, nonatomic) IBOutlet AFMultiGraph *SecondGraph;


- (IBAction)upperViewValueChanged:(id)sender;


- (IBAction)selectPortfolioChanged:(id)sender;


- (IBAction)selectMethodChanged:(id)sender;


- (IBAction)selectPortfolioSecondChanged:(id)sender;

- (IBAction)valueChangedSecond:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *resultField;


// -(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error;


@end



