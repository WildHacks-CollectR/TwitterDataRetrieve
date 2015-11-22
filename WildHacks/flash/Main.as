package 
{

	import flash.display.MovieClip;
	import com.greensock.TweenLite;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import com.greensock.easing.*;

	public class Main extends MovieClip
	{
		public function Main()
		{

			Intro.Logo_MC.alpha = 0;
			Intro.space.world.arrowhead.alpha = 0;

			TweenLite.to(Intro.Logo_MC, 2, {alpha:1});


			addEventListener(MouseEvent.CLICK, clicked);
			trace("hi");

		}


		public function clicked(e:MouseEvent):void
		{
			trace("hello");
			TweenLite.to(Intro, 2, {y:-1080, ease:Bounce.easeOut});
			TweenLite.to(space, 2, {y:0, ease:Bounce.easeOut, onComplete:locationFind});
			//TweenLite.to(Intro, 1, {alpha:0, ease:Sine.easeInOut});
			removeEventListener(MouseEvent.CLICK, clicked);
					

		}
		
		public function locationFind():void
		{
			TweenLite.to(space, 2, {scaleX:scaleX*2, ease:Sine.easeInOut});
			TweenLite.to(space, 2, {scaleY:scaleY*2, ease:Sine.easeInOut});
			TweenLite.to(space, 2, {x:x-400, ease:Sine.easeInOut});
			TweenLite.to(space, 2, {y:y-200, ease:Sine.easeInOut, onComplete:locationShow});
		}
		
		public function locationShow():void
		{
			
		}


	}

}