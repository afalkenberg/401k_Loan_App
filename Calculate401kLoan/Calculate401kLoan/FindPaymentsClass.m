//
//  FindPaymentsClass.m
//  CompareTwoMortgages
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

#import "FindPaymentsClass.h"

@implementation FindPaymentsClass


/// goal describes the principal we want to have left ///
/// this calculates the number of time units to pay ///
/// with the given payments as inputs  ///


@synthesize  anzahlPayments;
@synthesize  thePayment;
@synthesize  paymentTooLow;





-(double)calculateUnitsFromPrincipal :(double)principal payment : (double) payment interest :(double) interest goal :(double) goal what :(bool) what
{
    
    paymentTooLow = false;
    int nrPayments;
    nrPayments = 0;
    double p = principal;
    
    // NSLog(@" goal %f",goal);
    
    if(p * 0.01*interest >= payment)
    {
        // this has to be checked
        if(what == true)
        {
            paymentTooLow = true;
        	return (double) -1.0;
        }
        else
        {
            paymentTooLow = true;
            return (double) -1.0;
        }
    }
    
    while(p * (1.0 + (0.01*interest)) > goal + payment)
    {
        nrPayments++;
        p = (p * (1.0 + (0.01*interest))) - payment;
        
    }
    
    // units = (double)nrPayments;
    
    // NSLog(@"anzahl und principal %i %f",nrPayments, p);
    
    thePayment     = [[NSNumber alloc] initWithDouble : p];
    anzahlPayments = [[NSNumber alloc] initWithInt : nrPayments];
    
    if(what == true)
    {
    
        return (double) nrPayments;
    }
    else
    {
        return p;  // payment
    }
    
}



// given the principal units and interest the following
// provides the payment per time unit
// trying to keep rest at 0.0


-(double)calculatePaymentFromUnits : (double) goalUnits principal : (double) principal interest :(double) interest
{
    
   // double stepSize;
    double localUnits;
    
    double payment     = principal ; // maybe good starting value
    double paymentUp   = 2.0*principal; //
    double paymentDown = 0.0;
    
   // stepSize = principal / 2.0;
    
    bool contFlag;
    contFlag = true;
   // bool badResult;
   // badResult = false;
    
    
    int ctr;
    ctr = 0;
    while(contFlag && ctr < 100)   /// bad result == true ?
    {
        localUnits = [self calculateUnitsFromPrincipal: principal payment : payment interest : interest goal : 0.0 what : true];
        
        
     //   NSLog(@" goal units = %f",goalUnits);
     //   NSLog(@" loc  units = %f",localUnits);
     //   NSLog(@" counter   = %d",ctr);
     //   NSLog(@" payment = %f" , payment);
        
        //if(localUnits == -1.0)
        //{
        //    badResult = true;
        //}
        
        if(paymentTooLow == true)
        {
            if(payment < 0.0)
            {
                payment = 0.0 - payment;
            }
            
            paymentDown =   payment;  // pull low edge up
            
            payment     =   (payment + paymentUp) / 2.0;  // pull payment up half
            paymentUp   =   paymentUp * 2.0;    /// pull upper edge up !
          //  NSLog(@"payment Up : %f ", paymentUp );
            
        }
        else
        {
        	if(goalUnits  >  localUnits)  // payment is too high !
        	{
            	// payment = payment - stepSize;
            	paymentUp   = payment;                       // pull upper edge down
            	payment     = (payment + paymentDown)/2.0;   // reduce payment
            	paymentDown = paymentDown;                   // keep lower edge also
            
        	}
        	else if(goalUnits < localUnits)  // payment is too low
        	{
            	// payment = payment + stepSize;
            	paymentDown = payment;                  // pull lower edge up
            	payment     = (payment + paymentUp) / 2.0; // pull payment up
            	paymentUp   = paymentUp;                // keep upper edge

        	}
        	else if(goalUnits == localUnits)
        	{
            
            //refine obviously rest is greater
            	double rest;
            
            	rest = [self calculateUnitsFromPrincipal: principal payment : payment interest : interest goal : 0.0 what : false];
            
            	// NSLog(@" rest %f",rest);
            
            	if(rest <= 0.1)
            	{
                	contFlag = false;
            	}
            	else   // payment is a bit too low
            	{
                // payment = payment + stepSize;
                paymentDown = payment;    // pull lower edge up
                payment     = (payment + paymentUp) / 2.0;
                paymentUp   = paymentUp;  // keep upper edge
            	}
        	}
        
        }
        ctr++;
        
    }
    
    // NSLog(@"in function payment  %f ",payment );
    
    return payment;
    
}



-(NSMutableArray*) resultArray :(double)principal payment : (double) payment interest :(double) interest numberPayments :(int) goalUnits  what : (bool) what

{
    
    // principal 0;  on a monthly basis
    // interest  1;
    
    
    double pnew;
    double inew;
    double iold;
    pnew = principal;
    inew = principal * 0.01*interest;
    
    
    NSMutableArray* arrayOfInterest;
    
    arrayOfInterest = [[NSMutableArray alloc] init];
    
    for(int i=0; i < goalUnits; i++)
    {
        iold = inew;
        pnew = pnew * (1.0 + (0.01*interest)) - payment;
        inew = pnew * interest*0.01;
        
        
       // NSLog(@"pnew nnew  %f %f", pnew, inew);
        
        NSNumber* temp;
        
        temp   =  [NSNumber alloc];
        
        if(what == true)
        {
           temp   =  [temp initWithDouble: pnew]; // principal
        }
        else
        {
            temp  =  [temp initWithDouble: iold];
        }
            
        [arrayOfInterest addObject: temp];
        
    }
    
    
    return arrayOfInterest	;
}



@end
