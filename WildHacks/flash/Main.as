package 
{

	import flash.display.MovieClip;
	import com.greensock.*;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import com.greensock.easing.*;
	import flash.text.TextField;
	import flash.events.Event;
	import flashx.textLayout.formats.Float;
	import flash.geom.Point;

	public class Main extends MovieClip
	{

		public var select:Boolean = false;
		public var float:Boolean = false;
		public var worldDiam:Number;
		public var world2:Boolean = false;

		public function Main()
		{

			var popupObj:popup = new popup();
			space.world2.visible = false;

			worldDiam = space.world.width;



			Intro.Logo_MC.alpha = 0;
			space.textfield.text = 'Take me around the world!';
			space.textfield.addEventListener(MouseEvent.MOUSE_DOWN, textDown);
			space.textfield.addEventListener(KeyboardEvent.KEY_DOWN, entered);
			space.addEventListener(MouseEvent.MOUSE_DOWN, mousePos);


			TweenLite.to(Intro.Logo_MC, 2, {alpha:1});


			addEventListener(MouseEvent.CLICK, clicked);
			//trace("hi");

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
			//TweenLite.to(space.world, 2, {y:tempY, ease:Sine.easeInOut, onComplete:floatingDown});

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
			//TweenLite.to(space.world, 2, {y:tempY, ease:Sine.easeInOut, onComplete:floatingDown});

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


			//TweenLite.to(space.world2, 2, {y:tempY, ease:Sine.easeInOut});
			//TweenLite.to(space.world, 2, {y:tempY, ease:Sine.easeInOut, onComplete:floating});
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

			var tempX:Number = space.world2.x + worldDiam / 2;
			TweenLite.to(space.world, 0.4, {x: tempX});
			TweenLite.to(space.world, 0.4, {width: 0, onComplete:switchWorld});



		}

		public function entered(e:KeyboardEvent):void
		{
			if (e.keyCode == 13)
			{
				//Request DATABASE INFO

				//trace(space.textfield.text);
				bubble(-100, 30);
			}

			
		}

		public function switchWorld():void
		{
			world2 = true;
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


		public function bubble(xPos:Number = -100, yPos:Number = 20, country:String = "Canada", pop:Number = 30000000):void
		{
			xPos = map(xPos, -170, 35, 348, 945);
			yPos = map(yPos, 80, -55, 135, 875);
			
			space.bubbleg.textboxinfo.textboxpop.text = country + "\nPopulation:" + pop;
			space.bubbleg.x = xPos;
			space.bubbleg.y = yPos - space.bubbleg.height;
			
			drawBubble();

		}
		
		public function drawBubble():void
		{
			space.bubbleg.visible = true;
			space.bubbleg.alpha = true;
			var tempSizeX = space.bubbleg.width;
			var tempSizeY = space.bubbleg.height;
			
			var tempPosX = space.bubbleg.x;
			var tempPosY = space.bubbleg.y;
			
			space.bubbleg.y += space.bubbleg.height;
			space.bubbleg.height = 0;
			space.bubbleg.width = 0;
			
			TweenLite.to(space.bubbleg, 1, {y: tempPosY});
			TweenLite.to(space.bubbleg, 1, {width: tempSizeX});
			TweenLite.to(space.bubbleg, 1, {height: tempSizeY});
			TweenLite.to(space.bubbleg, 1, {alpha: 1});
			
			
		}

	}

}