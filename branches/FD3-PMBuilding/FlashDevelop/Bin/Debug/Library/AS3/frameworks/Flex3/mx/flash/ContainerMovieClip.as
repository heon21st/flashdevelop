﻿package mx.flash
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import mx.core.IUIComponent;

	/**
	 *  Container components created in Adobe Flash CS3 Professional for use in Flex 
	 */
	public dynamic class ContainerMovieClip extends UIMovieClip
	{
		private var _contentHolder : *;
		private var _content : IUIComponent;

		/**
		 *  @private
		 */
		protected function get contentHolderObj () : FlexContentHolder;
		/**
		 *  The Flex content to display inside this container.
		 */
		public function get content () : IUIComponent;
		/**
		 *  @private
		 */
		public function set content (value:IUIComponent) : void;

		/**
		 *  Constructor
		 */
		public function ContainerMovieClip ();
		/**
		 *  @private
		 */
		protected function findFocusCandidates (obj:DisplayObjectContainer) : void;
		/**
		 *  @private
		 */
		protected function focusInHandler (event:FocusEvent) : void;
	}
}