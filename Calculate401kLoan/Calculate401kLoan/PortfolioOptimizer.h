//
//  PortfolioOptimizer.h
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


#import <Foundation/Foundation.h>

@interface PortfolioOptimizer : NSObject

{
    
    double totalLoanAmount;
    
    double capital[3];
    double interest[3];

    int orderPtr[3];
    
    
    double capitalBalanced[3];
    double capitalOptimized[3];
    
    
}


-(void)setCapital : (double[3]) c;

-(void)setInterest : (double[3]) i;

-(double)getCapitalBalanced  : (int)i;
-(double)getCapitalOptimized : (int)i;

-(void)setTotalLoan : (double) tl;

-(void)calculatePortfolioBalanced;

-(void)calculatePortfolioOptimized; 

-(void)findNext; 



@end
