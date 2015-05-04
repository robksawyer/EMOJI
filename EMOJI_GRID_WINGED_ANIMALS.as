﻿package  {	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.display.DisplayObject;	import flash.display.BitmapData;	import flash.display.Bitmap;	import flash.geom.Point;	import flash.geom.Rectangle;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.geom.Matrix;	import flash.display.PixelSnapping;		import flash.display.Loader;	import flash.events.Event;	import flash.events.IEventDispatcher;	import flash.events.ProgressEvent;	import flash.events.SecurityErrorEvent;	import flash.events.HTTPStatusEvent;	import flash.events.IOErrorEvent;	import flash.net.URLRequest;		import flash.utils.getDefinitionByName;	import flash.utils.getQualifiedClassName;		//Logging	import com.demonsters.debugger.MonsterDebugger;		//import the Resolume communication classes	//make sure you have added the source path to these files in the ActionScript 3 Preferences of Flash	import resolumeCom.*;	import resolumeCom.parameters.*;	import resolumeCom.events.*;		public class EMOJI_GRID_WINGED_ANIMALS extends MovieClip 	{				/*****************TEST PARAMS********************/				private static var TESTING:Boolean = false;				/************************************************/						/*****************PRIVATE********************/		/**		* Create the resolume object that will do all the hard work for you.		*/		private var resolume:Resolume = new Resolume();				/**		* Examples of parameters that can be used inside of Resolume		*/		/*private var paramScaleX:FloatParameter = resolume.addFloatParameter("Scale X", 0.5);		private var paramScaleY:FloatParameter = resolume.addFloatParameter("Scale Y", 0.5);		private var paramRotate:FloatParameter = resolume.addFloatParameter("Rotate", 0.0);		private var paramFooter:StringParameter = resolume.addStringParameter("Footer", "VJ BOB");		private var paramShowBackground:BooleanParameter = resolume.addBooleanParameter("Background", true);		private var paramShowSurprise:EventParameter = resolume.addEventParameter("Surprise!");*/				private var emojisInfo:Object = {										keys: new Array(48, 64, 96),								   		sizes: new Array("48x48","64x64","96x96"),								  		total: new Number(10) //total number of emojis is 1363										};												//Hold the actual emoji bitmap references per size in separate arrays		private var emojis:Array = new Array();				//Holds the emojis		private var gridContainer:Sprite;				//Other Resolume Parameters		private var paramRandomize:EventParameter;		private var paramSingle:BooleanParameter;		private var paramRandScale:BooleanParameter;		private var paramFit:EventParameter;		private var paramScale:FloatParameter;		private var paramGap:FloatParameter;				public static var EMOJI_INIT_SIZE:int = 96;		public var EMOJI_SIZE:int = 96;				private var globalScaleVal:Number = 0.5;				private var scaledEmojis:Array = new Array();				private var firstLoad:Boolean = true;				public function EMOJI_GRID_WINGED_ANIMALS():void		{			stage.align = StageAlign.TOP_LEFT;			stage.scaleMode = StageScaleMode.NO_SCALE;						// Start the MonsterDebugger			MonsterDebugger.initialize(this);						initData();						//Initialize the Resolume parameters			initParams();						//set callback, this will notify us when a parameter has changed			resolume.addParameterListener(paramChanged);						addEventListener(Event.ADDED_TO_STAGE, init);		}				/**		* Initialize data 		* - initialize all of the emojis bitmaps that are used in the plugin		*/		private function initData()		{						emojis = [				{          name: "Dragon",          id: 622,          bitmap48: new Bitmap( new Emoji_48x48_622() ),          bitmap96: new Bitmap( new Emoji_96x96_622() )        },        {          name: "Rooster",          id: 632,          bitmap48: new Bitmap( new Emoji_48x48_632() ),          bitmap96: new Bitmap( new Emoji_96x96_632() )        },        {          name: "Hen",          id: 633,          bitmap48: new Bitmap( new Emoji_48x48_633() ),          bitmap96: new Bitmap( new Emoji_96x96_633() )        },        {          name: "Hatching chick",          id: 648,          bitmap48: new Bitmap( new Emoji_48x48_648() ),          bitmap96: new Bitmap( new Emoji_96x96_648() )        },        {          name: "Baby Chick",          id: 649,          bitmap48: new Bitmap( new Emoji_48x48_649() ),          bitmap96: new Bitmap( new Emoji_96x96_649() )        },        {          name: "Baby Chick Facing Front",          id: 650,          bitmap48: new Bitmap( new Emoji_48x48_650() ),          bitmap96: new Bitmap( new Emoji_96x96_650() )        },        {          name: "Bird",          id: 651,          bitmap48: new Bitmap( new Emoji_48x48_651() ),          bitmap96: new Bitmap( new Emoji_96x96_651() )        },        {          name: "Penguin",          id: 652,          bitmap48: new Bitmap( new Emoji_48x48_652() ),          bitmap96: new Bitmap( new Emoji_96x96_652() )        },        {          name: "Dragon face",          id: 663,          bitmap48: new Bitmap( new Emoji_48x48_663() ),          bitmap96: new Bitmap( new Emoji_96x96_663() )        }			];		}				/**			* Initialize parameters that are used inside of Resolume		*/		public function initParams():void		{			MonsterDebugger.trace(this, "Iniailizing Resolume parameters.", "Init Phase");						if(TESTING)			{				//emojis[0].param = resolume.addBooleanParameter(emojis[0].name, true);				//emojis[0].activated = false;			}			else			{				//Booleans				/*for(var i=0;i<emojis.length;i++)				{					emojis[i].param = resolume.addBooleanParameter(emojis[i].name, false);					emojis[i].activated = false;				}*/			}						paramRandomize = resolume.addEventParameter("Randomize");			paramFit = resolume.addEventParameter("Fit Aspect Ratio");			//			paramSingle = resolume.addBooleanParameter("Single Emoji", false);			//paramRandScale = resolume.addBooleanParameter("Random Scale", true);			//			paramScale = resolume.addFloatParameter("Emoji Scale", 0.5); //96px is the default			paramGap = resolume.addFloatParameter("Spacing", 0.0);		}			/**			* Main initialize method		*/		public function init( e:Event ):void		{			MonsterDebugger.trace(this, "EMOJI Initialized", "Init Phase");						//Build the grid			buildGrid();						if(TESTING)			{							}		}							/**		* This method will be called everytime you change a paramater in Resolume.		*/		public function paramChanged( event:ChangeEvent ):void 		{			MonsterDebugger.trace(this, "Param Changed: " + event.object, "Interactive Phase");			//Check to see if the param was a Boolean			switch(event.object)			{				case paramRandomize:					resetGrid();					break;								case paramSingle:					updateGrid();					break;									case paramGap:					updateGrid();					break;								case paramScale:					EMOJI_SIZE = EMOJI_INIT_SIZE;					if(paramScale.getValue() > 0.3)					{						globalScaleVal = paramScale.getValue();					}					else					{						globalScaleVal = 0.3;						paramScale.setValue(0.3);					}					updateGrid();					break;									case paramFit:					EMOJI_SIZE = EMOJI_INIT_SIZE;					var scaleVal:Number = 0.5;					var gap:Number = paramGap.getValue();					var gcdScaleRatio = getGreatestCommonFactor( (EMOJI_SIZE * scaleVal) + (gap/2), stage.stageWidth, stage.stageHeight);					EMOJI_SIZE = gcdScaleRatio;					buildGrid(scaleVal, false, gcdScaleRatio);					break;									case paramRandScale:					/*if(paramRandScale.getValue() == true)					{						scaleEmoji(true);					}*/					break;									default:					MonsterDebugger.trace(this, event.object);					break;			}		}				/**		* Updates the grid with a new number of icons		*/		private function updateGrid():void		{			buildGrid( globalScaleVal  );		}				/**		* Resets the grid of icons		*/		private function resetGrid():void		{			/*if(contains(gridContainer))			{				removeChild(gridContainer);			}*/			buildGrid( globalScaleVal , true );		}				/**		* Handles scaling a single emoji		*/		private function scaleEmoji(rand:Boolean = false, instanceNum:Number = 0):void		{			var scaleVal:Number = EMOJI_SIZE * globalScaleVal;			var emojiIndex = 0;			var randInstance = randRange(0, gridContainer.numChildren - 1);			var stageRef:DisplayObject;						if(rand)			{				stageRef = randomEmoji();				emojiIndex = stageRef.name;			}			else			{				stageRef = gridContainer.getChildAt(instanceNum);				if(!stageRef)				{					return;				}				emojiIndex = stageRef.name;			}						if(typeof(scaledEmojis[emojiIndex]) != "object")			{				scaledEmojis[emojiIndex] = new Object();			}						if (stageRef != null) 			{				//Save the reference				scaledEmojis[emojiIndex].bitmap = stageRef;								//Remove the previous instance				gridContainer.removeChildAt(randInstance);								if(scaledEmojis[emojiIndex].isScaled)				{					scaledEmojis[emojiIndex].bitmap.width = EMOJI_SIZE;					scaledEmojis[emojiIndex].bitmap.height = EMOJI_SIZE;					scaledEmojis[emojiIndex].isScaled = false;				}				else 				{					scaledEmojis[emojiIndex].bitmap.width = scaleVal;					scaledEmojis[emojiIndex].bitmap.height = scaleVal;					scaledEmojis[emojiIndex].isScaled = true;				}				gridContainer.addChild( scaledEmojis[emojiIndex].bitmap );			}		}				/**		* Builds a grid of icons		*/		private function buildGrid(scaleVal:Number = 0.5, reset:Boolean = false, gcdScaleRatio:Number = 0.0):void		{			MonsterDebugger.trace(this, "Building grid...", "Action Phase");						// current column			var column:int = 0;			// current row			var row:int = 0;			// distance between objects			var gap:Number = 0;			if(paramGap.getValue() > 0)			{				gap = paramGap.getValue() * 50;			}						var x_counter:Number = 0;			var y_counter:Number = 0;						if(gcdScaleRatio == 0.0)			{				gcdScaleRatio = EMOJI_SIZE * scaleVal;			}						var scaledEmojiSize = gcdScaleRatio;			var totalCols:int = Math.ceil(stage.stageWidth / scaledEmojiSize);			var totalRows:int = Math.ceil(stage.stageHeight / scaledEmojiSize);						var totalIcons:int = Math.ceil(totalCols * totalRows);						MonsterDebugger.trace(this, "New emoji size: " + scaledEmojiSize, "Testing");			MonsterDebugger.trace(this, "Total rows: " + totalRows, "Testing");			MonsterDebugger.trace(this, "Total cols: " + totalCols, "Testing");			MonsterDebugger.trace(this, "Total icons: " + totalIcons, "Testing");						// Sprite that holds grid			if(firstLoad)			{				gridContainer = new Sprite();			}						//Holds the icon			var cell:Bitmap;			if( paramSingle.getValue() == true && !firstLoad){				var randInstance = randRange(0, gridContainer.numChildren - 1);				var stageRef = gridContainer.getChildAt(randInstance);				if(!stageRef || reset == true)				{					cell = randomEmoji();				}				else				{					cell = stageRef;				}			}						if(contains(gridContainer) && !firstLoad)			{				removeChild(gridContainer);				gridContainer = new Sprite();			}						for (var i:int = 0; i < totalIcons; i++) {				//column = i % totalRows;				//row = int(i / totalCols);				// get corresponding object from the array				if( paramSingle.getValue() == false)				{					cell = new Bitmap( randomEmoji().bitmapData, PixelSnapping.NEVER );				}				else				{					cell = new Bitmap(cell.bitmapData, PixelSnapping.NEVER);				}								if(i>0)				{					if (x_counter+1 < totalCols)					{						x_counter++;					} 					else 					{						x_counter = 0;						y_counter++;					}				}								cell.width = gcdScaleRatio;				cell.height = gcdScaleRatio;				cell.smoothing = true;				cell.x = (cell.width + gap) * x_counter;				cell.y = (cell.height + gap) * y_counter;								//Render the emoji				gridContainer.addChild(cell);								MonsterDebugger.trace(this,i + "\tcolumn = " + column + "\trow = " + row, "Testing");			}						//Render the grid 			//gridContainer.x = gridContainer.y = 20;			addChild(gridContainer);			firstLoad = false;		}						/**			* Returns a random emoji		*/		public function randomEmoji():Bitmap		{			var rand:Number = randRange(0, emojis.length-1);			MonsterDebugger.trace(this, "Random #" + rand, "Testing");			if(!emojis[rand]){				MonsterDebugger.trace(this, "Unable to load Emoji #" + rand, "Testing");			}			return emojis[rand]["bitmap"+EMOJI_INIT_SIZE];		}				/**		* Finds the class name of an object and creates an object based on a class's String-formated name.		* Source: https://delfeld.wordpress.com/2009/04/21/object_from_class_name/		*/		public function getClassObj(obj:*):*		{			var objClass:Class = Class(getDefinitionByName(getQualifiedClassName(obj)));			return new objClass();		}				private function randRange(minNum:Number, maxNum:Number):Number 		{			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);		}						/**		* http://snipplr.com/view.php?codeview&id=33076		*/		public function getGreatestCommonFactor( e1:uint, e2:uint, e3:uint ):uint{			var elements = new Array( e1, e2, e3 );			var gcd:uint;								var factors:Array = new Array();			var cnt:uint=0;			var qCnt:uint=0;			var elementCount:uint=elements.length;								//find the min number			var minNum:uint = Math.min ( elements[0], elements[1], elements[2] );			trace("Min num: " + minNum);								//loop thru all values of min from 1			for(var i=1;i<=minNum;i++){										//test for remainder for all 3				for(var k=0;k<elements.length;k++){					if(elements[k]%i==0){						cnt++;					}				}				//if can be div by all 3				if(cnt==elements.length){					trace("Factor found");					factors[qCnt]=i;					qCnt++;				}					cnt=0;			}								//Find the greatest factor			for( i=0;i<qCnt;i++){				if(gcd<factors[i]){					gcd=factors[i];				}			}								trace( "Factors: " + factors );			return gcd;		}	}}