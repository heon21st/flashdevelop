﻿package mx.managers.systemClasses
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;

	/**
	 * A form that exists in a SystemManager in another sandbox or compiled with
	 */
	public class RemotePopUp extends Object
	{
		public var window : Object;
		public var bridge : Object;

		/**
		 * Create new RemotePopUp. There are two kinds of remote pop ups. One for trusted
		 */
		public function RemotePopUp (window:Object, bridge:Object);
	}
}