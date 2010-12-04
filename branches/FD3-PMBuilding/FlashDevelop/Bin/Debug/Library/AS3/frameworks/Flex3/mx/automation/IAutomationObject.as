﻿package mx.automation
{
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	/**
	 * The IAutomationObject interface defines the interface 
	 */
	public interface IAutomationObject
	{
		/**
		 *  The delegate object that is handling the automation-related functionality.
		 */
		public function get automationDelegate () : Object;
		/**
		 *  @private
		 */
		public function set automationDelegate (delegate:Object) : void;
		/**
		 *  Name that can be used as an identifier for this object.
		 */
		public function get automationName () : String;
		/**
		 *  @private
		 */
		public function set automationName (name:String) : void;
		/**
		 *  This value generally corresponds to the rendered appearance of the 
		 */
		public function get automationValue () : Array;
		/**
		 *  The number of automation children this container has.
		 */
		public function get numAutomationChildren () : int;
		/**
		 *  A flag that determines if an automation object
		 */
		public function get showInAutomationHierarchy () : Boolean;
		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;
		/**
		 * An implementation of the <code>IAutomationTabularData</code> interface, which 
		 */
		public function get automationTabularData () : Object;

		/**
		 *  Returns a set of properties that identify the child within 
		 */
		public function createAutomationIDPart (child:IAutomationObject) : Object;
		/**
		 *  Resolves a child by using the id provided. The id is a set 
		 */
		public function resolveAutomationIDPart (criteria:Object) : Array;
		/**
		 *  Provides the automation object at the specified index.  This list
		 */
		public function getAutomationChildAt (index:int) : IAutomationObject;
		/**
		 *  Replays the specified event.  A component author should probably call 
		 */
		public function replayAutomatableEvent (event:Event) : Boolean;
	}
}