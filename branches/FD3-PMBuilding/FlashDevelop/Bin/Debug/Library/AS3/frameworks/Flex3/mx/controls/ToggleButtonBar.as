﻿package mx.controls
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;

	/**
	 *  Name of CSS style declaration that specifies styles for the text of the
	 */
	[Style(name="selectedButtonTextStyleName", type="String", inherit="no")] 

	/**
	 *  The ToggleButtonBar control defines a horizontal or vertical 
	 */
	public class ToggleButtonBar extends ButtonBar
	{
		/**
		 *  @private.
		 */
		private var initializeSelectedButton : Boolean;
		/**
		 *  @private
		 */
		local var selectedButtonTextStyleNameProp : String;
		/**
		 *  @private
		 */
		private var _selectedIndex : int;
		/**
		 *  @private.
		 */
		private var selectedIndexChanged : Boolean;
		/**
		 *  @private
		 */
		private var _toggleOnClick : Boolean;

		/**
		 *  Index of the selected button.
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private.
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 *  Specifies whether the currently selected button can be deselected by
		 */
		public function get toggleOnClick () : Boolean;
		/**
		 *  @private
		 */
		public function set toggleOnClick (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function ToggleButtonBar ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		protected function createNavItem (label:String, icon:Class = null) : IFlexDisplayObject;
		/**
		 *  @private
		 */
		protected function hiliteSelectedNavItem (index:int) : void;
		/**
		 *  @private
		 */
		protected function resetNavItems () : void;
		/**
		 *  @private
		 */
		function selectButton (index:int, updateFocusIndex:Boolean = false, trigger:Event = null) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function keyUpHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function clickHandler (event:MouseEvent) : void;
	}
}