//
//  PortfolioOptimizer.m
//  Calculate401kLoan
//
//
//  Created by Andreas Falkenberg on 7/16/15.
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


#import "PortfolioOptimizer.h"

@implementation PortfolioOptimizer


-(void)setCapital : (double[3]) c
{
    capital[0] = c[0];
    capital[1] = c[1];
    capital[2] = c[2];
    
}

-(void)setInterest : (double[3]) i
{
    interest[0] = i[0];
    interest[1] = i[1];
    interest[2] = i[2];
    
}

-(void)setTotalLoan : (double) tl
{
    totalLoanAmount	= tl;
}



-(void)calculatePortfolioBalanced
{
    double norm;
    
    norm = 0.0;
    for(int i =0; i<3; i++)
    {
        norm += capital[i];
    }
    
    for(int i =0; i<3; i++)
    {
        double p;
        p = capital[i] / norm;
        capitalBalanced[i] = capital[i] - totalLoanAmount * p;
    }
    
}


-(void)findNext
{
 
    orderPtr[0] = 0;
    orderPtr[1] = 0;
    orderPtr[2] = 0;
    
    if(interest[0] < interest[1])  // 0 < 1
    {
        orderPtr[1] = orderPtr[1] + 1;
    }
    else
    {
        orderPtr[0] += 1;
    }
    
    if(interest[1] < interest[2])  // 0 < 1 < 2
    {
        orderPtr[2] += 1;
    }
    else
    {
        orderPtr[1] += 1;
    }
    
    if(interest[0] < interest[2]) // 1<0<2
    {
        orderPtr[2] += 1;
    }
    else
    {
        orderPtr[0] += 1;
    }
    
    
    
}


-(void)calculatePortfolioOptimized
{
    
    [self findNext];
    
    // find the lowest interest
    double rest;
    rest = totalLoanAmount;
    
    
    for(int i = 0; i < 3; i++)
    {
    
        if(rest < capital[orderPtr[i]])
        {
            capitalOptimized[orderPtr[i]] = capital[orderPtr[i]] - rest;
            rest = 0.0;
        }
        else // rest > firstCapital
        {
            capitalOptimized[orderPtr[i]] = 0.0;
            rest = rest - capital[orderPtr[i]];
        }
    }
    
    
}


-(double)getCapitalBalanced  : (int)i
{
    return capitalBalanced[i];
}

-(double)getCapitalOptimized : (int)i
{
    return capitalOptimized[i];
}



//---- payment calculation  ----- //






@end
