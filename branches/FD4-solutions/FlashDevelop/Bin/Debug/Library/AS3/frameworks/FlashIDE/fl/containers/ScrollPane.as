﻿package fl.containers
{
	import fl.containers.BaseScrollPane;
	import fl.controls.ScrollBar;
	import fl.controls.ScrollPolicy;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.events.ScrollEvent;
	import fl.managers.IFocusManagerComponent;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.ui.Keyboard;

	/**
	 * @copy BaseScrollPane#event:scroll
	 */
	[Event(name="scroll", type="fl.events.ScrollEvent")] 
	/**
	 * Dispatched while content is loading.
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 
	/**
	 * Dispatched when content has finished loading.
	 */
	[Event(name="complete", type="flash.events.Event")] 
	/**
	 * Dispatched when the properties and methods of a loaded SWF file are accessible. 
	 */
	[Event("init", type="flash.events.Event")] 
	/**
	 * Dispatched after an input or output error occurs.
	 */
	[Event("ioError", type="flash.events.IOErrorEvent")] 
	/**
	 * Dispatched after a network operation starts.
	 */
	[Event("open", type="flash.events.Event")] 
	/**
	 * Dispatched after a security error occurs while content is loading.
	 */
	[Event("securityError", type="flash.events.SecurityErrorEvent")] 
	/**
	 * Dispatched when content is loading. This event is dispatched regardless of
	 */
	[Event("progress", type="flash.events.ProgressEvent")] 
	/**
	 * The skin that shows when the scroll pane is disabled.
	 */
	[Style(name="disabledSkin", type="Class")] 
	/**
	 * The default skin shown on the scroll pane.
	 */
	[Style(name="upSkin", type="Class")] 
	/**
	 * The amount of padding to put around the content in the scroll pane, in pixels.
	 */
	[Style(name="contentPadding", type="Number", format="Length")] 

	/**
	 * The ScrollPane component displays display objects and JPEG, GIF, and PNG files,
	 */
	public class ScrollPane extends BaseScrollPane implements IFocusManagerComponent
	{
		/**
		 * @private (protected)
		 */
		protected var _source : Object;
		/**
		 * @private (protected)
		 */
		protected var _scrollDrag : Boolean;
		/**
		 * @private (protected)
		 */
		protected var contentClip : Sprite;
		/**
		 * @private (protected)
		 */
		protected var loader : Loader;
		/**
		 * @private (protected)
		 */
		protected var xOffset : Number;
		/**
		 * @private (protected)
		 */
		protected var yOffset : Number;
		/**
		 * @private (protected)
		 */
		protected var scrollDragHPos : Number;
		/**
		 * @private (protected)
		 */
		protected var scrollDragVPos : Number;
		/**
		 * @private (protected)
		 */
		protected var currentContent : Object;
		/**
		 * @private
		 */
		private static var defaultStyles : Object;

		/**
		 * Gets or sets a value that indicates whether scrolling occurs when a
		 */
		public function get scrollDrag () : Boolean;
		/**
		 * @private (setter)
		 */
		public function set scrollDrag (value:Boolean) : void;
		/**
		 * Gets a number between 0 and 100 indicating what percentage of the content is loaded.
		 */
		public function get percentLoaded () : Number;
		/**
		 * Gets the count of bytes of content that have been loaded.
		 */
		public function get bytesLoaded () : Number;
		/**
		 * Gets the count of bytes of content to be loaded.
		 */
		public function get bytesTotal () : Number;
		/**
		 * Gets a reference to the content loaded into the scroll pane.
		 */
		public function get content () : DisplayObject;
		/**
		 * Gets or sets an absolute or relative URL that identifies the 
		 */
		public function get source () : Object;
		/**
		 * @private (setter)
		 */
		public function set source (value:Object) : void;

		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 */
		public static function getStyleDefinition () : Object;
		/**
		 * Creates a new ScrollPane component instance.
		 */
		public function ScrollPane ();
		/**
		 * Reloads the contents of the scroll pane. 
		 */
		public function refreshPane () : void;
		/**
		 * Refreshes the scroll bar properties based on the width
		 */
		public function update () : void;
		/**
		 * The request parameter of this method accepts only a URLRequest object 
		 */
		public function load (request:URLRequest, context:LoaderContext = null) : void;
		/**
		 * @private (protected)
		 */
		protected function setVerticalScrollPosition (scrollPos:Number, fireEvent:Boolean = false) : void;
		/**
		 * @private (protected)
		 */
		protected function setHorizontalScrollPosition (scrollPos:Number, fireEvent:Boolean = false) : void;
		/**
		 * @private (protected)
		 */
		protected function drawLayout () : void;
		/**
		 * @private (protected)
		 */
		protected function onContentLoad (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function passEvent (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function initLoader () : void;
		/**
		 * @private (protected)
		 */
		protected function handleScroll (event:ScrollEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function handleError (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function handleInit (event:Event) : void;
		/**
		 * @private (protected)
		 */
		protected function clearLoadEvents () : void;
		/**
		 * @private (protected)
		 */
		protected function doDrag (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function doStartDrag (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function endDrag (event:MouseEvent) : void;
		/**
		 * @private (protected)
		 */
		protected function setScrollDrag () : void;
		/**
		 * @private (protected)
		 */
		protected function draw () : void;
		/**
		 * @private (protected)
		 */
		protected function drawBackground () : void;
		/**
		 * @private (protected)
		 */
		protected function clearContent () : void;
		/**
		 * @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 * @private
		 */
		protected function calculateAvailableHeight () : Number;
		/**
		 * @private (protected)
		 */
		protected function configUI () : void;
	}
}