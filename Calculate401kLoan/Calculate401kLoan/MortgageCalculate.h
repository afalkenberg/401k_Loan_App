//
//  MortgageCalculate.h
//  CompareTwoMortgages
//
//
//  Created by Andreas Falkenberg on 5/20/15.
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


#import <Foundation/Foundation.h>
#import "FindPaymentsClass.h"


@interface MortgageCalculate : NSObject


@property  NSNumber* totalAmount; //

@property  NSNumber* principal;  // starting // financed amount !!

@property  NSInteger timeUnit;  // days, months , years , 2xmonths , biweekly

@property  NSNumber* timeSteps; // time steps day, monhs , years



// @property  NSInteger interestUnit;
@property  NSNumber* interestPercent;  // percent interest per unit



@property  NSInteger downPayUnit;

@property  NSNumber* downPayment;

@property  NSInteger pointUnit;

@property  NSNumber* pointPayment;


// @property  NSInteger resultUnit;   ///



@property  NSInteger afterValue;

// @property  NSInteger afterUnit;   /// result after years



/////    here we hold all the results /////

@property  NSNumber* paymentPerUnit;  // i.e. per month

@property  NSMutableArray* principalPerUnitOverTime;
@property  NSMutableArray* interestPerUnitOverTime;


@property  NSNumber* balanceAfterUnits;  // i.e. after x years remaining balance
@property  NSNumber* interestAfterUnits;   // i.e. after x years accumulated interest

@property  NSMutableArray* balanceOverTime;  // principal over time (accumultated)
@property  NSMutableArray* interestOverTime;   // interest over Time  (accumulated)

@property NSMutableArray* totalOverTime;

/// total interest paid

@property NSNumber* totalInterestPaid;

/// total amount paid

@property NSNumber* totalAmountPaid;



/////     x label result  ////

@property  NSMutableArray* xLabel;




/// the following are the real functions ///

@property FindPaymentsClass *findPayment;


///// main function ////

-(void) calculateAll;

-(void) generateXLabel : (bool) extend;   // take n numbers



/////  ------------------------------ /////

-(void) setTimeUnit    : (NSInteger) segment withChange : (bool)change;

-(void) setInterestUnit: (NSInteger)segment withChange:(bool)change; 

-(void) setDownPayUnit : (NSInteger) segment withChange : (bool)change;

-(void) setPointUnit   : (NSInteger) segment withChange : (bool) change;





-(NSNumber*) calculateMonthsFromDays : (NSNumber*) d;
-(NSNumber*) calculateYearsFromDays  : (NSNumber*) d;
-(NSNumber*) calculateMonthPercentFromDays  : (NSNumber*) d;
-(NSNumber*) calculateYearPercentFromDays   : (NSNumber*) d;


-(NSNumber*) calculateDayPercentFromYears : (NSNumber *) d;




@end
