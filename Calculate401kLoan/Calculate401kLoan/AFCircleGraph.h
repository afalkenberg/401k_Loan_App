//
//  AFCircleGraph.h
//  GraphLibrary
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


IB_DESIGNABLE


@interface AFCircleGraph : UIView

{
    
    NSMutableArray *xLabels;
    
    NSMutableArray *aValues;  /// first set of values
    
    NSMutableArray *colorValues;
    
    NSMutableArray *radiusValue;
    
}



- (id)initWithFrame:(CGRect)theFrame;
- (id)initWithCoder:(NSCoder*)coder;


@property (nonatomic) IBInspectable UIColor *fillColor;

@property (nonatomic) IBInspectable NSInteger fSize;

@property (nonatomic) IBInspectable NSInteger lineWidth;

@property (nonatomic) IBInspectable CGFloat   xShift;


// the absolute width in x direction
@property (nonatomic) IBInspectable CGFloat xWidthMult;
@property (nonatomic) CGFloat xWidth;


// @property float xWidth;
// the hight of the box in y dirction
@property (nonatomic) IBInspectable CGFloat yHightMult;
@property (nonatomic) CGFloat yHight;


// the maximum value in Y direction
// the idea is that this fills the room
@property (nonatomic) IBInspectable CGFloat maxYValue;

@property (nonatomic) IBInspectable CGFloat stepSize;

@property (nonatomic) IBInspectable  NSInteger xsteps;


// the following are the correct ones //

@property (nonatomic) IBInspectable CGFloat xCenter;
@property (nonatomic) IBInspectable CGFloat yCenter;
@property (nonatomic) IBInspectable CGFloat gap;





// An action that triggers showing the view.
- (void)somethingChanged;


-(void)setXLabels: (NSMutableArray*) x;

/** two dimensional array **/

-(void)setaValues: (NSMutableArray*) y;
-(void)setColors:  (NSMutableArray*)  c;
-(void)setRadius:  (NSMutableArray*) r;

// sets parameters automatically based on data
// overwrites data given through xcode gui


-(void)initDefault;



// takes xValues and yValues


-(void) drawText: (NSString*) txt centerx :(float)cx centery :(float)cy distance :(float)d angle :(float) a;


-(void)drawPie : (float)cx centery : (float)cy radius : (float)ra startAngle :(float) sa endAngle : (float)ea;
-(void)drawPartialCircle : (float)cx centery : (float)cy radius1 : (float)ra1 radius2 : (float)ra2 startAngle :(float) sa endAngle : (float)ea;


-(void)drawPartialCircleWithPie : (BOOL) pie; 

-(void) drawRect:(CGRect)rect;


@end
