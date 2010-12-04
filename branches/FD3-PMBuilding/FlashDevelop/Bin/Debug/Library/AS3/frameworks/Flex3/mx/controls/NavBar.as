﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.containers.Box;
	import mx.containers.BoxDirection;
	import mx.containers.ViewStack;
	import mx.core.ClassFactory;
	import mx.core.Container;
	import mx.core.FlexVersion;
	import mx.core.IFactory;
	import mx.core.IFlexDisplayObject;
	import mx.core.ScrollPolicy;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.CollectionEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.ItemClickEvent;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.logging.AbstractTarget;

	/**
	 *  Dispatched when a navigation item is selected.
	 */
	[Event(name="itemClick", type="mx.events.ItemClickEvent")] 

	/**
	 *  The NavBar control is the superclass for navigator controls, such as the
	 */
	public class NavBar extends Box
	{
		/**
		 *  @private
		 */
		local var targetStack : ViewStack;
		/**
		 *  @private
		 */
		private var pendingTargetStack : Object;
		/**
		 *  @private
		 */
		local var navItemFactory : IFactory;
		/**
		 *  @private
		 */
		private var lastToolTip : String;
		/**
		 *  @private
		 */
		private var measurementHasBeenCalled : Boolean;
		/**
		 *  @private
		 */
		private var _dataProvider : IList;
		/**
		 *  @private
		 */
		private var dataProviderChanged : Boolean;
		/**
		 *  @private
		 */
		private var _iconField : String;
		/**
		 *  @private
		 */
		private var _labelField : String;
		/**
		 *  @private
		 */
		private var _labelFunction : Function;
		/**
		 *  @private
		 */
		private var _selectedIndex : int;
		/**
		 *  @private
		 */
		private var _toolTipField : String;

		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 *  @private
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;
		/**
		 *  Data used to populate the navigator control.
		 */
		public function get dataProvider () : Object;
		/**
		 *  @private
		 */
		public function set dataProvider (value:Object) : void;
		/**
		 *  Name of the field in the <code>dataProvider</code> object
		 */
		public function get iconField () : String;
		/**
		 *  @private
		 */
		public function set iconField (value:String) : void;
		/**
		 *  Name of the field in the <code>dataProvider</code> object
		 */
		public function get labelField () : String;
		/**
		 *  @private
		 */
		public function set labelField (value:String) : void;
		/**
		 *  A user-supplied function to run on each item to determine its label.  
		 */
		public function get labelFunction () : Function;
		/**
		 *  @private
		 */
		public function set labelFunction (value:Function) : void;
		/**
		 *  Index of the active navigation item,
		 */
		public function get selectedIndex () : int;
		/**
		 *  @private
		 */
		public function set selectedIndex (value:int) : void;
		/**
		 *  Name of the the field in the <code>dataProvider</code> object
		 */
		public function get toolTipField () : String;
		/**
		 *  @private
		 */
		public function set toolTipField (value:String) : void;

		/**
		 *  Constructor.
		 */
		public function NavBar ();
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  Returns the string the renderer would display for the given data object
		 */
		public function itemToLabel (data:Object) : String;
		/**
		 *  Creates the individual navigator items.  
		 */
		protected function createNavItem (label:String, icon:Class = null) : IFlexDisplayObject;
		/**
		 *  Highlights the selected navigator item. 
		 */
		protected function hiliteSelectedNavItem (index:int) : void;
		/**
		 *  Resets the navigator bar to its default state.
		 */
		protected function resetNavItems () : void;
		/**
		 *  Sets the label property of a navigator item in the 
		 */
		protected function updateNavItemLabel (index:int, label:String) : void;
		/**
		 *  Resets the icon of a navigator item in the 
		 */
		protected function updateNavItemIcon (index:int, icon:Class) : void;
		/**
		 *  @private
		 */
		private function createNavChildren () : void;
		/**
		 *  @private
		 */
		private function setTargetViewStack (newStack:Object) : void;
		/**
		 *  @private
		 */
		private function _setTargetViewStack (newStack:Object) : void;
		/**
		 *  @private
		 */
		private function checkPendingTargetStack () : void;
		/**
		 *  @private
		 */
		private function collectionChangeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function childAddHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private
		 */
		private function childRemoveHandler (event:ChildExistenceChangedEvent) : void;
		/**
		 *  @private
		 */
		private function changeHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function childIndexChangeHandler (event:IndexChangedEvent) : void;
		/**
		 *  @private
		 */
		private function labelChangedHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function iconChangedHandler (event:Event) : void;
		/**
		 * @private
		 */
		private function toolTipChangedHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function enabledChangedHandler (event:Event) : void;
		/**
		 *  Handles the <code>MouseEvent.CLICK</code> event 
		 */
		protected function clickHandler (event:MouseEvent) : void;
	}
}