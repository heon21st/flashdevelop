﻿package mx.effects.effectClasses
{
	import mx.core.IUIComponent;

	/**
	 *  The PropertyChanges class defines the start and end values
	 */
	public class PropertyChanges
	{
		/**
		 *  An Object containing the ending properties of the <code>target</code>
		 */
		public var end : Object;
		/**
		 *  An Object containing the starting properties of the <code>target</code>
		 */
		public var start : Object;
		/**
		 *  A target component of a transition.
		 */
		public var target : Object;

		/**
		 *  The PropertyChanges constructor.
		 */
		public function PropertyChanges (target:Object);
	}
}