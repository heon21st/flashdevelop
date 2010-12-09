﻿package mx.effects
{
	import flash.display.DisplayObjectContainer;
	import mx.core.mx_internal;
	import mx.effects.effectClasses.AddChildActionInstance;
	import mx.effects.effectClasses.PropertyChanges;

	/**
	 *  The AddChildAction class defines an action effect that corresponds
	 */
	public class AddChildAction extends Effect
	{
		/**
		 *  @private
		 */
		private static var AFFECTED_PROPERTIES : Array;
		/**
		 *  @private
		 */
		private var localPropertyChanges : Array;
		/**
		 *  The index of the child within the parent.
		 */
		public var index : int;
		/**
		 *  The location where the child component is added.
		 */
		public var relativeTo : DisplayObjectContainer;
		/**
		 *  The position of the child in the display list, relative to the
		 */
		public var position : String;

		/**
		 *  Constructor.
		 */
		public function AddChildAction (target:Object = null);
		/**
		 *  @private
		 */
		public function getAffectedProperties () : Array;
		/**
		 *  @private
		 */
		private function getPropertyChanges (target:Object) : PropertyChanges;
		/**
		 *  @private
		 */
		private function targetSortHandler (first:Object, second:Object) : Number;
		/**
		 *  @private
		 */
		public function createInstances (targets:Array = null) : Array;
		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
		/**
		 *  @private
		 */
		protected function getValueFromTarget (target:Object, property:String) : *;
		/**
		 *  @private
		 */
		protected function applyValueToTarget (target:Object, property:String, value:*, props:Object) : void;
	}
}