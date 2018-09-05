//
//  MortgageCalculate.m
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


#import "MortgageCalculate.h"

@implementation MortgageCalculate

// all numbers in actual values percent only for display //


@synthesize  totalAmount;



@synthesize  principal;

@synthesize  timeUnit;

@synthesize  timeSteps;


// @synthesize  interestUnit;

@synthesize  interestPercent;


@synthesize  downPayUnit;

@synthesize  downPayment;


@synthesize  pointUnit;

@synthesize  pointPayment;

//@synthesize  resultUnit;


@synthesize  afterValue;

//@synthesize  afterUnit;


// class //

@synthesize  findPayment;



//// results are all here /////

@synthesize  paymentPerUnit;             // i.e. per month

@synthesize  principalPerUnitOverTime;   // display
@synthesize  interestPerUnitOverTime;    // display

@synthesize  balanceAfterUnits;  // i.e. after x years prinicipal portion of pay
@synthesize  interestAfterUnits;   // i.e. after x years interest portion of pay


// the following are going to the graphical output ///

@synthesize  balanceOverTime;  // balance over time (total)
@synthesize  interestOverTime;   // interest over Time  (total paid accumulated)


@synthesize totalInterestPaid;

@synthesize totalAmountPaid;






@synthesize totalOverTime;

@synthesize  xLabel;





/// define the main function here in the front  ///

-(void) calculateAll
{
    
    
    
    
/*    -(NSMutableArray*) resultArray :(double)principal payment : (double) payment interest :(double) interest numberPayments :(int) goalUnits  what : (bool) what
*/
    
/* caluculates also interestPerUnitOverTime */
/* interest over time */
/* principal over time */
    
    
    double tempPoints;
    double tempDown;
    
    tempPoints	= 0.0;
    tempDown    = 0.0;
    
    if(pointUnit == 0)
    {
        
        
        tempPoints = (0.01 * [pointPayment doubleValue]) * ([totalAmount doubleValue] - [downPayment doubleValue]);
        
        
    }
    else if(pointUnit == 1)
    {
        tempPoints = [pointPayment doubleValue];
    }
    
    if(downPayUnit == 0)
    {
        tempDown = [downPayment doubleValue] * [totalAmount doubleValue] * 0.01;
    }
    else if(downPayUnit == 1)
    {
        tempDown = [downPayment doubleValue];
    }
    
    
    principal = [NSNumber alloc];
    
    principal = [principal initWithDouble : [totalAmount doubleValue] - tempDown + tempPoints];
     
    
    [self calculatePaymentPerUnit];

    
    
    if(
       ([principal doubleValue]     > 0.01) &&
       ([timeSteps integerValue]     < 2500) &&
       ([interestPercent doubleValue]	< 300.0))
       
    {
    
    	[self calculatePrincipalPerUnitOverTime];
    
    	[self calculatePAndIAfterUnits: [self afterValue]];
    
        [self generateXLabel : true];
    }
    else
    {
        // set warning here // 
    }
    
    
}



-(void) generateXLabel : (bool) extend
{
    
    xLabel = [[NSMutableArray alloc] init];
    
    int whatever;
    
    whatever = (int)[timeSteps integerValue];
    
    if(extend == true)
    {
        if(whatever < 10)
        {
            whatever = 10;
        }
    }
    
    
    for(int i = 0; i < whatever ; i++ )
    {
        
        NSObject* temp;
       // temp = [[NSString alloc] init];
        
        if(timeUnit == 0)
        {
        
        	temp = [NSString stringWithFormat : @"yr %d", i];
        }
        else if(timeUnit == 1)
        {
            temp = [NSString stringWithFormat : @"mo %d", i];
        }
        else if(timeUnit ==2)
        {
            temp = [NSString stringWithFormat : @"wk %d", i];
        }
        else if(timeUnit == 3)
        {
            temp = [NSString stringWithFormat: @"mo %d", i/2];
        }
        else if(timeUnit == 4)
        {
            temp = [NSString stringWithFormat: @"wk %d", i*2];
        }
                    
        
        
        [xLabel addObject : [NSString stringWithFormat:@"%@",temp]];
        
    }
    
    
}





-(void) calculatePaymentPerUnit
{
    findPayment = [[FindPaymentsClass alloc] init];
    
    
    double p;
    double t;
    double i;
    
    
    p = [[self principal] doubleValue];
    t = [[self timeSteps] doubleValue];
    i = [[self interestPercent] doubleValue];
    
    
   // NSLog(@"principal %f ", p );
   // NSLog(@"time      %f ", t );
   // NSLog(@"percent   %f ", i );
    
    
    
    double ppu;
    
    ppu = [findPayment calculatePaymentFromUnits : t principal: p interest : i];
    
    //examples //
    paymentPerUnit = [[NSNumber alloc]initWithDouble: ppu];
    
    // NSLog(@"ppu %@ ", paymentPerUnit );
}


-(void) calculatePrincipalPerUnitOverTime
{
    findPayment = [[FindPaymentsClass alloc] init];
    
    
    double p;
    double t;
    double i;
    double pay;
    
    p =   [[self principal] doubleValue];
    t =   [[self timeSteps] doubleValue];
    i =   [[self interestPercent] doubleValue];
    pay = [[self paymentPerUnit] doubleValue];
    
    
    // NSLog(@"principal %f ", p );
    // NSLog(@"time      %f ", t );
    // NSLog(@"percent   %f ", i );
    
    principalPerUnitOverTime = [[NSMutableArray alloc] init];
    interestOverTime         = [[NSMutableArray alloc] init];
    totalOverTime            = [[NSMutableArray alloc] init];
    
    NSMutableArray* ppu;
    NSMutableArray* ipu;
    
    /*    -(NSMutableArray*) resultArray :(double)principal payment : (double) payment interest :(double) interest numberPayments :(int) goalUnits  what : (bool) what
     */
    
    
    
    ppu = [findPayment resultArray : p payment : pay interest : i numberPayments: t what : true];
    ipu = [findPayment resultArray : p payment : pay interest : i numberPayments: t what : false];
    
    
    //NSLog(@" %@ ", ppu[0]);
    // NSLog(@" %lu ipu count ", (unsigned long)[ipu count]);
    
    
    double accInterest;
    accInterest = 0.0 ;
    
    for(int i = 0; i < [ipu count] ; i++)
    {
        
        
        NSNumber *ntemp;
        
     //   ntemp  = [[NSNumber alloc] init];
        
        double temp;
        temp = pay - [ipu[i] doubleValue];
        

        
       // NSLog(@"  >>>> >>> >> >> >>> %i >>>>  temp pay ipu %f %f %@", i, temp, pay, ipu[i]);
        
        
        ntemp  = [NSNumber numberWithDouble : temp];
        
        [principalPerUnitOverTime addObject : ntemp];
        
        // ----- ///
        
        NSNumber *accTemp;
        // accTemp  = [[NSNumber alloc] init];
        
        accInterest = accInterest + [ipu[i] doubleValue];
        accTemp     = [NSNumber numberWithDouble : accInterest];
        
        [interestOverTime addObject : accTemp];  // accumulated interest already paid 
        
       // NSLog(@"  >>>> >>> >> >> >>> >>>> %f",accInterest);
        
        NSNumber *accTotal;
        // accTotal = [[NSNumber alloc] init];
        
        accTotal = [NSNumber numberWithDouble: (pay * (i+1))];
        
        [totalOverTime addObject : accTotal];
        
        
    }
    
    
    
    interestPerUnitOverTime  = ipu;   //   i.e. after x years interest portion of pay
    
   
    // the following are going to the graphical output ///
    
    balanceOverTime          = ppu;  // principal over time (total)

    
    totalAmountPaid = [NSNumber numberWithDouble: [totalOverTime[[totalOverTime count] - 1] doubleValue]];
    
    // totalAmountPaid          = totalOverTime[[totalOverTime count] - 1];
    
    
    totalInterestPaid = [NSNumber numberWithDouble: [interestOverTime[[ipu count] - 1] doubleValue]];
    

   // NSLog( @" was soll das denn hier ");
   // NSLog(@" %@", totalInterestPaid);
    
    
}




-(void) calculatePAndIAfterUnits : (NSInteger) n
{
    
    
    
    if(n == 0)
    {
        balanceAfterUnits  =  principal;
    }
    
    
    else
    {
    	if([balanceOverTime count] > n - 1)  // was [self afterValue]
    	{
    		balanceAfterUnits   = balanceOverTime[n-1];
    		interestAfterUnits	= interestOverTime[n-1];
        
        	// NSLog(@" pafterU %@ ", balanceAfterUnits);
    	}
        else
        {
            balanceAfterUnits   = [NSNumber numberWithDouble: 0.0];
            interestAfterUnits	= [NSNumber numberWithDouble: 0.0];
        }
    }
    
}





///

/// call this one last ! ! !

-(void) setTimeUnit : (NSInteger) segment withChange : (bool)change
{
    
    double oldTimestep;
    double midTimestep;
    double newTimestep;
    
    newTimestep = 0.0;
    
    oldTimestep = [timeSteps doubleValue];
    
    
    if(change == true)
    {
        // normalise to weeks
    	if(timeUnit == 0) // years
    	{
            midTimestep = oldTimestep * (365.25/7.0); //weeks
        }
        else if(timeUnit == 1) // months
        {
            midTimestep = oldTimestep * (30.4375/7.0);
        }
        else if(timeUnit == 2)
        {
            midTimestep = oldTimestep; // week
        }
        else if(timeUnit == 3)  // 2x months
        {
            midTimestep	= oldTimestep * (30.4375/14.0);
        }
        else if(timeUnit == 4)  // biweekly
        {
            midTimestep = oldTimestep * 2.0;
        }
        else
        {
            midTimestep	= oldTimestep;
        }
        
        /// now calculate new Timestep
        
        if(segment == 0)  // years
        {
            newTimestep = midTimestep / (365.25/7.0);
        }
        else if(segment == 1) // month
        {
            newTimestep = midTimestep / (30.4375/7.0);
        }
        else if(segment == 2)  // weeks
        {
            newTimestep = midTimestep;
        }
        else if(segment == 3)  // 2xmonths
        {
            newTimestep	= midTimestep /(30.4375/14.0);
        }
        else if(segment == 4) // biweekly
        {
            newTimestep	= midTimestep / 2.0;
        }
        
        
        
    }
    else
    {
        newTimestep	= oldTimestep;
    }
    
    if(newTimestep < 1.0)
    {
        newTimestep = 1.0; 
    }
    
    timeSteps = [[NSNumber alloc] initWithDouble: newTimestep];
    
    timeUnit  = segment;
    
    
    
}



-(void) setDownPayUnit : (NSInteger) segment withChange : (bool)change
{
 
    double dtotal;
    
    double oldValue;
    double newValue;
    
    
    dtotal     = [totalAmount doubleValue];
    oldValue   = [downPayment doubleValue];
    newValue   = 0.0;
    
    if(change == true)
    {
        if(downPayUnit == 0)  // percent
        {
            
            if(segment == 1)  // absolut
            {
                newValue =  (dtotal * oldValue) / 100.0;
            }
            else
            {
                newValue = oldValue;
            }
        }
        else if(downPayUnit == 1) // absolut
        {
            
            if(segment == 0)
            {
                newValue = 100.0 * oldValue / dtotal;
            }
            else
            {
                newValue = oldValue;
            }
        }
        
    }
    else
    {
        newValue = oldValue;
    }
    
    downPayment = [[NSNumber alloc] initWithDouble: newValue];
    downPayUnit = segment;
    
}


-(void) setInterestUnit:(NSInteger)segment withChange:(bool)change
{
    
    
    double oldInterest;
    double midInterest;
    double newInterest;
    
    oldInterest = [interestPercent doubleValue] ;
    midInterest = 0.0;
    
    
    if(change == true)
    {
        
        
        if(timeUnit == 0)  // years
        {
            if(segment == 1)  // years -> months
        	{
            	midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/12.0);
        	}
        	else if(segment == 2)  // years -> weeks
        	{
            	midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/(365.25/7.0));
        	}
            else if (segment == 3)   // 2x per month
            {
                midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/24.0);
            }
            else if (segment == 4)   // bi weekly
            {
                midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/(365.25/14.0));
            }
            else
            {
                midInterest = 1.0 + 0.01 * oldInterest;
            }
        }
            
        else if(timeUnit == 1)  // months
        {
            if(segment == 0)  // months -> years
        	{
            	midInterest	= pow((1.0 + 0.01 * oldInterest), 12.0);
        	}
        	else if(segment == 2)  // months -> weeks
        	{
            	midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/(30.4375/7.0));
        	}
            else if(segment == 3)  // 2x per month
            {
            	midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/2.0);
            }
            else if(segment == 4)  // biweekly
            {
                midInterest	= pow((1.0 + 0.01 * oldInterest), 1.0/(30.4375/14.0));
            }
            
            else
            {
                midInterest = 1.0 + 0.01 * oldInterest;
            }
        }
        
        else if(timeUnit == 2)
        {
            if(segment == 0)  // weeks -> years
        	{
            	midInterest	= pow((1.0 + 0.01 * oldInterest), (365.25/7.0));
        	}
        	else if(segment == 1)  // weeks -> months
        	{
            	midInterest = pow((1.0 + 0.01 * oldInterest), (30.4375/7.0));
        	}
            
            else if(segment == 3) // weeks -> 2x per month
            {
                midInterest = pow((1.0 + 0.01 * oldInterest), (30.4375/14.0));
            }
            
            else if(segment == 4)  // weeks -> biweekly
            {
                midInterest = pow((1.0 + 0.01 * oldInterest), 2.0);
            }
            
            else
            {
                midInterest = 1.0 + 0.01 * oldInterest;
            }
            
        }
        
        else if(timeUnit == 3 )  //twice a month
        {
            if(segment == 0)  // 2month -> years
            {
                midInterest	= pow((1.0 + 0.01 * oldInterest), 24.0);
            }
            else if(segment == 1)  // 2month -> months
            {
                midInterest = pow((1.0 + 0.01 * oldInterest), 2.0);
            }
            
            else if(segment == 2) // 2xmonths -> weeks
            {
                midInterest = pow((1.0 + 0.01 * oldInterest), 2.0/(30.4375/7.0));
            }
            
            else if(segment == 4)  // 2xmonths -> biweekly
            {
                midInterest = pow((1.0 + 0.01 * oldInterest), 2.0/(30.4375/14.0));
            }
            
            else
            {
                midInterest = 1.0 + 0.01 * oldInterest;
            }

            
        }
        
        else if(timeUnit == 4)   // biweekly
        {
            if(segment == 0)  // biweekly -> years
            {
                midInterest	= pow((1.0 + 0.01 * oldInterest), (365.25/14.0));
            }
            else if(segment == 1)  // biweekly -> months
            {
                midInterest = pow((1.0 + 0.01 * oldInterest), (30.4375/14.0));
            }
            
            else if(segment == 2) // biweekly -> weeks
            {
                midInterest = pow((1.0 + 0.01 * oldInterest), 1.0/2.0);
            }
            
            else if(segment == 3)  // biweekly -> 2xmonth
            {
                midInterest = pow((1.0 + 0.01 * oldInterest), 30.4375/28.0);
            }
            
            else
            {
                midInterest = 1.0 + 0.01 * oldInterest;
            }
            

        }
        
        
        
        
    }
    
    newInterest = (midInterest - 1.0) * 100.0;
    
    interestPercent = [[NSNumber alloc] initWithDouble: newInterest];
    
    // interestUnit    = segment;
    
    
    
    
}



//// continue here  ////


-(void) setPointUnit:(NSInteger)segment withChange:(bool)change

{
    double dprinc;
    
    double oldValue;
    double newValue;
    
    
    dprinc    = [totalAmount  doubleValue]  -  [downPayment doubleValue];
    oldValue  = [pointPayment    doubleValue];
    newValue  = 0.0;
    
    
    if(change == true)
    {
        if(pointUnit == 0)  // percent
        {
            
            if(segment == 1)  // absolut
            {
                newValue =  dprinc * oldValue / 100.0;
            }
            else
            {
                newValue = oldValue;
            }
        }
        else if(pointUnit == 1) // absolut
        {
            
            if(segment == 0)
            {
                newValue = 100.0 * oldValue / dprinc;
            }
            else
            {
                newValue = oldValue;
            }
        }
        
    }
    else
    {
        newValue = oldValue;
    }
    
    pointPayment = [[NSNumber alloc] initWithDouble: newValue];
    pointUnit = segment;


    
    
}



//// ------- /////




-(NSNumber*) calculateMonthsFromDays : (NSNumber*) d
{
    
    double dd;
    dd = [d doubleValue];
    
    double months;
    months = dd / 30.4375;
    
    NSNumber* res = [[NSNumber alloc] initWithDouble: months];
    
    return res;
}


-(NSNumber*) calculateYearsFromDays  : (NSNumber*) d
{
    double dd;
    dd = [d doubleValue];
    
    double months;
    months = dd / 365.25;
    
    NSNumber* res = [[NSNumber alloc] initWithDouble: months];
    
    return res;
    
}





-(NSNumber*) calculateMonthPercentFromDays : (NSNumber*) d
{
    // real Percent rate based on daily Percent
    
    double dint;
    dint = [d doubleValue];
    dint = pow((1.0 + dint),30.4375);
    
	NSNumber* res = [[NSNumber alloc] initWithDouble:dint];

	return res;
}


-(NSNumber*) calculateYearPercentFromDays  : (NSNumber*) d
{
    
    double dint;
    dint = [d doubleValue];
    dint = pow((1.0 + dint),365.25);
    
    NSNumber* res = [[NSNumber alloc] initWithDouble:dint];
    
    return res;
}

-(NSNumber*) calculateDayPercentFromYears : (NSNumber *) d
{
    double dint;
    dint = [d doubleValue];
    dint = pow((1.0 + dint),1.0/365.25);
    
    NSNumber* res = [[NSNumber alloc] initWithDouble:dint];
    
    return res;
}







@end
