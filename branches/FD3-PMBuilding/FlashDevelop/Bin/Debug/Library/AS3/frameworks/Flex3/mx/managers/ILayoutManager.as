﻿package mx.managers
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.managers.layoutClasses.PriorityQueue;

	/**
	 *  The LayoutManager is the engine behind
	 */
	public interface ILayoutManager extends IEventDispatcher
	{
		/**
		 *  A flag that indicates whether the LayoutManager allows screen updates
		 */
		public function get usePhasedInstantiation () : Boolean;
		/**
		 *  @private
		 */
		public function set usePhasedInstantiation (value:Boolean) : void;

		/**
		 *  Adds an object to the list of components that want their 
		 */
		public function invalidateProperties (obj:ILayoutManagerClient) : void;
		/**
		 *  Adds an object to the list of components that want their 
		 */
		public function invalidateSize (obj:ILayoutManagerClient) : void;
		/**
		 *  Called when a component changes in some way that its layout and/or visuals
		 */
		public function invalidateDisplayList (obj:ILayoutManagerClient) : void;
		/**
		 *  When properties are changed, components generally do not apply those changes immediately.
		 */
		public function validateNow () : void;
		/**
		 *  When properties are changed, components generally do not apply those changes immediately.
		 */
		public function validateClient (target:ILayoutManagerClient, skipDisplayList:Boolean = false) : void;
		/**
		 *  Returns <code>true</code> if there are components that need validating;
		 */
		public function isInvalid () : Boolean;
	}
}