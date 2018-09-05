//
//  AFMultiGraph.m
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


#import "AFMultiGraph.h"

@implementation AFMultiGraph


@synthesize xoffset;
@synthesize xShift;   // label text shift 

@synthesize yoffset;
@synthesize xWidthMult;

@synthesize xWidth;

@synthesize yHightMult;
@synthesize yHight;

@synthesize maxYValue;
@synthesize stepSize;


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
    // xoffset   = 30.0;
    
    // yoffset   = 10.0;
    // xWidth    = 210.0;
    // yHight    = 140.0;  // PHYSICAL SIZE
    // maxYValue = 45.1;   // maximum on y axis
    // stepSize  = 10.0;
    
    
    
    xLabels = [[NSMutableArray alloc] init];
    
    aValues = [[NSMutableArray alloc] init];
    
    colorLines    = [[NSMutableArray alloc] init];
    colorPositive = [[NSMutableArray alloc] init];
    colorNegative = [[NSMutableArray alloc] init];

    
    showMask  = [[NSMutableArray alloc] init];
    
    
    NSNumber* n0 = [[NSNumber alloc] initWithFloat:30.0];
    NSNumber* n1 = [[NSNumber alloc] initWithFloat:20.0];
    NSNumber* n2 = [[NSNumber alloc] initWithFloat:10.0];
    
    NSString* l0 = @"x";
    NSString* l1 = @"y";
    NSString* l2 = @"z";
    NSString* l3 = @"a";
    
    
    [xLabels addObject:l0];
    [xLabels addObject:l1];
    [xLabels addObject:l2];
    [xLabels addObject:l1];
    [xLabels addObject:l3];
    [xLabels addObject:l0];
    [xLabels addObject:l3];
    [xLabels addObject:l2];
    [xLabels addObject:l3];
    [xLabels addObject:l2];
    [xLabels addObject:l3];
    [xLabels addObject:l2];
    [xLabels addObject:l3];
    
  /*
    [aValues addObject:n0];
    [aValues addObject:n1];
    [aValues addObject:n2];
    [aValues addObject:n2];
    [aValues addObject:n1];
    [aValues addObject:n0];
    [aValues addObject:n2];
    [aValues addObject:n2];
    [aValues addObject:n2];
  */
    
    
    [aValues insertObject:[NSMutableArray arrayWithObjects:n0,n1,n2,n0,nil] atIndex:0];
    [aValues insertObject:[NSMutableArray arrayWithObjects:n2,n1,n0,n2, nil] atIndex:1];
    [aValues insertObject:[NSMutableArray arrayWithObjects:n0,n2,n1,n2,nil] atIndex:2];
    [aValues insertObject:[NSMutableArray arrayWithObjects:n0,n0,n0,n1,nil] atIndex:3];
    
    
    [colorLines insertObject:[UIColor redColor] atIndex:0];     //between 0 and 1
    [colorLines insertObject:[UIColor greenColor] atIndex:1];   //between 1 and 2
    [colorLines insertObject:[UIColor orangeColor] atIndex:2];  // between 2 and 3
    [colorLines insertObject:[UIColor yellowColor] atIndex:3];  // between 3 and 4
    
    [colorPositive insertObject:[UIColor blueColor] atIndex:0];     //between 0 and 1
    [colorPositive insertObject:[UIColor orangeColor] atIndex:1];   //between 1 and 2
    [colorPositive insertObject:[UIColor redColor] atIndex:2];  // between 2 and 3
    [colorPositive insertObject:[UIColor yellowColor] atIndex:3];  // between 3 and 4
    

    [colorNegative insertObject:[UIColor orangeColor] atIndex:0];     //between 0 and 1
    [colorNegative insertObject:[UIColor blueColor] atIndex:1];   //between 1 and 2
    [colorNegative insertObject:[UIColor redColor] atIndex:2];  // between 2 and 3
    [colorNegative insertObject:[UIColor yellowColor] atIndex:3];  // between 3 and 4
    
    
    
    
    [showMask    insertObject: [NSNumber numberWithBool:true] atIndex: 0];
    [showMask    insertObject: [NSNumber numberWithBool:true] atIndex: 1];
    [showMask    insertObject: [NSNumber numberWithBool:true] atIndex: 2];
    [showMask    insertObject: [NSNumber numberWithBool:true]  atIndex: 3];

    
}


-(void)setXLabels:(NSMutableArray *)x
{
    xLabels = x;
}



/** we only want to use aValues now */

-(void)setaValues:(NSMutableArray *)y
{
    
    aValues = y;
}


-(void)setShowMask:    (NSMutableArray*) s
{
    showMask = s;
}

-(void)setColorValues: (NSMutableArray*) col positive : (NSMutableArray*) pos negative : (NSMutableArray*) neg

{
    colorLines      = col;
    colorPositive   = pos;
    colorNegative   = neg;
    
}




/* lets call this later */

-(void)extendaValues: (NSMutableArray*) y extend : (int)n with :(bool) last
{
    aValues = [[NSMutableArray alloc] init];
    
    for(int i = 0; i  < n ; i++)
    {
        
        if( i < [y count] )
        {
        	[aValues addObject : [y objectAtIndex : i]];
        }
        else
        {
            if( last == true)
            {
            	[aValues addObject : [y objectAtIndex : [y count] - 1]];
            }
            else
            {
                NSNumber *t;
                t = [[NSNumber alloc] initWithDouble:0.0];
                [aValues addObject : t];
        	}
        }
    }
}





-(void)autoSize : (bool) yes
{
    maxYValue = 0.0;
    
    if(yes == true)
    {
        // find maxYValue
        for(int i = 0; i < [aValues count]; i++)
        {
            
            NSMutableArray *temp;
            NSNumber* tempS;
            temp  = [aValues objectAtIndex:i];
            
            tempS = [showMask objectAtIndex :i];
            
            
            if([tempS boolValue] == true)
            {
            
            	for(int j = 0; j < [temp count] ; j++)
            	{
            		if(maxYValue < [[temp objectAtIndex : j] floatValue])
            		{
                		maxYValue = [[temp objectAtIndex: j] floatValue];
                    
                    	// NSLog(@" %d , %d  max y value: %f ",i,j, maxYValue);
                    
            		}
            	}
            }
        }
        
        
    
        /// number of y markers
        
        double sHelp;
        double numLetter;
        numLetter = ceil(log10(maxYValue));
        
        
        sHelp =  pow(10.0,numLetter);
        
        stepSize = sHelp/10.0;
        
        if((maxYValue / stepSize) < 3)
        {
            stepSize = sHelp/ 50.0;
        }
        
        xoffset    = (8 * (numLetter + 1));
        xShift     = (8 * numLetter) + 1;
        xWidthMult =  0.95  - 0.013 * numLetter;
        
        
        /// now we look at the labels ///
        
        _xsteps = [xLabels count] / 10.0;
        
        // NSLog(@"wichtich  %d " , _xsteps);
              
        
        
    }
    // else do nothing i.e. keep settings
    
    
    
}





-(void) drawXAxis
{
    int   n;
    float step;
    
    n =  (int)[aValues[0] count];
    
    step = xWidth/n;
    
    // draw straight line
    
    
    [_xColor set];
    
    
    UIBezierPath* xMain = [UIBezierPath bezierPath];
    [xMain moveToPoint:CGPointMake(xoffset, yHight + yoffset)]; // was yoffset
    [xMain addLineToPoint:CGPointMake(xoffset + xWidth, yHight + yoffset)];  // was yOffset
    [xMain stroke];
    
    // ticks
    
    
    for(int i = 0; i < n; i = i + (int)_xsteps)
    {
        
        [_xColor set];
        
        xMain = [UIBezierPath bezierPath];
        [xMain moveToPoint:CGPointMake(xoffset+step * i + step/2.0 , (yHight + yoffset) + 3)];
        [xMain addLineToPoint:CGPointMake(xoffset+step * i +step/2.0, (yHight + yoffset) - 3)];   // was only yOffset
        [xMain stroke];
        
        
        NSString* txt;
        txt = [xLabels objectAtIndex : i];
        
        float xLabelOffset;
        
        xLabelOffset = 0.0; //  xsteps*step/2.0;
        
        [self drawXText : txt at: xoffset + step * i - xLabelOffset];  /// + step/2.0 ];
        
        
    }
    
    
    
}


-(void) drawYAxis
{
    
    float numStep;
    
    float ystep;
    
    // y direction //
    ystep = stepSize * yHight / maxYValue;
    
    numStep = maxYValue / stepSize;
    
    
    [_yColor set];
    
    
    UIBezierPath* yMain; //  = [UIBezierPath bezierPath];
    
    
    yMain = [UIBezierPath bezierPath];
    
    
    [yMain moveToPoint:CGPointMake(xoffset, (yHight +yoffset))]; // was yoffset
    
    [yMain addLineToPoint:CGPointMake(xoffset, yoffset)];  // was yoffset + yHight
    
    [yMain stroke];
    
    
    // numbers from n here //
    for(int i = 0; i < numStep; i++)
    {
        
        [_yColor set];
        
        yMain = [UIBezierPath bezierPath];
        [yMain moveToPoint:CGPointMake(xoffset -3 , yHight + yoffset - ystep * i   )];
        [yMain addLineToPoint:CGPointMake(xoffset + 3, yHight + yoffset - ystep * i )];
        [yMain stroke];
        
        
        
        NSString* txt;
        txt = [NSString stringWithFormat:@"%i", (int)(stepSize * i)];
        
        [self drawYText : txt at: yHight - ystep * i];
        
        
    }
    
    
    
}



// takes xValues and yValues
-(void) drawLines : (NSMutableArray*) aval color:(UIColor*)col
{
    int n;
    float step;
    
    n = (int)[aval  count];   // was aValues
    
    
    
    
    step = xWidth/n;
    
    
    
    for(int i = 0; i < n-1; i++)
    {
        
        float v0 = [[aval objectAtIndex : i]   floatValue];
        float v1 = [[aval objectAtIndex : i+1] floatValue];
        
        
        // now calculate relative to maxValue
        
        float pixv0;
        pixv0 = yHight * v0/ maxYValue;
        
        float pixv1;
        pixv1 = yHight * v1/ maxYValue;
        
        [col set];
        
        [self drawLine : ((i + 0.5) * step) pos1 : (i+1.5)*step value0 : pixv0 value1 : pixv1 color: col];
        
        
    }
}


-(void) drawVerticalsFrom : (NSMutableArray*) aval to : (NSMutableArray*) bval colorPlus : (UIColor*) colp colorMinus : (UIColor*) coln
{
    int n;
    int m;
    int r;
    float step;
    
    n = (int)[aval count];
    m = (int)[bval count];
    
    // NSLog(@"n %d m  %d", n, m);
    
    
    step = xWidth/n;
    
    
    r = MIN(n,m);
    
    //NSLog(@"r %d ", r);
    
    
    for(int i = 0; i < r; i++)
    {
        float v0 = [[aval objectAtIndex : i] floatValue];
        float v1 = [[bval objectAtIndex : i] floatValue];
        
        
        // now calculate relative to maxValue
        
        float pixv0;
        pixv0 = yHight * v0/ maxYValue;
        
        float pixv1;
        pixv1 = yHight * v1/ maxYValue;
        
        // NSLog(@"pixv0 %f pixv1  %f", pixv0, pixv1);
        
        if(pixv0 > pixv1)
        {
            [self drawLine : ((i + 0.5) * step) pos1 : (i + 0.5)*step value0 : pixv0 value1 : pixv1 color:colp];
            
        }
        else
        {
            [self drawLine : ((i + 0.5) * step) pos1 : (i + 0.5)*step value0 : pixv0 value1 : pixv1 color:coln];
            
        }

        
        
        
        
    }

}




-(void) drawLine: (float) xpos0 pos1 : (float)xpos1 value0 : (float) pixv0 value1 : (float) pixv1 color : (UIColor*) col
{
   // int   n;
   // float barWidth;
    
    // n =  (int)[xLabels count];
    
   // barWidth = (xWidth/n)*0.6; // .9 leaves a little gap
    
    // [_fillColor set];
    
    UIBezierPath* barMain = [UIBezierPath bezierPath];
    
    [barMain moveToPoint:CGPointMake(xoffset + xpos0, yoffset + yHight - pixv0)];
    
   // [barMain addLineToPoint:CGPointMake(xoffset + xpos +0.5*barWidth , yoffset + yHight)];
    
   // [barMain addLineToPoint:CGPointMake(xoffset + xpos +0.5*barWidth , yHight + yoffset - ypos )];
    
    [barMain addLineToPoint:CGPointMake(xoffset + xpos1  , yHight + yoffset - pixv1 )];
    
    [barMain closePath];
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Shadow for now we leave it here //
    CGContextSetShadow(context, CGSizeMake(8,8), 4);
    
    
    [col set];
    
    [barMain fill];
    
    [barMain stroke];
    
    
}







-(void) drawXText: (NSString*) txt at: (float) xpos
{
    
    
    // UIFont *smallFont = [UIFont systemFontOfSize : _fSize];
    CGPoint textPoint = CGPointMake(xpos,yHight + yoffset + 2);
    
//    [_textColor set];
    
    
    // NSDictionary* dict = @{NSFontAttributeName : [UIFont systemFontOfSize : _fSize]};
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjects: @[[UIFont systemFontOfSize : _fSize], _textColor] forKeys: @[NSFontAttributeName, NSForegroundColorAttributeName]];
    
   // CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor yellowColor]);
    
    [txt drawAtPoint:textPoint withAttributes:dict];
    
//    [txt drawAtPoint: textPoint withFont:smallFont];
    
   
    
}








-(void) drawYText: (NSString*) txt at: (float) ypos
{
    
    
    
    // UIFont *smallFont = [UIFont systemFontOfSize: _fSize];  /// was 8
    CGPoint textPoint = CGPointMake(xoffset - xShift , yoffset + ypos - (_fSize/2) );
    
    
    // [_textColor set];
    
    // NSDictionary* dict = @{NSFontAttributeName : [UIFont systemFontOfSize : _fSize]};
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjects: @[[UIFont systemFontOfSize : _fSize], _textColor] forKeys: @[NSFontAttributeName, NSForegroundColorAttributeName]];

    
    [txt drawAtPoint:textPoint withAttributes:dict];
    
    
}


-(void)drawAllLines
{
    for(int i = 0; i < [aValues count]; i ++)
    {
    
        NSNumber *temp;
        temp = showMask[i];
        
        if([temp boolValue] == true)
        {
        	[self drawLines : aValues[i] color:(UIColor*)colorLines[i]];
        }
    }
    
    
    for(int j = 0; j < [aValues count] - 1; j++)
    {
        
        NSNumber *tempa;
        tempa = showMask[j];
        NSNumber *tempb;
        tempb = showMask[j+1];
        
        if(([tempa boolValue] == true) && ([tempb boolValue] == true))
        {
        	[self drawVerticalsFrom : aValues[j] to : aValues[j+1] colorPlus: (UIColor*)colorPositive[j] colorMinus:(UIColor*)colorNegative[j]];
        }
        
    }
    
    
    
}





- (void)drawRect:(CGRect)rect

{
    
    
    // [self initDefault];
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();  // old
    CGRect  myFrame = self.bounds;       // new
    
    yHight  = self.bounds.size.height  * yHightMult;
    
    
    xWidth  = self.bounds.size.width   * xWidthMult;
    
    
    
    CGContextSetLineWidth(context, _lineWidth);   // new
    
    CGRectInset(myFrame, 5,5);  // new
    [_fillColor set];        //  ??
    
    UIRectFrame(myFrame);       // new
    
    
   // [self autoSize : YES];
    
    
    // [self drawBars];
    [_lineColor0 set];
    [self drawAllLines];
    
    
    [_lineColor1 set]; 
   
    
    // [self drawVerticalsFrom : aValues[1] to : aValues[2]];
    
    
    [self drawXAxis];
    [self drawYAxis];
    
    //    CGContextRestoreGState(context);
    
    
}



-(void)somethingChanged
{
    
    //UISlider * bla;
    //bla = (UISlider*)sender;
    
    
    //NSLog(@"in somethingChanged %f",[bla value]);
    
    //NSNumber* n1 = [[NSNumber alloc] initWithFloat:[bla value]*10.0];
    
    //NSLog(@"in somethingChanged _  %@",n1);
    
    //[aValues replaceObjectAtIndex:1 withObject:n1];
    
    [self setNeedsDisplay];
    
}



@end
