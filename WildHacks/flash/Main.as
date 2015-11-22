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
			Intro.visible = false;
			
		}
		
		public function locationShow():void
		{
			TweenLite.to(space.world.locationpop, 2, {alpha:1, onComplete:bubbles});
		}
		
		public function bubbles():void
		{
			TweenLite.to(space, 2, {y:-1080*2, ease:Bounce.easeOut});
			//TweenLite.to(bubble, 2, {y:0, ease:Bounce.easeOut, onComplete:locationFind});
		}


	}

}