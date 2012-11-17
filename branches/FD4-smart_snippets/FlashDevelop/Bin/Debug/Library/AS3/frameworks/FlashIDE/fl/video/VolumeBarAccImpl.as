﻿package fl.video
{
	import flash.accessibility.Accessibility;
	import flash.accessibility.AccessibilityImplementation;
	import flash.accessibility.AccessibilityProperties;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.display.Sprite;
	import fl.video.FLVPlayback;
	import fl.video.VideoEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	/**
	 * 
	 */
	public class VolumeBarAccImpl extends AccessibilityImplementation
	{
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_NORMAL : uint = 0x00000000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_FOCUSABLE : uint = 0x00100000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_FOCUSED : uint = 0x00000004;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_SELECTABLE : uint = 0x00200000;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_SELECTED : uint = 0x00000002;
		/**
		 *  @private
		 */
		private static const STATE_SYSTEM_UNAVAILABLE : uint = 0x00000001;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_FOCUS : uint = 0x8005;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_VALUECHANGE : uint = 0x800E;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_SELECTION : uint = 0x8006;
		/**
		 *  @private
		 */
		private static const EVENT_OBJECT_LOCATIONCHANGE : uint = 0x800B;
		/**
		 *  @private
		 */
		private static const ROLE_WINDOW : uint = 0x09;
		/**
		 *  @private
		 */
		private static const ROLE_SLIDER : uint = 0x33;
		/**
		 *  @private
		 */
		private static const ROLE_SYSTEM_INDICATOR : uint = 0x27;
		/**
		 *  @private
		 */
		private static const ROLE_SYSTEM_PUSHBUTTON : uint = 0x2b;
		/**
		 *  @private (protected)
		 */
		protected var master : Sprite;
		/**
		 *  @private (protected)
		 */
		protected var role : uint;
		private var _vc : FLVPlayback;

		/**
		 *  @private (protected)
		 */
		protected function get eventsToHandle () : Array;

		/**
		 *  @private
		 */
		public static function createAccessibilityImplementation (sprite:Sprite) : void;
		/**
		 * Enables accessibility for a component.
		 */
		public static function enableAccessibility () : void;
		/**
		 * @private
		 */
		public function VolumeBarAccImpl (sprite:Sprite);
		/**
		 *  @private
		 */
		public function get_accRole (childID:uint) : uint;
		/**
		 *  @private
		 */
		public function get_accName (childID:uint) : String;
		/**
		 *  @private
		 */
		public function get_accValue (childID:uint) : String;
		/**
		 *  @private
		 */
		protected function getName (childID:uint) : String;
		/**
		 *  @private
		 */
		public function getChildIDArray () : Array;
		/**
		 *  @private
		 */
		public function accLocation (childID:uint) : *;
		/**
		 *  @private
		 */
		public function get_accState (childID:uint) : uint;
		/**
		 *  Utility method determines state of the accessible component.
		 */
		protected function getState (childID:uint) : uint;
		/**
		 *  @private
		 */
		public function get_accDefaultAction (childID:uint) : String;
		/**
		 *  @private
		 */
		public function accDoDefaultAction (childID:uint) : void;
		/**
		 *  @private
		 */
		private function getStatusName () : String;
		/**
		 *  @private
		 */
		protected function eventHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function focusInHandler (event:Event) : void;
	}
}