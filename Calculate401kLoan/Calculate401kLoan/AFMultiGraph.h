//
//  AFMultiGraph.h
//  GraphLibrary
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


#import <UIKit/UIKit.h>



IB_DESIGNABLE


@interface AFMultiGraph : UIView


{
    
    NSMutableArray *xLabels;
    
    NSMutableArray *aValues;      /// set of values in 2 dim array
    
    NSMutableArray *showMask;
    
    NSMutableArray *colorLines;
    NSMutableArray *colorPositive;
    NSMutableArray *colorNegative;
    
}



- (id)initWithFrame:(CGRect)theFrame;
- (id)initWithCoder:(NSCoder*)coder;


@property (nonatomic) IBInspectable UIColor *fillColor;

@property (nonatomic) IBInspectable UIColor *textColor;

@property (nonatomic) IBInspectable UIColor *xColor;

@property (nonatomic) IBInspectable UIColor *yColor;


@property (nonatomic) IBInspectable UIColor *lineColor0;

@property (nonatomic) IBInspectable UIColor *lineColor1;

@property (nonatomic) IBInspectable UIColor *verticalColor0;

@property (nonatomic) IBInspectable UIColor *verticalColor1;



@property (nonatomic) IBInspectable NSInteger fSize;

@property (nonatomic) IBInspectable NSInteger lineWidth;

@property (nonatomic) IBInspectable CGFloat   xoffset;

@property (nonatomic) IBInspectable CGFloat   xShift;

@property (nonatomic) IBInspectable CGFloat   yoffset;

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



// An action that triggers showing the view.
- (void)somethingChanged;


-(void)setXLabels:     (NSMutableArray*) x;
-(void)setaValues:     (NSMutableArray*) y;
-(void)setShowMask:    (NSMutableArray*) s;
-(void)setColorValues: (NSMutableArray*) col positive : (NSMutableArray*) pos negative : (NSMutableArray*) neg;



// sets parameters automatically based on data
// overwrites data given through xcode gui

-(void)autoSize : (bool) yes;



-(void)extendaValues: (NSMutableArray*) y extend : (int)n with : (bool) last;

-(void)initDefault;


-(void) drawXAxis;
-(void) drawYAxis;

// takes xValues and yValues

-(void) drawLines : (NSMutableArray*) aval color : (UIColor*)col; 
-(void) drawLine: (float) xpos0 pos1 : (float)xpos1 value0 : (float) pixv0 value1 : (float) pixv1 color : (UIColor*) col;



-(void) drawXText: (NSString*) txt at: (float) xpos;
-(void) drawYText: (NSString*) txt at: (float) ypos;
-(void) drawRect:(CGRect)rect;


@end
