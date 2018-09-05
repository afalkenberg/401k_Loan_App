//
//  AFCircleGraph.m
//  GraphLibrary
//
//
//  Created by Andreas Falkenberg on 6/29/15.
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

#import "AFCircleGraph.h"

@implementation AFCircleGraph

@synthesize lineWidth;
@synthesize xShift;   // label text shift

@synthesize xWidthMult;

@synthesize xWidth;

@synthesize yHightMult;
@synthesize yHight;

@synthesize xsteps;


@synthesize xCenter;
@synthesize yCenter;
@synthesize gap;



- (id)initWithFrame:(CGRect)theFrame {
    self = [super initWithFrame:theFrame];
    if (self) {
        [self initDefault];
    }
    return self;
}


- (id)initWithCoder:(NSCoder*)coder
{
    if ((self = [super initWithCoder:coder])) {
        [self initDefault];
    }
    return self;
}


-(void)initDefault
{
    
    // xWidth    = 210.0;
    // yHight    = 140.0;  // PHYSICAL SIZE
    
    
    
    
    xLabels     = [[NSMutableArray alloc] init];
    
    aValues     = [[NSMutableArray alloc] init];
    colorValues = [[NSMutableArray alloc] init];
    
    radiusValue = [[NSMutableArray alloc] init];
    
    
    NSNumber* n0 = [[NSNumber alloc] initWithFloat:30.0];
    NSNumber* n1 = [[NSNumber alloc] initWithFloat:20.0];
    NSNumber* n2 = [[NSNumber alloc] initWithFloat:10.0];
    
    NSString* l0 = @"";
    NSString* l1 = @"";
    NSString* l2 = @"";
    NSString* l3 = @"";
    
    
    [xLabels addObject:l0];
    [xLabels addObject:l1];
    [xLabels addObject:l2];
    [xLabels addObject:l1];
    [xLabels addObject:l3];
    [xLabels addObject:l0];
    [xLabels addObject:l3];
    [xLabels addObject:l2];
    [xLabels addObject:l3];
    
    
    [aValues insertObject:[NSMutableArray arrayWithObjects:n0,n1,n2,nil] atIndex:0];
   // [aValues insertObject:[NSMutableArray arrayWithObjects:n2,n2,n1,nil] atIndex:1];
   // [aValues insertObject:[NSMutableArray arrayWithObjects:n0,n2,n1,nil] atIndex:2];
   // [aValues insertObject:[NSMutableArray arrayWithObjects:n0,n0,n0,nil] atIndex:3];
    
    
    [colorValues insertObject:[UIColor redColor] atIndex:0];
    [colorValues insertObject:[UIColor greenColor] atIndex:1];
    [colorValues insertObject:[UIColor orangeColor] atIndex:2];
    [colorValues insertObject:[UIColor yellowColor] atIndex:3];
    
    
    [radiusValue insertObject:[[NSNumber alloc] initWithFloat:80.0] atIndex:0];
   // [radiusValue insertObject:[[NSNumber alloc] initWithFloat:60.0] atIndex:1];
   // [radiusValue insertObject:[[NSNumber alloc] initWithFloat:70.0] atIndex:2];
   // [radiusValue insertObject:[[NSNumber alloc] initWithFloat:80.0] atIndex:3];
    
    
    
    //_lineColor  = [UIColor blackColor];
    
}


-(void)setXLabels:(NSMutableArray *)x
{
    xLabels = x;
}


/** lets set these in percent of the circle 
 */


-(void)setaValues:(NSMutableArray *)y
{
    aValues = y;
}




-(void)setColors:(NSMutableArray *) c
{
    colorValues	= c;
}


-(void)setRadius:(NSMutableArray*) r
{
    radiusValue = r;
}





-(void) drawText: (NSString*) txt centerx :(float)cx centery :(float)cy distance :(float)d angle :(float) a
{
    
    
    float xloc;
    float yloc;
    
    xloc = cx + d * cos(a);
    yloc = cy + d * sin(a);

    CGPoint textPoint = CGPointMake(xloc , yloc);
    
    
    
    NSDictionary* dict = @{NSFontAttributeName : [UIFont systemFontOfSize : _fSize]};
    
    [txt drawAtPoint:textPoint withAttributes:dict];
    
    
}





-(void)drawPie : (float)cx centery : (float)cy radius : (float)ra startAngle :(float) sa endAngle : (float)ea
{
    
    float centerx = cx;
    float centery = cy;
    
    float radius = ra;
    
    float startAngle = sa;
    float endAngle   = ea;
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath (context);
    
    CGContextMoveToPoint(context, centerx,centery);
  
    CGContextAddArc(context, centerx,centery,radius,startAngle,endAngle,0);
    
    
    CGContextClosePath(context);
    
    
    CGContextFillPath(context);
    
    CGContextStrokePath(context);
    
}



// : (float) r radius : (float)r2 centerX : (float)cx centery :(float)cy startAngle : (float)a endAngle : (float)b

-(void)drawPartialCircle : (float)cx centery : (float)cy radius1 : (float)ra1 radius2 : (float)ra2 startAngle :(float) sa endAngle : (float)ea
{
    
    
    float centerx = cx;
    float centery = cy;
    
    float radius  = ra1;
    float radius2    = ra2;
    
    float startAngle = sa;
    float endAngle   = ea;
    
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    
    CGContextBeginPath (context);
    
    CGContextAddArc(context, centerx,centery,radius,startAngle,endAngle,0);
    
    CGContextAddArc(context, centerx, centery, radius2, endAngle, startAngle, 1);
    
    
    CGContextClosePath(context);
    CGContextFillPath(context);
    
    CGContextStrokePath(context);
    
    
    
}



/** takes the colorValues and the
*/

-(void)drawPartialCircleWithPie : (BOOL) pie
{
    
    float radiusa;
    float radiuse;
    
    float sa;
    float se;
    
    sa = 0.0;
    se = 0.0;

    radiusa = 0.0;
    
    int n;

    n = 0;
    
    radiuse = [radiusValue[0] floatValue];
    
    if(pie == YES)
    {
        
        for (int j = 0; j < [aValues[0] count]; j++ )
        {
        
            
        	UIColor* temp;
        	temp = colorValues[j];
        
        	[temp set];
        
        	se = se + (M_PI * 0.02 * [aValues[0][j] floatValue]);
        
        	[self drawPie : xCenter centery : yCenter radius : radiuse startAngle :sa endAngle : se];
        	sa = se;
        }
        n = 1;
        radiusa = radiuse + gap;
    }
    
    
    for(int i = n; i < [aValues count] ; i++)
    {
        sa = 0.0;
        se = 0.0;
        
        radiuse = [radiusValue[i] floatValue];

        for (int j = 0; j < [aValues[i] count]; j++ )
        {
            
            UIColor* temp;
            temp = colorValues[j];
            
            [temp set];
            
	        se = se + (M_PI * 0.02 * [aValues[i][j] floatValue]);
            
            [self drawPartialCircle : xCenter centery : yCenter radius1 : radiuse radius2 : radiusa startAngle :sa endAngle : se];
            sa = se;
        
        }
        
        radiusa = radiuse + gap;
     
        
    }
}


-(void)drawText
{
    
    int n;
    n = [radiusValue count];
    
    float distance;
    float sa;
    float se;
    float ang;
    
    sa = 0.0;
    se = 0.0;
    
    
    distance = [radiusValue[n-1] floatValue] ;
    
    for (int j = 0; j < [aValues[n-1] count]; j++ )
    {
        
        NSString *tempTxt;
        tempTxt = xLabels[j];
        
        UIColor* temp;
        temp = [UIColor blackColor];      //colorValues[j];
        
        [temp set];
        
        se = se + (M_PI * 0.02 * [aValues[n-1][j] floatValue]);
        
        ang = sa + (se-sa)/2.0;
        
        [self drawText :  tempTxt centerx : xCenter-15 centery : yCenter-5 distance  : 0.6*distance angle: ang ];
        sa = se;
        
    }
    
}



- (void)drawRect:(CGRect)rect

{
    
    
    // [self initDefault];
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();  // old
    CGRect       myFrame = self.bounds;       // new
    
    yHight      = self.bounds.size.height  * yHightMult;
    xWidth      = self.bounds.size.width   * xWidthMult;
    
    CGContextSetLineWidth(context, lineWidth);   // new
    
    CGRectInset(myFrame, 5,5);  // new
    [_fillColor set];        //  ??
    
    UIRectFrame(myFrame);       // new
    
    
    [self drawPartialCircleWithPie : YES];
    
    // [self drawPartialCircle : 100 centery: 100 radius1:70 radius2:60 startAngle:0.0 endAngle:M_PI];
    // [self drawText:@"bla" centerx:100 centery:100 distance:85 angle:M_PI];
    [self drawText];
    

    
}



-(void)somethingChanged
{
    
    
    [self setNeedsDisplay];
    
}





@end
