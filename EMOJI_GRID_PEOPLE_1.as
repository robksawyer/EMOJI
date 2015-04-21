﻿package  {	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.display.DisplayObject;	import flash.display.BitmapData;	import flash.display.Bitmap;	import flash.geom.Point;	import flash.geom.Rectangle;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.geom.Matrix;	import flash.display.PixelSnapping;		import flash.display.Loader;	import flash.events.Event;	import flash.events.IEventDispatcher;	import flash.events.ProgressEvent;	import flash.events.SecurityErrorEvent;	import flash.events.HTTPStatusEvent;	import flash.events.IOErrorEvent;	import flash.net.URLRequest;		import flash.utils.getDefinitionByName;	import flash.utils.getQualifiedClassName;		//Logging	import com.demonsters.debugger.MonsterDebugger;		//import the Resolume communication classes	//make sure you have added the source path to these files in the ActionScript 3 Preferences of Flash	import resolumeCom.*;	import resolumeCom.parameters.*;	import resolumeCom.events.*;		public class EMOJI_GRID_PEOPLE_1 extends MovieClip 	{				/*****************TEST PARAMS********************/				private static var TESTING:Boolean = false;				/************************************************/						/*****************PRIVATE********************/		/**		* Create the resolume object that will do all the hard work for you.		*/		private var resolume:Resolume = new Resolume();				/**		* Examples of parameters that can be used inside of Resolume		*/		/*private var paramScaleX:FloatParameter = resolume.addFloatParameter("Scale X", 0.5);		private var paramScaleY:FloatParameter = resolume.addFloatParameter("Scale Y", 0.5);		private var paramRotate:FloatParameter = resolume.addFloatParameter("Rotate", 0.0);		private var paramFooter:StringParameter = resolume.addStringParameter("Footer", "VJ BOB");		private var paramShowBackground:BooleanParameter = resolume.addBooleanParameter("Background", true);		private var paramShowSurprise:EventParameter = resolume.addEventParameter("Surprise!");*/				private var emojisInfo:Object = {										keys: new Array(48, 64, 96),								   		sizes: new Array("48x48","64x64","96x96"),								  		total: new Number(10) //total number of emojis is 1363										};												//Hold the actual emoji bitmap references per size in separate arrays		private var emojis:Array = new Array();				//Holds the emojis		private var gridContainer:Sprite;				//Other Resolume Parameters		private var paramRandomize:EventParameter;		private var paramSingle:BooleanParameter;		private var paramRandScale:BooleanParameter;		private var paramFit:EventParameter;		private var paramScale:FloatParameter;		private var paramGap:FloatParameter;				public static var EMOJI_INIT_SIZE:int = 96;		public var EMOJI_SIZE:int = 96;				private var globalScaleVal:Number = 0.5;				private var scaledEmojis:Array = new Array();				private var firstLoad:Boolean = true;				public function EMOJI_GRID_PEOPLE_1():void		{			stage.align = StageAlign.TOP_LEFT;			stage.scaleMode = StageScaleMode.NO_SCALE;						// Start the MonsterDebugger			MonsterDebugger.initialize(this);						initData();						//Initialize the Resolume parameters			initParams();						//set callback, this will notify us when a parameter has changed			resolume.addParameterListener(paramChanged);						addEventListener(Event.ADDED_TO_STAGE, init);		}				/**		* Initialize data 		* - initialize all of the emojis bitmaps that are used in the plugin		*/		private function initData()		{						emojis = [				{				  name: "Happy Face",				  id: 55,				  bitmap48: new Bitmap( new Emoji_48x48_55() ),				  bitmap96: new Bitmap( new Emoji_96x96_55() )				},				{				  name: "Santa Yellow",				  id: 509,				  bitmap48: new Bitmap( new Emoji_48x48_509() ),				  bitmap96: new Bitmap( new Emoji_96x96_509() )				},				{				  name: "Santa Whiter",				  id: 510,				  bitmap48: new Bitmap( new Emoji_48x48_510() ),				  bitmap96: new Bitmap( new Emoji_96x96_510() )				},				{				  name: "Santa White",				  id: 511,				  bitmap48: new Bitmap( new Emoji_48x48_511() ),				  bitmap96: new Bitmap( new Emoji_96x96_511() )				},				{				  name: "Santa Tan",				  id: 512,				  bitmap48: new Bitmap( new Emoji_48x48_512() ),				  bitmap96: new Bitmap( new Emoji_96x96_512() )				},				{				  name: "Santa Brown",				  id: 513,				  bitmap48: new Bitmap( new Emoji_48x48_513() ),				  bitmap96: new Bitmap( new Emoji_96x96_513() )				},				{				  name: "Santa Black",				  id: 514,				  bitmap48: new Bitmap( new Emoji_48x48_514() ),				  bitmap96: new Bitmap( new Emoji_96x96_514() )				},				{				  name: "Yellow Boy",				  id: 778,				  bitmap48: new Bitmap( new Emoji_48x48_778() ),				  bitmap96: new Bitmap( new Emoji_96x96_778() )				},				{				  name: "Whiter Boy",				  id: 779,				  bitmap48: new Bitmap( new Emoji_48x48_779() ),				  bitmap96: new Bitmap( new Emoji_96x96_779() )				},				{				  name: "White Boy",				  id: 780,				  bitmap48: new Bitmap( new Emoji_48x48_780() ),				  bitmap96: new Bitmap( new Emoji_96x96_780() )				},				{				  name: "Tan Boy",				  id: 781,				  bitmap48: new Bitmap( new Emoji_48x48_781() ),				  bitmap96: new Bitmap( new Emoji_96x96_781() )				},				{				  name: "Brown Boy",				  id: 782,				  bitmap48: new Bitmap( new Emoji_48x48_782() ),				  bitmap96: new Bitmap( new Emoji_96x96_782() )				},				{				  name: "Black Boy",				  id: 783,				  bitmap48: new Bitmap( new Emoji_48x48_783() ),				  bitmap96: new Bitmap( new Emoji_96x96_783() )				},				{				  name: "Yellow Girl",				  id: 784,				  bitmap48: new Bitmap( new Emoji_48x48_784() ),				  bitmap96: new Bitmap( new Emoji_96x96_784() )				},				{				  name: "Whiter Girl",				  id: 785,				  bitmap48: new Bitmap( new Emoji_48x48_785() ),				  bitmap96: new Bitmap( new Emoji_96x96_785() )				},				{				  name: "White Girl",				  id: 786,				  bitmap48: new Bitmap( new Emoji_48x48_786() ),				  bitmap96: new Bitmap( new Emoji_96x96_786() )				},				{				  name: "Tan Girl",				  id: 787,				  bitmap48: new Bitmap( new Emoji_48x48_787() ),				  bitmap96: new Bitmap( new Emoji_96x96_787() )				},				{				  name: "Brown Girl",				  id: 788,				  bitmap48: new Bitmap( new Emoji_48x48_788() ),				  bitmap96: new Bitmap( new Emoji_96x96_788() )				},				{				  name: "Black Girl",				  id: 789,				  bitmap48: new Bitmap( new Emoji_48x48_789() ),				  bitmap96: new Bitmap( new Emoji_96x96_789() )				},				{				  name: "Yellow Man",				  id: 790,				  bitmap48: new Bitmap( new Emoji_48x48_790() ),				  bitmap96: new Bitmap( new Emoji_96x96_790() )				},				{				  name: "Whiter Man",				  id: 791,				  bitmap48: new Bitmap( new Emoji_48x48_791() ),				  bitmap96: new Bitmap( new Emoji_96x96_791() )				},				{				  name: "White Man",				  id: 792,				  bitmap48: new Bitmap( new Emoji_48x48_792() ),				  bitmap96: new Bitmap( new Emoji_96x96_792() )				},				{				  name: "Tan Man",				  id: 793,				  bitmap48: new Bitmap( new Emoji_48x48_793() ),				  bitmap96: new Bitmap( new Emoji_96x96_793() )				},				{				  name: "Brown Man",				  id: 794,				  bitmap48: new Bitmap( new Emoji_48x48_794() ),				  bitmap96: new Bitmap( new Emoji_96x96_794() )				},				{				  name: "Black Man",				  id: 795,				  bitmap48: new Bitmap( new Emoji_48x48_795() ),				  bitmap96: new Bitmap( new Emoji_96x96_795() )				},				{				  name: "Yellow Woman",				  id: 796,				  bitmap48: new Bitmap( new Emoji_48x48_796() ),				  bitmap96: new Bitmap( new Emoji_96x96_796() )				},				{				  name: "Whiter Woman",				  id: 797,				  bitmap48: new Bitmap( new Emoji_48x48_797() ),				  bitmap96: new Bitmap( new Emoji_96x96_797() )				},				{				  name: "White Woman",				  id: 798,				  bitmap48: new Bitmap( new Emoji_48x48_798() ),				  bitmap96: new Bitmap( new Emoji_96x96_798() )				},				{				  name: "Tan Woman",				  id: 799,				  bitmap48: new Bitmap( new Emoji_48x48_799() ),				  bitmap96: new Bitmap( new Emoji_96x96_799() )				},				{				  name: "Brown Woman",				  id: 800,				  bitmap48: new Bitmap( new Emoji_48x48_800() ),				  bitmap96: new Bitmap( new Emoji_96x96_800() )				},				{				  name: "Black Woman",				  id: 801,				  bitmap48: new Bitmap( new Emoji_48x48_801() ),				  bitmap96: new Bitmap( new Emoji_96x96_801() )				},				{				  name: "Yellow Policeman",				  id: 820,				  bitmap48: new Bitmap( new Emoji_48x48_820() ),				  bitmap96: new Bitmap( new Emoji_96x96_820() )				},				{				  name: "Whiter Policeman",				  id: 821,				  bitmap48: new Bitmap( new Emoji_48x48_821() ),				  bitmap96: new Bitmap( new Emoji_96x96_821() )				},				{				  name: "White Policeman",				  id: 822,				  bitmap48: new Bitmap( new Emoji_48x48_822() ),				  bitmap96: new Bitmap( new Emoji_96x96_822() )				},				{				  name: "Tan Policeman",				  id: 823,				  bitmap48: new Bitmap( new Emoji_48x48_823() ),				  bitmap96: new Bitmap( new Emoji_96x96_823() )				},				{				  name: "Brown Policeman",				  id: 824,				  bitmap48: new Bitmap( new Emoji_48x48_824() ),				  bitmap96: new Bitmap( new Emoji_96x96_824() )				},				{				  name: "Black Policeman",				  id: 825,				  bitmap48: new Bitmap( new Emoji_48x48_825() ),				  bitmap96: new Bitmap( new Emoji_96x96_825() )				},				{				  name: "Bunny Dancers",				  id: 826,				  bitmap48: new Bitmap( new Emoji_48x48_826() ),				  bitmap96: new Bitmap( new Emoji_96x96_826() )				},				{				  name: "Yellow Bride",				  id: 827,				  bitmap48: new Bitmap( new Emoji_48x48_827() ),				  bitmap96: new Bitmap( new Emoji_96x96_827() )				},				{				  name: "Whiter Bride",				  id: 828,				  bitmap48: new Bitmap( new Emoji_48x48_828() ),				  bitmap96: new Bitmap( new Emoji_96x96_828() )				},				{				  name: "White Bride",				  id: 829,				  bitmap48: new Bitmap( new Emoji_48x48_829() ),				  bitmap96: new Bitmap( new Emoji_96x96_829() )				},				{				  name: "Tan Bride",				  id: 830,				  bitmap48: new Bitmap( new Emoji_48x48_830() ),				  bitmap96: new Bitmap( new Emoji_96x96_830() )				},				{				  name: "Brown Bride",				  id: 831,				  bitmap48: new Bitmap( new Emoji_48x48_831() ),				  bitmap96: new Bitmap( new Emoji_96x96_831() )				},				{				  name: "Black Bride",				  id: 832,				  bitmap48: new Bitmap( new Emoji_48x48_832() ),				  bitmap96: new Bitmap( new Emoji_96x96_832() )				},				{				  name: "Yellow Boy 2",				  id: 833,				  bitmap48: new Bitmap( new Emoji_48x48_833() ),				  bitmap96: new Bitmap( new Emoji_96x96_833() )				},				{				  name: "Whiter Boy 2",				  id: 834,				  bitmap48: new Bitmap( new Emoji_48x48_834() ),				  bitmap96: new Bitmap( new Emoji_96x96_834() )				},				{				  name: "White Boy 2",				  id: 835,				  bitmap48: new Bitmap( new Emoji_48x48_835() ),				  bitmap96: new Bitmap( new Emoji_96x96_835() )				},				{				  name: "Tan Boy 2",				  id: 836,				  bitmap48: new Bitmap( new Emoji_48x48_836() ),				  bitmap96: new Bitmap( new Emoji_96x96_836() )				},				{				  name: "Brown Boy 2",				  id: 837,				  bitmap48: new Bitmap( new Emoji_48x48_837() ),				  bitmap96: new Bitmap( new Emoji_96x96_837() )				},				{				  name: "Black Boy 2",				  id: 838,				  bitmap48: new Bitmap( new Emoji_48x48_838() ),				  bitmap96: new Bitmap( new Emoji_96x96_838() )				},				{				  name: "Yellow Man w/Skullcap",				  id: 839,				  bitmap48: new Bitmap( new Emoji_48x48_839() ),				  bitmap96: new Bitmap( new Emoji_96x96_839() )				},				{				  name: "Whiter Man w/Skullcap",				  id: 840,				  bitmap48: new Bitmap( new Emoji_48x48_840() ),				  bitmap96: new Bitmap( new Emoji_96x96_840() )				},				{				  name: "White Man w/Skullcap",				  id: 841,				  bitmap48: new Bitmap( new Emoji_48x48_841() ),				  bitmap96: new Bitmap( new Emoji_96x96_841() )				},				{				  name: "Tan Man w/Skullcap",				  id: 842,				  bitmap48: new Bitmap( new Emoji_48x48_842() ),				  bitmap96: new Bitmap( new Emoji_96x96_842() )				},				{				  name: "Brown Man w/Skullcap",				  id: 843,				  bitmap48: new Bitmap( new Emoji_48x48_843() ),				  bitmap96: new Bitmap( new Emoji_96x96_843() )				},				{				  name: "Black Man w/Skullcap",				  id: 844,				  bitmap48: new Bitmap( new Emoji_48x48_844() ),				  bitmap96: new Bitmap( new Emoji_96x96_844() )				},				{				  name: "Yellow Man w/Turban",				  id: 845,				  bitmap48: new Bitmap( new Emoji_48x48_845() ),				  bitmap96: new Bitmap( new Emoji_96x96_845() )				},				{				  name: "Whiter Man w/Turban",				  id: 846,				  bitmap48: new Bitmap( new Emoji_48x48_846() ),				  bitmap96: new Bitmap( new Emoji_96x96_846() )				},				{				  name: "White Man w/Turban",				  id: 847,				  bitmap48: new Bitmap( new Emoji_48x48_847() ),				  bitmap96: new Bitmap( new Emoji_96x96_847() )				},				{				  name: "Tan Man w/Turban",				  id: 848,				  bitmap48: new Bitmap( new Emoji_48x48_848() ),				  bitmap96: new Bitmap( new Emoji_96x96_848() )				},				{				  name: "Brown Man w/Turban",				  id: 849,				  bitmap48: new Bitmap( new Emoji_48x48_849() ),				  bitmap96: new Bitmap( new Emoji_96x96_849() )				},				{				  name: "Black Man w/Turban",				  id: 850,				  bitmap48: new Bitmap( new Emoji_48x48_850() ),				  bitmap96: new Bitmap( new Emoji_96x96_850() )				},				{				  name: "Yellow Old Man",				  id: 851,				  bitmap48: new Bitmap( new Emoji_48x48_851() ),				  bitmap96: new Bitmap( new Emoji_96x96_851() )				},				{				  name: "Whiter Old Man",				  id: 852,				  bitmap48: new Bitmap( new Emoji_48x48_852() ),				  bitmap96: new Bitmap( new Emoji_96x96_852() )				},				{				  name: "White Old Man",				  id: 853,				  bitmap48: new Bitmap( new Emoji_48x48_853() ),				  bitmap96: new Bitmap( new Emoji_96x96_853() )				},				{				  name: "Tan Old Man",				  id: 854,				  bitmap48: new Bitmap( new Emoji_48x48_854() ),				  bitmap96: new Bitmap( new Emoji_96x96_854() )				},				{				  name: "Brown Old Man",				  id: 855,				  bitmap48: new Bitmap( new Emoji_48x48_855() ),				  bitmap96: new Bitmap( new Emoji_96x96_855() )				},				{				  name: "Black Old Man",				  id: 856,				  bitmap48: new Bitmap( new Emoji_48x48_856() ),				  bitmap96: new Bitmap( new Emoji_96x96_856() )				},				{				  name: "Yellow Old Woman",				  id: 857,				  bitmap48: new Bitmap( new Emoji_48x48_857() ),				  bitmap96: new Bitmap( new Emoji_96x96_857() )				},				{				  name: "Whiter Old Woman",				  id: 858,				  bitmap48: new Bitmap( new Emoji_48x48_858() ),				  bitmap96: new Bitmap( new Emoji_96x96_858() )				},				{				  name: "White Old Woman",				  id: 859,				  bitmap48: new Bitmap( new Emoji_48x48_859() ),				  bitmap96: new Bitmap( new Emoji_96x96_859() )				},				{				  name: "Tan Old Woman",				  id: 860,				  bitmap48: new Bitmap( new Emoji_48x48_860() ),				  bitmap96: new Bitmap( new Emoji_96x96_860() )				},				{				  name: "Brown Old Woman",				  id: 861,				  bitmap48: new Bitmap( new Emoji_48x48_861() ),				  bitmap96: new Bitmap( new Emoji_96x96_861() )				},				{				  name: "Black Old Woman",				  id: 862,				  bitmap48: new Bitmap( new Emoji_48x48_862() ),				  bitmap96: new Bitmap( new Emoji_96x96_862() )				},				{				  name: "Yellow Baby",				  id: 863,				  bitmap48: new Bitmap( new Emoji_48x48_863() ),				  bitmap96: new Bitmap( new Emoji_96x96_863() )				},				{				  name: "Whiter Baby",				  id: 864,				  bitmap48: new Bitmap( new Emoji_48x48_864() ),				  bitmap96: new Bitmap( new Emoji_96x96_864() )				},				{				  name: "White Baby",				  id: 865,				  bitmap48: new Bitmap( new Emoji_48x48_865() ),				  bitmap96: new Bitmap( new Emoji_96x96_865() )				},				{				  name: "Tan Baby",				  id: 866,				  bitmap48: new Bitmap( new Emoji_48x48_866() ),				  bitmap96: new Bitmap( new Emoji_96x96_866() )				},				{				  name: "Brown Baby",				  id: 867,				  bitmap48: new Bitmap( new Emoji_48x48_867() ),				  bitmap96: new Bitmap( new Emoji_96x96_867() )				},				{				  name: "Black Baby",				  id: 868,				  bitmap48: new Bitmap( new Emoji_48x48_868() ),				  bitmap96: new Bitmap( new Emoji_96x96_868() )				},				{				  name: "Construction Worker Yellow",				  id: 869,				  bitmap48: new Bitmap( new Emoji_48x48_869() ),				  bitmap96: new Bitmap( new Emoji_96x96_869() )				},				{				  name: "Construction Worker Whiter",				  id: 870,				  bitmap48: new Bitmap( new Emoji_48x48_870() ),				  bitmap96: new Bitmap( new Emoji_96x96_870() )				},				{				  name: "Construction Worker White",				  id: 871,				  bitmap48: new Bitmap( new Emoji_48x48_871() ),				  bitmap96: new Bitmap( new Emoji_96x96_871() )				},				{				  name: "Construction Worker Tan",				  id: 872,				  bitmap48: new Bitmap( new Emoji_48x48_872() ),				  bitmap96: new Bitmap( new Emoji_96x96_872() )				},				{				  name: "Construction Worker Brown",				  id: 873,				  bitmap48: new Bitmap( new Emoji_48x48_873() ),				  bitmap96: new Bitmap( new Emoji_96x96_873() )				},				{				  name: "Construction Worker Black",				  id: 874,				  bitmap48: new Bitmap( new Emoji_48x48_874() ),				  bitmap96: new Bitmap( new Emoji_96x96_874() )				},				{				  name: "Princess Yellow",				  id: 875,				  bitmap48: new Bitmap( new Emoji_48x48_875() ),				  bitmap96: new Bitmap( new Emoji_96x96_875() )				},				{				  name: "Princess Whiter",				  id: 876,				  bitmap48: new Bitmap( new Emoji_48x48_876() ),				  bitmap96: new Bitmap( new Emoji_96x96_876() )				},				{				  name: "Princess White",				  id: 877,				  bitmap48: new Bitmap( new Emoji_48x48_877() ),				  bitmap96: new Bitmap( new Emoji_96x96_877() )				},				{				  name: "Princess Tan",				  id: 878,				  bitmap48: new Bitmap( new Emoji_48x48_878() ),				  bitmap96: new Bitmap( new Emoji_96x96_878() )				},				{				  name: "Princess Brown",				  id: 879,				  bitmap48: new Bitmap( new Emoji_48x48_879() ),				  bitmap96: new Bitmap( new Emoji_96x96_879() )				},				{				  name: "Princess Black",				  id: 880,				  bitmap48: new Bitmap( new Emoji_48x48_880() ),				  bitmap96: new Bitmap( new Emoji_96x96_880() )				}			];					}				/**			* Initialize parameters that are used inside of Resolume		*/		public function initParams():void		{			MonsterDebugger.trace(this, "Iniailizing Resolume parameters.", "Init Phase");						if(TESTING)			{				//emojis[0].param = resolume.addBooleanParameter(emojis[0].name, true);				//emojis[0].activated = false;			}			else			{				//Booleans				/*for(var i=0;i<emojis.length;i++)				{					emojis[i].param = resolume.addBooleanParameter(emojis[i].name, false);					emojis[i].activated = false;				}*/			}						paramRandomize = resolume.addEventParameter("Randomize");			paramFit = resolume.addEventParameter("Fit Aspect Ratio");			//			paramSingle = resolume.addBooleanParameter("Single Emoji", false);			//paramRandScale = resolume.addBooleanParameter("Random Scale", true);			//			paramScale = resolume.addFloatParameter("Emoji Scale", 0.5); //96px is the default			paramGap = resolume.addFloatParameter("Spacing", 0.0);		}			/**			* Main initialize method		*/		public function init( e:Event ):void		{			MonsterDebugger.trace(this, "EMOJI Initialized", "Init Phase");						//Build the grid			buildGrid();						if(TESTING)			{							}		}							/**		* This method will be called everytime you change a paramater in Resolume.		*/		public function paramChanged( event:ChangeEvent ):void 		{			MonsterDebugger.trace(this, "Param Changed: " + event.object, "Interactive Phase");			//Check to see if the param was a Boolean			switch(event.object)			{				case paramRandomize:					resetGrid();					break;								case paramSingle:					updateGrid();					break;									case paramGap:					updateGrid();					break;								case paramScale:					EMOJI_SIZE = EMOJI_INIT_SIZE;					if(paramScale.getValue() > 0.3)					{						globalScaleVal = paramScale.getValue();					}					else					{						globalScaleVal = 0.3;						paramScale.setValue(0.3);					}					updateGrid();					break;									case paramFit:					EMOJI_SIZE = EMOJI_INIT_SIZE;					var scaleVal:Number = 0.5;					var gap:Number = paramGap.getValue();					var gcdScaleRatio = getGreatestCommonFactor( (EMOJI_SIZE * scaleVal) + (gap/2), stage.stageWidth, stage.stageHeight);					EMOJI_SIZE = gcdScaleRatio;					buildGrid(scaleVal, false, gcdScaleRatio);					break;									case paramRandScale:					/*if(paramRandScale.getValue() == true)					{						scaleEmoji(true);					}*/					break;									default:					MonsterDebugger.trace(this, event.object);					break;			}		}				/**		* Updates the grid with a new number of icons		*/		private function updateGrid():void		{			buildGrid( globalScaleVal  );		}				/**		* Resets the grid of icons		*/		private function resetGrid():void		{			/*if(contains(gridContainer))			{				removeChild(gridContainer);			}*/			buildGrid( globalScaleVal , true );		}				/**		* Handles scaling a single emoji		*/		private function scaleEmoji(rand:Boolean = false, instanceNum:Number = 0):void		{			var scaleVal:Number = EMOJI_SIZE * globalScaleVal;			var emojiIndex = 0;			var randInstance = randRange(0, gridContainer.numChildren - 1);			var stageRef:DisplayObject;						if(rand)			{				stageRef = randomEmoji();				emojiIndex = stageRef.name;			}			else			{				stageRef = gridContainer.getChildAt(instanceNum);				if(!stageRef)				{					return;				}				emojiIndex = stageRef.name;			}						if(typeof(scaledEmojis[emojiIndex]) != "object")			{				scaledEmojis[emojiIndex] = new Object();			}						if (stageRef != null) 			{				//Save the reference				scaledEmojis[emojiIndex].bitmap = stageRef;								//Remove the previous instance				gridContainer.removeChildAt(randInstance);								if(scaledEmojis[emojiIndex].isScaled)				{					scaledEmojis[emojiIndex].bitmap.width = EMOJI_SIZE;					scaledEmojis[emojiIndex].bitmap.height = EMOJI_SIZE;					scaledEmojis[emojiIndex].isScaled = false;				}				else 				{					scaledEmojis[emojiIndex].bitmap.width = scaleVal;					scaledEmojis[emojiIndex].bitmap.height = scaleVal;					scaledEmojis[emojiIndex].isScaled = true;				}				gridContainer.addChild( scaledEmojis[emojiIndex].bitmap );			}		}				/**		* Builds a grid of icons		*/		private function buildGrid(scaleVal:Number = 0.5, reset:Boolean = false, gcdScaleRatio:Number = 0.0):void		{			MonsterDebugger.trace(this, "Building grid...", "Action Phase");						// current column			var column:int = 0;			// current row			var row:int = 0;			// distance between objects			var gap:Number = 0;			if(paramGap.getValue() > 0)			{				gap = paramGap.getValue() * 50;			}						var x_counter:Number = 0;			var y_counter:Number = 0;						if(gcdScaleRatio == 0.0)			{				gcdScaleRatio = EMOJI_SIZE * scaleVal;			}						var scaledEmojiSize = gcdScaleRatio;			var totalCols:int = Math.ceil(stage.stageWidth / scaledEmojiSize);			var totalRows:int = Math.ceil(stage.stageHeight / scaledEmojiSize);						var totalIcons:int = Math.ceil(totalCols * totalRows);						MonsterDebugger.trace(this, "New emoji size: " + scaledEmojiSize, "Testing");			MonsterDebugger.trace(this, "Total rows: " + totalRows, "Testing");			MonsterDebugger.trace(this, "Total cols: " + totalCols, "Testing");			MonsterDebugger.trace(this, "Total icons: " + totalIcons, "Testing");						// Sprite that holds grid			if(firstLoad)			{				gridContainer = new Sprite();			}						//Holds the icon			var cell:Bitmap;			if( paramSingle.getValue() == true && !firstLoad){				var randInstance = randRange(0, gridContainer.numChildren - 1);				var stageRef = gridContainer.getChildAt(randInstance);				if(!stageRef || reset == true)				{					cell = randomEmoji();				}				else				{					cell = stageRef;				}			}						if(contains(gridContainer) && !firstLoad)			{				removeChild(gridContainer);				gridContainer = new Sprite();			}						for (var i:int = 0; i < totalIcons; i++) {				//column = i % totalRows;				//row = int(i / totalCols);				// get corresponding object from the array				if( paramSingle.getValue() == false)				{					cell = new Bitmap( randomEmoji().bitmapData, PixelSnapping.NEVER );				}				else				{					cell = new Bitmap(cell.bitmapData, PixelSnapping.NEVER);				}								if(i>0)				{					if (x_counter+1 < totalCols)					{						x_counter++;					} 					else 					{						x_counter = 0;						y_counter++;					}				}								cell.width = gcdScaleRatio;				cell.height = gcdScaleRatio;				cell.smoothing = true;				cell.x = (cell.width + gap) * x_counter;				cell.y = (cell.height + gap) * y_counter;								//Render the emoji				gridContainer.addChild(cell);								MonsterDebugger.trace(this,i + "\tcolumn = " + column + "\trow = " + row, "Testing");			}						//Render the grid 			//gridContainer.x = gridContainer.y = 20;			addChild(gridContainer);			firstLoad = false;		}						/**			* Returns a random emoji		*/		public function randomEmoji():Bitmap		{			var rand:Number = randRange(0, emojis.length-1);			MonsterDebugger.trace(this, "Random #" + rand, "Testing");			if(!emojis[rand]){				MonsterDebugger.trace(this, "Unable to load Emoji #" + rand, "Testing");			}			return emojis[rand]["bitmap"+EMOJI_INIT_SIZE];		}				/**		* Finds the class name of an object and creates an object based on a class's String-formated name.		* Source: https://delfeld.wordpress.com/2009/04/21/object_from_class_name/		*/		public function getClassObj(obj:*):*		{			var objClass:Class = Class(getDefinitionByName(getQualifiedClassName(obj)));			return new objClass();		}				private function randRange(minNum:Number, maxNum:Number):Number 		{			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);		}						/**		* http://snipplr.com/view.php?codeview&id=33076		*/		public function getGreatestCommonFactor( e1:uint, e2:uint, e3:uint ):uint{			var elements = new Array( e1, e2, e3 );			var gcd:uint;								var factors:Array = new Array();			var cnt:uint=0;			var qCnt:uint=0;			var elementCount:uint=elements.length;								//find the min number			var minNum:uint = Math.min ( elements[0], elements[1], elements[2] );			trace("Min num: " + minNum);								//loop thru all values of min from 1			for(var i=1;i<=minNum;i++){										//test for remainder for all 3				for(var k=0;k<elements.length;k++){					if(elements[k]%i==0){						cnt++;					}				}				//if can be div by all 3				if(cnt==elements.length){					trace("Factor found");					factors[qCnt]=i;					qCnt++;				}					cnt=0;			}								//Find the greatest factor			for( i=0;i<qCnt;i++){				if(gcd<factors[i]){					gcd=factors[i];				}			}								trace( "Factors: " + factors );			return gcd;		}	}}