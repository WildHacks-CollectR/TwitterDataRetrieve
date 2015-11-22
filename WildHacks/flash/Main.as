package 
{

	import flash.display.MovieClip;
	import com.greensock.*;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import com.greensock.easing.*;
	import flash.text.TextField;
	import flashx.textLayout.formats.Float;
	import flash.geom.Point;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;

	public class Main extends MovieClip
	{

		public var select:Boolean = false;
		public var float:Boolean = false;
		public var worldDiam:Number;
		public var world2true:Boolean = false;
		public var countries:Array;
		public var population:Array;

		public var myTextLoader:URLLoader = new URLLoader();
		public var csvLoader:URLLoader = new URLLoader();



		public function Main()
		{

			var popupObj:popup = new popup();
			space.world2.visible = false;

			worldDiam = space.world.width;

			myTextLoader.addEventListener(Event.COMPLETE, onLoaded);
			csvLoader.addEventListener(Event.COMPLETE, csvLoaded);
			csvLoader.addEventListener(IOErrorEvent.IO_ERROR, infoIOErrorEvent);

			myTextLoader.load(new URLRequest("data/countries.txt"));
			csvLoader.load(new URLRequest("data/pop.csv"));


			Intro.Logo_MC.alpha = 0;
			space.textfield.text = 'Take me around the world!';
			space.textfield.addEventListener(MouseEvent.MOUSE_DOWN, textDown);
			space.textfield.addEventListener(KeyboardEvent.KEY_DOWN, entered);
			space.addEventListener(MouseEvent.MOUSE_DOWN, mousePos);


			TweenLite.to(Intro.Logo_MC, 2, {alpha:1});


			addEventListener(MouseEvent.CLICK, clicked);
			//trace("hi");

		}

		public function infoIOErrorEvent(e:IOErrorEvent):void
		{

		}


		public function clicked(e:MouseEvent):void
		{
			//trace("hello");
			TweenLite.to(Intro, 2, {y:-1080, ease:Bounce.easeOut});
			TweenLite.to(space, 2, {y:0, ease:Bounce.easeOut, onComplete:floating});
			//TweenLite.to(Intro, 1, {alpha:0, ease:Sine.easeInOut});
			removeEventListener(MouseEvent.CLICK, clicked);


		}

		public function floating():void
		{
			//trace("up");

			var tempY:Number = space.world.y + 10;

			//TweenLite.to(space.world2, 2, {y:tempY, ease:Sine.easeInOut});
			TweenLite.to(space.world, 2, {y:tempY, ease:Sine.easeInOut, onComplete:floatingDown});

			for each (var st in space)
			{
				if (st is MovieClip)
				{
					if (st.name.indexOf("star") >= 0)
					{
						//trace(st.rotation);
						var tempRotate = st.rotation + 15;
						TweenMax.to(st, 2, {rotation: tempRotate, ease:Linear.easeNone});
					}

				}
			}
			TweenLite.to(space.world, 2, {y:tempY, ease:Sine.easeInOut, onComplete:floatingDown});

		}

		public function floatingDown():void
		{

			var tempY:Number = space.world.y - 10;

			for each (var st in space)
			{
				if (st is MovieClip)
				{
					if (st.name.indexOf("star") >= 0)
					{
						//trace(st.rotation);
						var tempRotate = st.rotation + 15;
						TweenMax.to(st, 2, {rotation: tempRotate, ease:Linear.easeNone});
					}

				}
			}


			TweenLite.to(space.world2, 2, {y:tempY, ease:Sine.easeInOut});
			TweenLite.to(space.world, 2, {y:tempY, ease:Sine.easeInOut, onComplete:floating});
		}

		/*public function bubbles():void
		{
		TweenLite.to(space, 2, {y:-1080*2, ease:Bounce.easeOut});
		}*/
		//TweenLite.to(bubble, 2, {y:0, ease:Bounce.easeOut, onComplete:locationFind});


		public function textDown(e:MouseEvent):void
		{
			space.textfield.removeEventListener(MouseEvent.MOUSE_DOWN, textDown);
			space.textfield.addEventListener(MouseEvent.MOUSE_UP, textUp);

		}

		public function textUp(e:MouseEvent):void
		{
			space.textfield.text = '';



			stage.focus = space.textfield;
			space.textfield.text = "";
			space.textfield.setSelection(0, space.textfield.text.length);
		}

		public function switchBegin():void
		{
			
			space.bubblegbb.x -= 500;
			var tempX:Number = space.world2.x + worldDiam / 2;
			TweenLite.to(space.world, 0.4, {x: tempX});
			TweenLite.to(space.world, 0.4, {width: 0, onComplete:switchWorld});



		}

		public function entered(e:KeyboardEvent):void
		{
			if (e.keyCode == 13)
			{
				//Request DATABASE INFO

				var tempString = space.textfield.text;

				lookup(tempString);

				//trace(space.textfield.text);

			}


		}

		public function switchWorld():void
		{
			
			
			
			//world2true = true;
			space.world2.width = 0;
			space.world2.visible = true;
			space.world.visible = false;
			var tempX:Number = space.world2.x;
			space.world2.x +=  worldDiam / 2;
			TweenLite.to(space.world2, 0.4, {x: tempX});
			TweenLite.to(space.world2, 0.4, {width: worldDiam});
						
			
			
		}



		public function mousePos(e:MouseEvent):void
		{
			trace(mouseY);
		}

		public function map(val:Number, low:Number, high:Number, low2:Number, high2:Number):Number
		{
			var returnVal:Number;
			// Sets the total range for both in and out
			var inRange:Number = high - low;
			var outRange:Number = high2 - low2;

			//calculates the ratio for the value in relation to the in range
			var ratio:Number = (val - low) / inRange;
			//makes sure that the value is within range
			val = Math.max(low,val);
			val = Math.min(high,val);
			//Finds the same ratio in the out range and shift it into place
			returnVal = (outRange * ratio) + low2;
			return returnVal;
		}


		public function bubble(yPos:Number = 20, xPos:Number = -100, country:String = "Canada", pop:Number = 30000000):void
		{
			if (xPos > 50)
			{
				switchBegin();
			}
			else if (world2true)
			{
				switchBegin();
			}
			xPos = map(xPos,-170,35,500,1200);
			yPos = map(yPos,80,-55,85,875);

			space.bubblegt.textboxinfo.textboxpop.text = country.toUpperCase();
			space.bubblegt.x = xPos;
			space.bubblegt.y = yPos + space.bubblegt.height;

			space.bubblegbb.textboxinfo.textboxpop.text = country.toUpperCase();
			space.bubblegbb.x = xPos;
			space.bubblegbb.y = yPos;

			drawBubble();

		}

		public function drawBubble():void
		{




			var tempSizeX;
			var tempSizeY;

			var tempPosX;
			var tempPosY;


			if ((space.bubblegt.y > space.world.y + worldDiam))
			{
				space.bubblegt.visible = true;
				space.bubblegbb.visible = false;
				space.bubblegt.alpha = 0;
				tempSizeX = space.bubblegt.width;
				tempSizeY = space.bubblegt.height;
				
				if (world2true)
				{
					space.bubblegt.x -= 500;
				}
				else
				{
					tempPosX = space.bubblegt.x;
				}
				

				space.bubblegt.y -=  space.bubblegt.height*2;
				tempPosY = space.bubblegt.y;
				space.bubblegt.height = 0;
				space.bubblegt.width = 0;

				TweenLite.to(space.bubblegt, 1, {y: tempPosY});
				TweenLite.to(space.bubblegt, 1, {width: tempSizeX});
				TweenLite.to(space.bubblegt, 1, {height: tempSizeY});
				TweenLite.to(space.bubblegt, 1, {alpha: 1});

			}
			else
			{

				space.bubblegbb.visible = true;
				space.bubblegt.visible = false;
				space.bubblegbb.alpha = 0;
				tempSizeX = space.bubblegbb.width;
				tempSizeY = space.bubblegbb.height;
				
				if (world2true)
				{
					space.bubblegbb.x -= 500;
				}
				else
				{

				tempPosX = space.bubblegbb.x;
				}
				tempPosY = space.bubblegbb.y;

				space.bubblegbb.y +=  space.bubblegbb.height;
				space.bubblegbb.height = 0;
				space.bubblegbb.width = 0;

				TweenLite.to(space.bubblegbb, 1, {y: tempPosY});
				TweenLite.to(space.bubblegbb, 1, {width: tempSizeX});
				TweenLite.to(space.bubblegbb, 1, {height: tempSizeY});
				TweenLite.to(space.bubblegbb, 1, {alpha: 1});
			}



		}

		public function onLoaded(e:Event):void
		{
			countries = e.target.data.split(/\n/);

		}

		public function csvLoaded(e:Event):void
		{
			population = e.target.data.split(/\n/);



		}

		public function lookup(country:String):void
		{
			var lat:Number = 0;
			var long:Number = 0;
			var i = 0;
			var lookupResult;
			for (var element in countries)
			{


				if (((countries[i]).toLowerCase()).indexOf((country.toLowerCase())) >= 0)
				{
					//trace(countries[i]);
					var lineArray = countries[i].split(' ');
					trace(lineArray);

					var temp;
					var j;

					for (var k = 0; k < lineArray.length; k++)
					{
						temp = lineArray[k].toString();
						trace(lineArray[k]);

						for (var num = 0; num < 10; num++)
						{
							if (lineArray[k].indexOf(num.toString()) >= 0)
							{
								trace("number");
								j = k;

							}

							if (j == k)
							{
								break;
							}
						}

						if (j == k)
						{
							break;
						}


					}



					trace(j);


					lat = lineArray[j];

					trace(lat);

					if (lineArray[j + 2].indexOf("S") >= 0)
					{
						lat *=  -1;
					}
					
					long = lineArray[j + 3];
					if (lineArray[j + 5].indexOf("W") >= 0)
					{
						long *=  -1;
						world2true = false;
					}
					else
					{
						world2true=true;
					}


					trace("complete");
				}

				i++;

			}

			var pop:Number;
			var temp2;
			var temp3;

			for (var m = 0; m < population.length; m++)
			{
				temp2 = population[m].split(',');


				if ((country.toLowerCase()).indexOf(temp2[0]) >= 0)
				{
					trace(temp2);
				}


			}





			trace(lat + " " + long);

			bubble(lat, long, country);
		}




	}

}