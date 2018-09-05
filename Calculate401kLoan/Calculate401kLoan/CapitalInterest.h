//
//  CapitalInterest.h
//  Calculate401kLoan
//
//
//  Created by Andreas Falkenberg on 7/13/15.
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

@interface CapitalInterest : NSObject

{
    double contribute;
    double payBack;
    double tax;
    
}




// multidimensional array this is the only result we have //

@property  NSMutableArray* result;

@property  NSMutableArray* capitalArray;
@property  NSMutableArray* interestArray;
@property  NSMutableArray* stdDevArray; 
@property  NSMutableArray* timeArray;
@property  NSMutableArray* balanceArray;




-(void)initialize;

-(void)addParameters :(double)c interest : (double)interest stdDev : (double)std time : (double)ti  balance : (double)bal;

-(void)calculateNextResult : (double)capital interest: (double)interest time : (double)months payment : (double)addPayment;



-(void)addResult : (NSMutableArray* )next;

-(void)sumResultsAndAdd : (int)index0 index1 : (int)index1 index2 : (int) index2;


-(NSMutableArray*) getResult : (int)n;

-(int)getCount; 

-(void)calculateAll;

-(void)setContribute:(double)cont;
-(void)setPayBack:(double)pb;
-(void)setTax:(double)tx;



-(void)print; 



@end
