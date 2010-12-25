﻿package mx.containers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import mx.controls.Button;
	import mx.controls.TabBar;
	import mx.core.Container;
	import mx.core.EdgeMetrics;
	import mx.core.FlexVersion;
	import mx.core.IFlexDisplayObject;
	import mx.core.IInvalidating;
	import mx.core.IProgrammaticSkin;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.events.ItemClickEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.styles.StyleProxy;
	import flash.ui.Keyboard;

	/**
	 *  Name of CSS style declaration that specifies styles for the first tab.
	 */
	[Style(name="firstTabStyleName", type="String", inherit="no")] 
	/**
	 *  Horizontal positioning of tabs at the top of this TabNavigator container.
	 */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right", inherit="no")] 
	/**
	 *  Separation between tabs, in pixels.
	 */
	[Style(name="horizontalGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  Name of CSS style declaration that specifies styles for the last tab.
	 */
	[Style(name="lastTabStyleName", type="String", inherit="no")] 
	/**
	 *  Name of CSS style declaration that specifies styles for the text
	 */
	[Style(name="selectedTabTextStyleName", type="String", inherit="no")] 
	/**
	 *  Height of each tab, in pixels.
	 */
	[Style(name="tabHeight", type="Number", format="Length", inherit="no")] 
	/**
	 *  Name of CSS style declaration that specifies styles for the tabs.
	 */
	[Style(name="tabStyleName", type="String", inherit="no")] 
	/**
	 *  Width of each tab, in pixels.
	 */
	[Style(name="tabWidth", type="Number", format="Length", inherit="no")] 
	/**
	 *  The horizontal offset, in pixels, of the tab bar from the left edge 
	 */
	[Style(name="tabOffset", type="Number", format="Length", inherit="no")] 

	/**
	 *  The TabNavigator container extends the ViewStack container by including
	 */
	public class TabNavigator extends ViewStack implements IFocusManagerComponent
	{
		/**
		 *  @private
		 */
		private static const MIN_TAB_WIDTH : Number = 30;
		/**
		 *  A reference to the TabBar inside this TabNavigator.
		 */
		protected var tabBar : TabBar;
		private static var _tabBarStyleFilters : Object;

		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		protected function get contentHeight () : Number;
		/**
		 *  @private
		 */
		protected function get contentY () : Number;
		/**
		 *  @private
		 */
		private function get tabBarHeight () : Number;
		/**
		 *  The set of styles to pass from the TabNavigator to the tabBar.
		 */
		protected function get tabBarStyleFilters () : Object;

		/**
		 *  Constructor.
		 */
		public function TabNavigator ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  Calculates the default sizes and mininum and maximum values of this
		 */
		protected function measure () : void;
		/**
		 *  Responds to size changes by setting the positions and sizes
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @private
		 */
		public function drawFocus (isFocused:Boolean) : void;
		/**
		 *  @private
		 */
		protected function adjustFocusRect (object:DisplayObject = null) : void;
		/**
		 *  @private
		 */
		protected function layoutChrome (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Returns the tab of the navigator's TabBar control at the specified
		 */
		public function getTabAt (index:int) : Button;
		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		function getTabBar () : TabBar;
	}
}