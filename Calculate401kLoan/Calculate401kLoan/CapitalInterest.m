//
//  CapitalInterest.m
//  Calculate401kLoan
//
//
//  Created by Andreas Falkenberg on 5/23/15.
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

// calculate multiple capital gains with and without additional payments



#import "CapitalInterest.h"

@implementation CapitalInterest


@synthesize result;


@synthesize capitalArray;
@synthesize interestArray;

@synthesize stdDevArray;
@synthesize timeArray;
@synthesize balanceArray;





-(void)initialize

{
    result        = [[NSMutableArray alloc] init];
    capitalArray  = [[NSMutableArray alloc] init];
    interestArray = [[NSMutableArray alloc] init];
    stdDevArray   = [[NSMutableArray alloc] init];
    timeArray     = [[NSMutableArray alloc] init];
    balanceArray  = [[NSMutableArray alloc] init];
    
    payBack       = 0.0;
    contribute    = 0.0;
    tax           = 0.0;
    
}



-(void)addParameters :(double)c interest : (double)interest stdDev : (double)std time : (double)ti balance : (double)bal
{
    
    [capitalArray addObject: [NSNumber numberWithDouble:c]];
    [interestArray addObject:[NSNumber numberWithDouble:interest]];  // per year
    [stdDevArray addObject:  [NSNumber numberWithDouble:std]];
    [timeArray addObject:    [NSNumber numberWithDouble : ti]];
    [balanceArray addObject : [NSNumber numberWithDouble : bal]];
    
}


-(void)setContribute:(double)cont
{
    contribute = cont;
}

-(void)setTax:(double)tx
{
    tax = tx;
}

-(void)setPayBack:(double)pb
{
    payBack = pb; 
}

// balanced //


-(void)calculateAllWith : (double)pb contribute : (double)cb tax : (double)tx
{
    
    for(int i = 0; i < [capitalArray count]; i++)
    {
        
        double cap;
        double inter;
        double stdDev;
        double interMonth;
        double interPlusStdDev;
        double interMinusStdDev;
        
        double p;
        double t;
        
        cap    = [capitalArray[i]  doubleValue];
        inter  = [interestArray[i] doubleValue];  // needs to be per month
        stdDev = [stdDevArray[i] doubleValue];
        
        
        interMonth        = 100.0*(pow(1.0 + 0.01 * inter, 1.0/12.0) - 1.0);
        
        interPlusStdDev   = 100.0*(pow(1.0 + 0.01 * (inter+stdDev), 1.0/12.0) - 1.0);
        interMinusStdDev  = 100.0*(pow(1.0 + 0.01 * (inter-stdDev), 1.0/12.0) - 1.0);
        
        
        
        //NSLog(@" %f ", interMonth);
        
        
        p  = (pb + (cb/(1.0 - 0.01 * tx)))  * 0.01* [balanceArray[i]  doubleValue];
        
        //NSLog(@"balanceArray %i   %@", i, balanceArray[i] );
        //NSLog(@"contribute  %f ", cb);
        //NSLog(@"Tax         %f ", tx);
        //NSLog(@" pb         %f ", pb);
        //NSLog(@" p          %f ", p);
        
        
        
        t     = [timeArray[i] doubleValue];
       
        [self calculateNextResult : cap interest : interPlusStdDev time : t payment : p];
        [self calculateNextResult : cap interest : interMonth time : t payment : p];
        [self calculateNextResult : cap interest : interMinusStdDev time : t payment : p];
        
        
        
    }
}


-(void)calculateAll
{
    
    //NSLog(@" tax   : %f", tax);
    //NSLog(@" contr : %f", contribute);
    
    
    [self calculateAllWith : payBack contribute : contribute tax : tax];
}






-(void)calculateNextResult : (double)capital interest: (double)interest time : (double)months payment : (double)addPayment
{
    
    
    //NSLog(@" in calculateNext Result");
    NSMutableArray* newResult;
    newResult = [[NSMutableArray alloc]init];
    
    double n1;
    
    n1 = capital;
    
    [newResult addObject:[NSNumber numberWithDouble:n1]];
    
    for(int i = 0; i < months-1; i++)
    {
        
        n1 = n1 * (1.0 + interest / 100.0) + addPayment;
        
        [newResult addObject: [NSNumber numberWithDouble:n1]];
        
    }
    
    [result addObject:newResult];
    
    
}



-(void)addResult : (NSMutableArray* )next
{
    [result addObject:next];

}

-(void)sumResultsAndAdd : (int)index0 index1 : (int)index1 index2 : (int) index2
{
    NSMutableArray* newResult;
    newResult = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < [result[index0] count] ; i++)
    {
        double d0;
        double d1;
        double d2;
        double r;
        
        d0 = [result[index0][i] doubleValue] ;
        d1 = [result[index1][i] doubleValue] ;
        d2 = [result[index2][i] doubleValue];
        
        r = d0 + d1 + d2;
        
        [newResult addObject: [NSNumber numberWithDouble:r]];
        
    }
    
    [result addObject:newResult];
    
}






-(NSMutableArray*) getResult : (int)n
{

    
    return result[n];
    
}


-(int)getCount
{
    return [result count];
}


-(void)print
{
    
    NSLog(@"in p");
    
    for(int i = 0; i < [result count] ; i++)
    {
        NSLog(@"oki"); 
        for(int j=0; j < [result[i] count]; j++)
        {
            NSLog(@" [%d , %d] := %f ", i,j,[result[i][j] doubleValue]) ;
        }
    }
}





@end
