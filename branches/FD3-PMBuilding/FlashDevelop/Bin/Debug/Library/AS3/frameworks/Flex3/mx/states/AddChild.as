﻿package mx.states
{
	import flash.display.DisplayObject;
	import mx.containers.ApplicationControlBar;
	import mx.containers.ControlBar;
	import mx.containers.Panel;
	import mx.core.Application;
	import mx.core.ContainerCreationPolicy;
	import mx.core.IDeferredInstance;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  The AddChild class adds a child display object, such as a component, 
	 */
	public class AddChild implements IOverride
	{
		/**
		 *  @private
		 */
		local var added : Boolean;
		/**
		 *  @private
		 */
		local var instanceCreated : Boolean;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _creationPolicy : String;
		/**
		 *  The position of the child in the display list, relative to the
		 */
		public var position : String;
		/**
		 *  The object relative to which the child is added. This property is used
		 */
		public var relativeTo : UIComponent;
		/**
		 *  @private
		 */
		private var _target : DisplayObject;
		/**
		 *  @private
		 */
		private var _targetFactory : IDeferredInstance;

		/**
		 *  The creation policy for this child.
		 */
		public function get creationPolicy () : String;
		/**
		 *  @private
		 */
		public function set creationPolicy (value:String) : void;
		/**
		 *
		 */
		public function get target () : DisplayObject;
		/**
		 *  @private
		 */
		public function set target (value:DisplayObject) : void;
		/**
		 *
		 */
		public function get targetFactory () : IDeferredInstance;
		/**
		 *  @private
		 */
		public function set targetFactory (value:IDeferredInstance) : void;

		/**
		 *  Constructor.
		 */
		public function AddChild (relativeTo:UIComponent = null, target:DisplayObject = null, position:String = "lastChild");
		/**
		 *  Creates the child instance from the factory.
		 */
		public function createInstance () : void;
		/**
		 *  @inheritDoc
		 */
		public function initialize () : void;
		/**
		 *  @inheritDoc
		 */
		public function apply (parent:UIComponent) : void;
		/**
		 *  @inheritDoc
		 */
		public function remove (parent:UIComponent) : void;
	}
}