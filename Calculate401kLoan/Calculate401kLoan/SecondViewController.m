//
//  SecondViewController.m
//  Calculate401kLoan
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


#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

@synthesize firstAdBanner;


- (void)viewDidLoad
{
    
    self.canDisplayBannerAds = true;

    
    firstAdBanner.delegate = self;
    firstAdBanner.hidden   = YES;
        
    
    // [self showAll];
    
    [self showLoans : 0];

    [self showPortfolio : 0 select : 0];
    
    [self showCircle : 0 select : 0];
    
    
    //NSLog(@"  rv total %f",_totalLoanAmount);
    
    [super viewDidLoad];

    
}


/** ------------------------------ **/




- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    
  //  NSLog(@"Banner is loaded1 ");
    firstAdBanner.hidden  = NO;
}






-(void)viewDidAppear:(BOOL)animated
{
  // 	NSLog(@"BANNER APPEARED1");
    
    
  
   if(firstAdBanner.isBannerLoaded == YES)
   {
   //    NSLog(@"isbannerLoaded? ");
       firstAdBanner.hidden = NO;
   }
   else
   {
   //    NSLog(@"else path");
       firstAdBanner.hidden = YES;
   }
   
    
    [super viewDidAppear:animated];
}


 
 

- (void) viewWillDisappear:(BOOL)animated
{
   // NSLog(@"ok try disappear ");
   
    firstAdBanner.hidden = YES;
    
    [firstAdBanner removeFromSuperview];
    firstAdBanner.delegate = nil;
    firstAdBanner = nil;

    
    
    [super viewWillDisappear:animated];
    
}



-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    
    firstAdBanner.hidden = YES;
    //NSLog(@"did fail to load1");
    
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    
    
    //NSLog(@"view action bshould begin1");
    return YES;
}






/** ------------------------------ **/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



-(void)defineColors
{
    
    NSMutableArray* colorMain;
    NSMutableArray* colorUp;
    NSMutableArray* colorDown;
    
    colorMain = [[NSMutableArray alloc]init];
    colorUp   = [[NSMutableArray alloc]init];
    colorDown = [[NSMutableArray alloc]init];
    
    
    for(int i = 0; i < 13; i++)
    {
        
        
    	// [colorMain  insertObject: [UIColor colorWithRed: r green:g blue:b alpha:1.0] atIndex:i];
    

        // [colorUp    insertObject: [UIColor colorWithRed: b green:g blue:r alpha:1.0] atIndex:i];
        
        // [colorDown  insertObject: [UIColor colorWithRed: g green:r blue:b alpha:1.0] atIndex:i];

        [colorMain  insertObject: [UIColor whiteColor] atIndex:i];
        [colorUp    insertObject: [UIColor redColor] atIndex:i];
        [colorDown  insertObject: [UIColor orangeColor] atIndex:i];
        
    
    }
    
    [colorMain  insertObject: [UIColor blueColor] atIndex:0];
    [colorMain  insertObject: [UIColor whiteColor] atIndex:1];
    [colorMain  insertObject: [UIColor greenColor] atIndex:2];
   
    [colorMain  insertObject: [UIColor blueColor] atIndex:3];
    [colorMain  insertObject: [UIColor whiteColor] atIndex:4];
    [colorMain  insertObject: [UIColor greenColor] atIndex:5];

    [colorMain  insertObject: [UIColor blueColor] atIndex:6];
    [colorMain  insertObject: [UIColor whiteColor] atIndex:7];
    [colorMain  insertObject: [UIColor greenColor] atIndex:8];

    [colorMain  insertObject: [UIColor blueColor] atIndex:9];
    [colorMain  insertObject: [UIColor whiteColor] atIndex:10];
    [colorMain  insertObject: [UIColor greenColor] atIndex:11];

    
    
   // [colorUp insertObject : [UIColor blueColor] atIndex : 8];
    
    
    [_SecondGraph setColorValues:colorMain positive: colorUp negative:colorDown];

        
    
}



// select is always the same //

-(void)showCircle : (int)p select : (int)sel
{
    
    NSMutableArray *orig;
    NSMutableArray *bal;
    NSMutableArray *opt;
    
    NSMutableArray *comp;
    
    NSMutableArray *valval;
    
    NSMutableArray *val;
    NSMutableArray *lab;
    
    val    = [[NSMutableArray alloc] init];
    lab    = [[NSMutableArray alloc] init];
    
    
    valval = [[NSMutableArray alloc] init];
    
    
    comp = [[NSMutableArray alloc]init];
    
    
    orig = [portfolioOriginal  result];
    bal  = [portfolioBalanced  result];
    opt  = [portfolioOptimized result];
    

    /// sel = 0 1 2 :: worst //avg // best
    
    
    if(p == 0)
    {
        
        [comp insertObject : orig[sel]   atIndex:0];
        [comp insertObject : orig[sel+3] atIndex:1];
        [comp insertObject : orig[sel+6] atIndex:2];
        
    }
    else if(p == 1)
    {
        [comp insertObject : bal[sel]   atIndex:0];
        [comp insertObject : bal[sel+3] atIndex:1];
        [comp insertObject : bal[sel+6] atIndex:2];
    }
    else if(p ==2)
    {
        [comp insertObject : opt[sel]   atIndex:0];
        [comp insertObject : opt[sel+3] atIndex:1];
        [comp insertObject : opt[sel+6] atIndex:2];
    }
    
    
    
    
    double norm;
    
    double fc;
    double sc;
    double tc;
    int anz0;
    int anz1;
    int anz2;
    
    
    anz0 = [comp[0] count];
    anz1 = [comp[1] count];
    anz2 = [comp[2] count];

    fc = [[[comp objectAtIndex:0] objectAtIndex : anz0-1] doubleValue];
    sc = [[[comp objectAtIndex:1] objectAtIndex : anz1-1] doubleValue];
    tc = [[[comp objectAtIndex:2] objectAtIndex : anz2-1] doubleValue];


    
    norm = fc + sc + tc;
    
    
    [val addObject:[NSNumber numberWithDouble:100*fc/norm]];
    [val addObject:[NSNumber numberWithDouble:100*sc/norm]];
    [val addObject:[NSNumber numberWithDouble:100*tc/norm]];
    
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", 100*fc/norm]];
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", 100*sc/norm]];
    [lab addObject: [NSString stringWithFormat: @"%.02f %%", 100*tc/norm]];
    
    
    [valval addObject:val];
    
    [_firstCircle setaValues : valval];
    [_firstCircle setXLabels:lab];
    
    
    
    NSMutableArray* radiusValue;
    radiusValue = [[NSMutableArray alloc]init];
    [radiusValue insertObject:[[NSNumber alloc] initWithFloat:82.0] atIndex:0];
    
    [_firstCircle setRadius:radiusValue]; 
    
    [_firstCircle somethingChanged];
    
    
    
    [self setTotalValue : norm];
    
    
}



-(void)showPortfolio : (int)p select : (int)sel
{
    
    
    
    NSMutableArray *aval;
    
    
    NSMutableArray *showMask;
    showMask = [[NSMutableArray alloc]init];
    
    
    for (int i = 0; i < 13 ; i++)
    {
        [showMask    insertObject: [NSNumber numberWithBool:false] atIndex: i];
        
    }
    
    
    if(p == 0)
    {
    
    	aval = [portfolioOriginal result];
    }
    else if(p == 1)
    {
        aval = [portfolioBalanced result];
    }
    else if(p ==2)
    {
        aval = [portfolioOptimized result];
    }
    
    
    
   
    
    
    if(sel == 0)
    {
    	[showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 0];
       	[showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 1];
        [showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 2];
        
        
        // need here to continue //
    }
    else if(sel == 1)
    {
        [showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 3];
       	[showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 4];
        [showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 5];

    }
    else if(sel == 2)
    {
        [showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 6];
       	[showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 7];
        [showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 8];
    }
    else if(sel == 3)
    {
        [showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 9];
       	[showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 10];
        [showMask    insertObject: [NSNumber numberWithBool:true]atIndex: 11];
    }
    
    
    
    
    
    [_SecondGraph setShowMask:showMask];
    
    [_SecondGraph setaValues: aval];
    
    [_SecondGraph setXLabels: [mortgageFirst xLabel]];  // same as the others !
    
    [self defineColors]; 
    
    [_SecondGraph autoSize : YES];
    
    [_SecondGraph somethingChanged];
    
}


// here we show comparison results between portfolios

-(void)showPortfolioCompare :(int)cmp select : (int)select
{
    
    NSMutableArray *orig;
    NSMutableArray *bal;
    NSMutableArray *opt;
    
    NSMutableArray *comp;
    
    comp = [[NSMutableArray alloc]init];
    
    orig = [portfolioOriginal  result];
    bal  = [portfolioBalanced  result];
    opt  = [portfolioOptimized result];
    
    
    
    
    
    NSMutableArray *showMask;
    showMask = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 4 ; i++)
    {
        [showMask    insertObject: [NSNumber numberWithBool:true] atIndex: i];
        
    }

    
    int sel;
    sel = select * 3 ; // 0 .. 3 select portfolio 0 1 2 and total
    
    
    
    if(cmp == 3)  // best
    {
        
        [comp insertObject : orig[sel] atIndex:0 ];
        [comp insertObject : bal[sel]  atIndex:1 ];
        [comp insertObject : opt[sel]  atIndex:2 ];
        
    }
    else if(cmp == 4)  // medium
    {
        [comp insertObject : orig[sel + 1] atIndex:0 ];
        [comp insertObject : bal[sel + 1]  atIndex:1 ];
        [comp insertObject : opt[sel + 1]  atIndex:2 ];
        
    }
    else if(cmp == 5)  // worst
    {
        [comp insertObject : orig[sel + 2] atIndex:0 ];
        [comp insertObject : bal[sel + 2]  atIndex:1 ];
        [comp insertObject : opt[sel + 2]  atIndex:2 ];
        
    }

    
    [_SecondGraph setShowMask:showMask];
    
    [_SecondGraph setaValues: comp];
    
    [_SecondGraph setXLabels: [mortgageFirst xLabel]];  // same as the others !
    
    [self defineColors];
    
    [_SecondGraph autoSize : YES];
    
    [_SecondGraph somethingChanged];

    
    
    
}



-(void)showLoans : (int) select
{
    
    
    //inta = (int)[[mortgageFirst  timeSteps] integerValue];
    //intb = (int)[[mortgageSecond timeSteps] integerValue];
    
    
    NSMutableArray *aval;
    aval = [[NSMutableArray alloc] init];
    
    
    
    if(select == 0)
    {
        
        [aval addObject:[mortgageFirst  principalPerUnitOverTime]];
        [aval addObject:[mortgageSecond principalPerUnitOverTime]];
        
        //    [UpperGraph setXLabels: [mortgageFirst  xLabel]];
        //    [UpperGraph setaValues: [mortgageFirst  principalPerUnitOverTime]];
        
    }
    
    else if(select == 1)
    {
        
        [aval addObject:[mortgageFirst principalPerUnitOverTime]];
        [aval addObject:[mortgageFirst interestPerUnitOverTime]];
        
    }
    
    else if(select == 2)
    {
        
        [aval addObject:[mortgageSecond principalPerUnitOverTime]];
        [aval addObject:[mortgageSecond interestPerUnitOverTime]];
        
    }
    
    else if(select == 3)
    {
        
        [aval addObject:[mortgageFirst  balanceOverTime]];
        [aval addObject:[mortgageSecond balanceOverTime]];
            
    }
    
    else if(select == 4)
    {
        
        [aval addObject:[mortgageFirst  totalOverTime]];
        [aval addObject:[mortgageSecond totalOverTime]];
        
    }
    
    else if(select == 5)
    {
        
        [aval addObject:[mortgageFirst  interestOverTime]];
        [aval addObject:[mortgageSecond interestOverTime]];
        
    }

    else if(select == 6)
    {
        
        [aval addObject:[mortgageFirst  interestPerUnitOverTime]];
        [aval addObject:[mortgageSecond interestPerUnitOverTime]];
        
    }

    [_FirstGraph setXLabels: [mortgageFirst xLabel]];
    
    
    [_FirstGraph setaValues: aval];

    [_FirstGraph autoSize : YES];

    [_FirstGraph somethingChanged];
    
    
}





- (IBAction)upperViewValueChanged:(id)sender
{
    
    
    
    UISegmentedControl* uis;
    
    uis = (UISegmentedControl*) sender;
    
    loanSelect = (int)[uis selectedSegmentIndex];
    
    // NSLog(@" %d " , loanSelect);
    
    [self showLoans : loanSelect];
    
  
    
}

- (IBAction)selectPortfolioChanged:(id)sender
{
    UISegmentedControl* uis;
    
    uis = (UISegmentedControl*) sender;
    
    portfolioSelect = (int)[uis selectedSegmentIndex];
    
    //NSLog(@" %d " , portfolioSelect);
    
    if(portfolioSelect < 3)
    {
    
    	[self showPortfolio : portfolioSelect select:methodSelect];
        
    }
    else
    {
        [self showPortfolioCompare :portfolioSelect select : methodSelect];

    }

    

    
}

- (IBAction)selectMethodChanged:(id)sender
{

    UISegmentedControl* uis;
    
    uis = (UISegmentedControl*) sender;
    
    methodSelect = (int)[uis selectedSegmentIndex];
    
    //NSLog(@" %d " , methodSelect);
    
    if(portfolioSelect < 3)
    {
        
        [self showPortfolio        : portfolioSelect select:methodSelect];
    }
    else
    {
        [self showPortfolioCompare : portfolioSelect select : methodSelect];
        
    }
    
    
    
    
    
    // [self showPortfolio : portfolioSelect select:methodSelect];
}

- (IBAction)selectPortfolioSecondChanged:(id)sender
{

    UISegmentedControl* uis;
    
    uis = (UISegmentedControl*) sender;
    
    portfolioSelectSecond  = (int)[uis selectedSegmentIndex];
    

    [self showCircle : portfolioSelectSecond select : methodSelectSecond];
    
    
    
}

- (IBAction)valueChangedSecond:(id)sender
{

    UISegmentedControl* uis;
    
    uis = (UISegmentedControl*) sender;
    
    methodSelectSecond = (int)[uis selectedSegmentIndex];
    
    
    [self showCircle : portfolioSelectSecond select : methodSelectSecond];
    

}



-(void)setTotalValue : (float) total
{
    
    
    _resultField.text = [NSString stringWithFormat: @"TOTAL :: %.02f", total];
    
    
    
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // gotoResultSegue
    
    // NSLog(@"In the Seque !!!!!! >>>>>> >>>> >> >> >>>> >>> >> > ");
    
    
    if([[segue identifier] isEqualToString:@"gotoFirstSegue"] ||
       [[segue identifier] isEqualToString:@"swipeToFirstSegue"])
    {
        
        
       ViewController *rv = [segue destinationViewController];
       // NSLog(@"bla 2");
        
       [rv setMortgageFirst      : mortgageFirst]; //    : [portfolioOriginal : result]];
       [rv setMortgageSecond     : mortgageSecond];
       [rv setPortfolioOriginal  : portfolioOriginal];
       [rv setPortfolioBalanced  : portfolioBalanced];
       [rv setPortfolioOptimized : portfolioOptimized];
        
        
        rv.totalLoanAmount = _totalLoanAmount;
        //NSLog(@"in segue %f", _totalLoanAmount);
        
        
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
