//
//  FindPaymentsClass.h
//  CompareTwoMortgages
//
//
//  Created by Andreas Falkenberg on 5/23/16.
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

@interface FindPaymentsClass : NSObject


// berechnet wielange man zahlen muss bis auf null runter //


@property  NSNumber* anzahlPayments;
@property  NSNumber* thePayment;
@property  bool      paymentTooLow;



-(double)calculateUnitsFromPrincipal :(double)principal payment : (double) payment interest :(double) interest goal :(double) goal what:(bool) what;

-(double)calculatePaymentFromUnits : (double) goalUnits principal : (double) principal interest :(double) interest;

-(NSMutableArray*) resultArray :(double)principal payment : (double) payment interest :(double) interest numberPayments :(int) goalUnits what : (bool) what;



@end
