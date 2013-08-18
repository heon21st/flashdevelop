﻿package fl.controls
{
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.ComponentEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Dispatched when the user presses the Button component.
	 */
	[Event(name="buttonDown", type="fl.events.ComponentEvent")] 
	/**
	 * Dispatched when the value of the <code>selected</code> property
	 */
	[Event(name="change", type="flash.events.Event")] 
	/**
	 * @copy fl.controls.LabelButton#style:upSkin
	 */
	[Style(name="upSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:downSkin
	 */
	[Style(name="downSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:overSkin
	 */
	[Style(name="overSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:disabledSkin
	 */
	[Style(name="disabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedDisabledSkin
	 */
	[Style(name="selectedDisabledSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedUpSkin
	 */
	[Style(name="selectedUpSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedDownSkin
	 */
	[Style(name="selectedDownSkin", type="Class")] 
	/**
	 * @copy fl.controls.LabelButton#style:selectedOverSkin
	 */
	[Style(name="selectedOverSkin", type="Class")] 
	/**
	 * The number of milliseconds to wait after the <code>buttonDown</code> 
	 */
	[Style(name="repeatDelay", type="Number", format="Time")] 
	/**
	 * The interval, in milliseconds, between <code>buttonDown</code> events 
	 */
	[Style(name="repeatInterval", type="Number", format="Time")] 

	/**
	 * The BaseButton class is the base class for all button components, defining 
	 */
	public class BaseButton extends UIComponent
	{
		/**
		 * @private (protected)
		 */
		protected var background : DisplayObject;
		/**
		 * @private (protected)
		 */
		protected var mouseState : String;
		/**
		 * @private (protected)
		 */
		protected var _selected : Boolean;
		/**
		 * @private (protected)
		 */
		protected var _autoRepeat : Boolean;
		/**
		 * @private (protected)
		 */
		protected var pressTimer : Timer;
		/**
		 * @private
		 */
		private var _mouseStateLocked : Boolean;
		/**
		 * @private
		 */
		private var unlockedMouseState : String;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;

		/**
		 * Gets or sets a value that indicates whether the component can accept user 
		 */
		public function get enabled () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 * Gets or sets a Boolean value that indicates whether a toggle button 
		 */
		public function get selected () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set selected (value:Boolean) : void;
		/**
		 * Gets or sets a Boolean value that indicates whether the <code>buttonDown</code> event 
		 */
		public function get autoRepeat () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set autoRepeat (value:Boolean) : void;
		/**
		 * @private
		 */
		public function set mouseStateLocked (value:Boolean) : void;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * Creates a new BaseButton instance.
		 */
		public function BaseButton ();
		/**
		 * Set the mouse state via ActionScript. The BaseButton class
		 */
		public function setMouseState (state:String) : void;
		/**
		 * @private (protected)
		 */
		protected function setupMouseEvents () : void;
		/**
		 * @private (protected)
		 */
		protected function mouseEventHandler (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function startPress () : void;
		/**
		 * @private (protected)
		 */
		protected function buttonDown (event:TimerEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function endPress () : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function drawBackground () : void;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
	}
}