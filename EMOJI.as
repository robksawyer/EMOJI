﻿package  {		import flash.display.MovieClip;		import flash.text.*;		import flash.events.Event;		//import the Resolume communication classes		//make sure you have added the source path to these files in the ActionScript 3 Preferences of Flash		import resolumeCom.*;		import resolumeCom.parameters.*;		import resolumeCom.events.*;		public class EMOJI extends MovieClip 		{				/*****************PRIVATE********************/				//create the resolume object that will do all the hard work for you				private var resolume:Resolume = new Resolume();								//create as many different parameters as you like				/*private var paramScaleX:FloatParameter = resolume.addFloatParameter("Scale X", 0.5);				private var paramScaleY:FloatParameter = resolume.addFloatParameter("Scale Y", 0.5);				private var paramRotate:FloatParameter = resolume.addFloatParameter("Rotate", 0.0);				private var paramFooter:StringParameter = resolume.addStringParameter("Footer", "VJ BOB");				private var paramShowBackground:BooleanParameter = resolume.addBooleanParameter("Background", true);				private var paramShowSurprise:EventParameter = resolume.addEventParameter("Surprise!");*/								[Embed(					source                = "fonts/Apple Color Emoji.ttf", 					fontName              = "emojiFont",					//fontStyle             = "normal",  // normal|italic					//fontWeight            = "normal",  // normal|bold					mimeType              = "application/x-font-truetype", 					advancedAntiAliasing  = "true",					//unicodeRange          = 'U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E',					embedAsCFF            = "true"				)]				private var emojiEmbeddedFont:Class;						public function EMOJI():void				{					//set callback, this will notify us when a parameter has changed					resolume.addParameterListener(parameterChanged);					addEventListener(Event.ADDED_TO_STAGE, init);				}				public function init(e:Event):void				{					trace("initialized");					var tf:TextField = new TextField();					tf.defaultTextFormat	= new TextFormat("emojiFont", 20);					tf.width 							= 200;					tf.height 						= 200;					//tf.autoSize 					= TextFieldAutoSize.LEFT;					tf.embedFonts 				= true;					tf.border 						= true;										//U+062C  this is equivalent to Hex: &#x062C;  // note the semicolon					//Read more: http://board.flashkit.com/board/showthread.php?771271-Unicode-in-Text-Field					var Char = "";					Char = String.fromCharCode(0x2515); // (as Hex)					var Code = "☕".charCodeAt(0);										tf.htmlText = Code + "  " + Char + "  &#2515;  &#x2515;";					trace(Code + "  " + Char + "  &#2515;  &#x2515;");					addChild(tf);				}				//this method will be called everytime you change a paramater in Resolume				public function parameterChanged( event:ChangeEvent ): void {					//check to see what paramater was changed					/*if (event.object == this.paramScaleX) {												//here you can do whatever you like with the value of the parameter						this.logo.scaleX = this.paramScaleX.getValue() * 2.0;											} else if (event.object == this.paramScaleY) {												this.logo.scaleY = this.paramScaleY.getValue() * 2.0;											} else if (event.object == this.paramRotate) {												this.logo.rotation = this.paramRotate.getValue() * 360.0;											} else if (event.object == this.paramFooter) {												this.footer.text = this.paramFooter.getValue();											} else if (event.object == this.paramShowBackground) {												this.background.visible = this.paramShowBackground.getValue();											} else if (event.object == this.paramShowSurprise) {												if (this.paramShowSurprise.getValue()){							this.surprise.gotoAndPlay(2);						}					} else {						trace(event.object);					}*/				}		}}