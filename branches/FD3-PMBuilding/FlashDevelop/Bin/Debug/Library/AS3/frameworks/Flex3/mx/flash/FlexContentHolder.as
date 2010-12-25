﻿package mx.flash
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;

	/**
	 *  The FlexContentHolder class is for internal use only.
	 */
	public dynamic class FlexContentHolder extends ContainerMovieClip
	{
		private var flexContent : IUIComponent;
		private var pendingFlexContent : IUIComponent;

		/**
		 *  @inheritDoc
		 */
		public function get content () : IUIComponent;
		public function set content (value:IUIComponent) : void;

		/**
		 *  Constructor.
		 */
		public function FlexContentHolder ();
		/**
		 *  Initialize the object.
		 */
		public function initialize () : void;
		/**
		 *  Sets the actual size of this object.
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;
		/**
		 *  Notify parent that the size of this object has changed.
		 */
		protected function notifySizeChanged () : void;
		/**
		 *  Utility function that prepares Flex content to be used as a child of
		 */
		protected function setFlexContent (value:IUIComponent) : void;
		/**
		 *  @private
		 */
		protected function sizeFlexContent () : void;
	}
}