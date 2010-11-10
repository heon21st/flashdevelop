﻿package mx.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextLineMetrics;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;
	import mx.binding.BindingManager;
	import mx.controls.Button;
	import mx.controls.HScrollBar;
	import mx.controls.VScrollBar;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.scrollClasses.ScrollBar;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import mx.events.ScrollEvent;
	import mx.events.ScrollEventDetail;
	import mx.events.ScrollEventDirection;
	import mx.graphics.RoundedRectangle;
	import mx.managers.IFocusManager;
	import mx.managers.IFocusManagerContainer;
	import mx.managers.ILayoutManagerClient;
	import mx.managers.ISystemManager;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.ISimpleStyleClient;
	import mx.styles.IStyleClient;
	import mx.styles.StyleManager;
	import mx.styles.StyleProtoChain;

	/**
	 *  Dispatched after a child has been added to a container.
	 */
	[Event(name="childAdd", type="mx.events.ChildExistenceChangedEvent")] 
	/**
	 *  Dispatched after the index (among the container children) 
	 */
	[Event(name="childIndexChange", type="mx.events.IndexChangedEvent")] 
	/**
	 *  Dispatched before a child of a container is removed.
	 */
	[Event(name="childRemove", type="mx.events.ChildExistenceChangedEvent")] 
	/**
	 *  Dispatched when the <code>data</code> property changes.
	 */
	[Event(name="dataChange", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the user manually scrolls the container.
	 */
	[Event(name="scroll", type="mx.events.ScrollEvent")] 
	/**
	 *  If a background image is specified, this style specifies
	 */
	[Style(name="backgroundAttachment", type="String", inherit="no")] 
	/**
	 *  The alpha value for the overlay that is placed on top of the
	 */
	[Style(name="disabledOverlayAlpha", type="Number", inherit="no")] 
	/**
	 *  The name of the horizontal scrollbar style.
	 */
	[Style(name="horizontalScrollBarStyleName", type="String", inherit="no")] 
	/**
	 *  The name of the vertical scrollbar style.
	 */
	[Style(name="verticalScrollBarStyleName", type="String", inherit="no")] 
	/**
	 *  Number of pixels between the container's bottom border
	 */
	[Style(name="paddingBottom", type="Number", format="Length", inherit="no")] 
	/**
	 *  Number of pixels between the container's top border
	 */
	[Style(name="paddingTop", type="Number", format="Length", inherit="no")] 

	/**
	 *  The Container class is an abstract base class for components that
	 */
	public class Container extends UIComponent implements IContainer
	{
		/**
		 *  @private
		 */
		private static const MULTIPLE_PROPERTIES : String = "<MULTIPLE>";
		/**
		 *  The creation policy of this container. 
		 */
		protected var actualCreationPolicy : String;
		/**
		 *  @private
		 */
		private var numChildrenBefore : int;
		/**
		 *  @private
		 */
		private var recursionFlag : Boolean;
		/**
		 *  @private
		 */
		private var forceLayout : Boolean;
		/**
		 *  @private
		 */
		local var doingLayout : Boolean;
		/**
		 *  @private
		 */
		private var changedStyles : String;
		/**
		 *  @private
		 */
		private var _creatingContentPane : Boolean;
		/**
		 *  @private
		 */
		protected var whiteBox : Shape;
		/**
		 *  @private
		 */
		local var contentPane : Sprite;
		/**
		 *  @private
		 */
		private var scrollPropertiesChanged : Boolean;
		private var scrollPositionChanged : Boolean;
		private var horizontalScrollPositionPending : Number;
		private var verticalScrollPositionPending : Number;
		/**
		 *  @private
		 */
		private var scrollableWidth : Number;
		private var scrollableHeight : Number;
		private var viewableWidth : Number;
		private var viewableHeight : Number;
		/**
		 *  @private
		 */
		local var border : IFlexDisplayObject;
		/**
		 *  @private
		 */
		local var blocker : Sprite;
		/**
		 *  @private
		 */
		private var mouseEventReferenceCount : int;
		/**
		 *  @private
		 */
		private var _focusPane : Sprite;
		/**
		 *  @private
		 */
		local var _numChildren : int;
		/**
		 *  @private
		 */
		private var _autoLayout : Boolean;
		/**
		 *  @private
		 */
		private var _childDescriptors : Array;
		/**
		 *  @private
		 */
		private var _childRepeaters : Array;
		/**
		 *  @private
		 */
		private var _clipContent : Boolean;
		/**
		 *  @private
		 */
		private var _createdComponents : Array;
		/**
		 *  @private
		 */
		private var _creationIndex : int;
		/**
		 *  @private
		 */
		private var _creationPolicy : String;
		/**
		 *  @private
		 */
		private var _defaultButton : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private var _data : Object;
		/**
		 *  @private
		 */
		private var _firstChildIndex : int;
		/**
		 *  @private
		 */
		private var _horizontalLineScrollSize : Number;
		/**
		 *  @private
		 */
		private var _horizontalPageScrollSize : Number;
		/**
		 *  @private
		 */
		private var _horizontalScrollBar : ScrollBar;
		/**
		 *  @private
		 */
		private var _horizontalScrollPosition : Number;
		/**
		 *  @private
		 */
		local var _horizontalScrollPolicy : String;
		/**
		 *  @private
		 */
		private var _icon : Class;
		/**
		 *  @private
		 */
		private var _label : String;
		/**
		 *  @private
		 */
		private var _numChildrenCreated : int;
		/**
		 *  @private
		 */
		private var _rawChildren : ContainerRawChildrenList;
		/**
		 *  @private
		 */
		private var _verticalLineScrollSize : Number;
		/**
		 *  @private
		 */
		private var _verticalPageScrollSize : Number;
		/**
		 *  @private
		 */
		private var _verticalScrollBar : ScrollBar;
		/**
		 *  @private
		 */
		private var _verticalScrollPosition : Number;
		/**
		 *  @private
		 */
		local var _verticalScrollPolicy : String;
		/**
		 *  @private
		 */
		private var _viewMetrics : EdgeMetrics;
		/**
		 *  @private
		 */
		private var _viewMetricsAndPadding : EdgeMetrics;
		/**
		 *  @private
		 */
		private var _forceClippingCount : int;

		/**
		 *  Containers use an internal content pane to control scrolling. 
		 */
		public function get creatingContentPane () : Boolean;
		public function set creatingContentPane (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @copy mx.core.UIComponent#contentMouseX
		 */
		public function get contentMouseX () : Number;
		/**
		 *  @copy mx.core.UIComponent#contentMouseY
		 */
		public function get contentMouseY () : Number;
		/**
		 *  @private
		 */
		public function set doubleClickEnabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set enabled (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (o:Sprite) : void;
		/**
		 *  @private
		 */
		function get $numChildren () : int;
		/**
		 *  Number of child components in this container.
		 */
		public function get numChildren () : int;
		/**
		 *  If <code>true</code>, measurement and layout are done
		 */
		public function get autoLayout () : Boolean;
		/**
		 *  @private
		 */
		public function set autoLayout (value:Boolean) : void;
		/**
		 *  Returns an EdgeMetrics object that has four properties:
		 */
		public function get borderMetrics () : EdgeMetrics;
		/**
		 *  Array of UIComponentDescriptor objects produced by the MXML compiler.
		 */
		public function get childDescriptors () : Array;
		/**
		 *  @private
		 */
		function get childRepeaters () : Array;
		/**
		 *  @private
		 */
		function set childRepeaters (value:Array) : void;
		/**
		 *  Whether to apply a clip mask if the positions and/or sizes
		 */
		public function get clipContent () : Boolean;
		/**
		 *  @private
		 */
		public function set clipContent (value:Boolean) : void;
		/**
		 *  @private
		 */
		function get createdComponents () : Array;
		/**
		 *  @private
		 */
		function set createdComponents (value:Array) : void;
		/**
		 *  Specifies the order to instantiate and draw the children
		 */
		public function get creationIndex () : int;
		/**
		 *  @private
		 */
		public function set creationIndex (value:int) : void;
		/**
		 *  The child creation policy for this Container.
		 */
		public function get creationPolicy () : String;
		/**
		 *  @private
		 */
		public function set creationPolicy (value:String) : void;
		/**
		 *  The Button control designated as the default button
		 */
		public function get defaultButton () : IFlexDisplayObject;
		/**
		 *  @private
		 */
		public function set defaultButton (value:IFlexDisplayObject) : void;
		/**
		 *  The <code>data</code> property lets you pass a value
		 */
		public function get data () : Object;
		/**
		 *  @private
		 */
		public function set data (value:Object) : void;
		/**
		 *  @private
		 */
		function get firstChildIndex () : int;
		/**
		 *  Number of pixels to move when the left- or right-arrow
		 */
		public function get horizontalLineScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set horizontalLineScrollSize (value:Number) : void;
		/**
		 *  Number of pixels to move when the track in the
		 */
		public function get horizontalPageScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set horizontalPageScrollSize (value:Number) : void;
		/**
		 *  The horizontal scrollbar used in this container.
		 */
		public function get horizontalScrollBar () : ScrollBar;
		/**
		 *  @private
		 */
		public function set horizontalScrollBar (value:ScrollBar) : void;
		/**
		 *  The current position of the horizontal scroll bar.
		 */
		public function get horizontalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set horizontalScrollPosition (value:Number) : void;
		/**
		 *  Specifies whether the horizontal scroll bar is always present,
		 */
		public function get horizontalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set horizontalScrollPolicy (value:String) : void;
		/**
		 *  The Class of the icon displayed by some navigator
		 */
		public function get icon () : Class;
		/**
		 *  @private
		 */
		public function set icon (value:Class) : void;
		/**
		 *  The text displayed by some navigator containers to represent
		 */
		public function get label () : String;
		/**
		 *  @private
		 */
		public function set label (value:String) : void;
		/**
		 *  The largest possible value for the
		 */
		public function get maxHorizontalScrollPosition () : Number;
		/**
		 *  The largest possible value for the
		 */
		public function get maxVerticalScrollPosition () : Number;
		/**
		 *  @private
		 */
		function get numChildrenCreated () : int;
		/**
		 *  @private
		 */
		function set numChildrenCreated (value:int) : void;
		/**
		 *  @private 
		 */
		function get numRepeaters () : int;
		/**
		 *  A container typically contains child components, which can be enumerated
		 */
		public function get rawChildren () : IChildList;
		/**
		 *  @private
		 */
		function get usePadding () : Boolean;
		/**
		 *  Number of pixels to scroll when the up- or down-arrow
		 */
		public function get verticalLineScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set verticalLineScrollSize (value:Number) : void;
		/**
		 *  Number of pixels to scroll when the track
		 */
		public function get verticalPageScrollSize () : Number;
		/**
		 *  @private
		 */
		public function set verticalPageScrollSize (value:Number) : void;
		/**
		 *  The vertical scrollbar used in this container.
		 */
		public function get verticalScrollBar () : ScrollBar;
		/**
		 *  @private
		 */
		public function set verticalScrollBar (value:ScrollBar) : void;
		/**
		 *  The current position of the vertical scroll bar.
		 */
		public function get verticalScrollPosition () : Number;
		/**
		 *  @private
		 */
		public function set verticalScrollPosition (value:Number) : void;
		/**
		 *  Specifies whether the vertical scroll bar is always present,
		 */
		public function get verticalScrollPolicy () : String;
		/**
		 *  @private
		 */
		public function set verticalScrollPolicy (value:String) : void;
		/**
		 *  Returns an object that has four properties: <code>left</code>,
		 */
		public function get viewMetrics () : EdgeMetrics;
		/**
		 *  Returns an object that has four properties: <code>left</code>,
		 */
		public function get viewMetricsAndPadding () : EdgeMetrics;
		function set forceClipping (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function Container ();
		/**
		 *  @private
		 */
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void;
		/**
		 *  @private
		 */
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void;
		/**
		 *  Adds a child DisplayObject to this Container.
		 */
		public function addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  Adds a child DisplayObject to this Container.
		 */
		public function addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  Removes a child DisplayObject from the child list of this Container.
		 */
		public function removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  Removes a child DisplayObject from the child list of this Container
		 */
		public function removeChildAt (index:int) : DisplayObject;
		/**
		 *  Gets the <i>n</i>th child component object.
		 */
		public function getChildAt (index:int) : DisplayObject;
		/**
		 *  Returns the child whose <code>name</code> property is the specified String.
		 */
		public function getChildByName (name:String) : DisplayObject;
		/**
		 *  Gets the zero-based index of a specific child.
		 */
		public function getChildIndex (child:DisplayObject) : int;
		/**
		 *  Sets the index of a particular child.
		 */
		public function setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		public function contains (child:DisplayObject) : Boolean;
		/**
		 *  @private
		 */
		public function initialize () : void;
		/**
		 *  @private
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		protected function initializationComplete () : void;
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		public function validateSize (recursive:Boolean = false) : void;
		/**
		 *  @private
		 */
		public function validateDisplayList () : void;
		/**
		 *  Respond to size changes by setting the positions and sizes
		 */
		protected function updateDisplayList (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  @copy mx.core.UIComponent#contentToGlobal()
		 */
		public function contentToGlobal (point:Point) : Point;
		/**
		 *  @copy mx.core.UIComponent#globalToContent()
		 */
		public function globalToContent (point:Point) : Point;
		/**
		 *  @copy mx.core.UIComponent#contentToLocal()
		 */
		public function contentToLocal (point:Point) : Point;
		/**
		 *  @copy mx.core.UIComponent#localToContent()
		 */
		public function localToContent (point:Point) : Point;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		public function notifyStyleChangeInChildren (styleProp:String, recursive:Boolean) : void;
		/**
		 *  @private
		 */
		public function regenerateStyleCache (recursive:Boolean) : void;
		/**
		 *  Used internally by the Dissolve Effect to add the overlay to the chrome of a container.
		 */
		protected function attachOverlay () : void;
		/**
		 *  Fill an overlay object which is always the topmost child in the container.
		 */
		function fillOverlay (overlay:UIComponent, color:uint, targetArea:RoundedRectangle = null) : void;
		/**
		 *  Executes all the data bindings on this Container. Flex calls this method
		 */
		public function executeBindings (recurse:Boolean = false) : void;
		/**
		 *  @private
		 */
		public function prepareToPrint (target:IFlexDisplayObject) : Object;
		/**
		 *  @private
		 */
		public function finishPrint (obj:Object, target:IFlexDisplayObject) : void;
		/**
		 *  @private
		 */
		function addingChild (child:DisplayObject) : void;
		/**
		 *  @private
		 */
		function childAdded (child:DisplayObject) : void;
		/**
		 *  @private
		 */
		function removingChild (child:DisplayObject) : void;
		/**
		 *  @private
		 */
		function childRemoved (child:DisplayObject) : void;
		/**
		 *  Returns an Array of DisplayObject objects consisting of the content children 
		 */
		public function getChildren () : Array;
		/**
		 *  Removes all children from the child list of this container.
		 */
		public function removeAllChildren () : void;
		/**
		 *  @private
		 */
		function setDocumentDescriptor (desc:UIComponentDescriptor) : void;
		/**
		 *  @private
		 */
		function setActualCreationPolicies (policy:String) : void;
		/**
		 *  Iterate through the Array of <code>childDescriptors</code>,
		 */
		public function createComponentsFromDescriptors (recurse:Boolean = true) : void;
		/**
		 *  Given a single UIComponentDescriptor, create the corresponding
		 */
		public function createComponentFromDescriptor (descriptor:ComponentDescriptor, recurse:Boolean) : IFlexDisplayObject;
		/**
		 *  @private
		 */
		private function hasChildMatchingDescriptor (descriptor:UIComponentDescriptor) : Boolean;
		/**
		 *  @private
		 */
		function rawChildren_addChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_addChildAt (child:DisplayObject, index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_removeChild (child:DisplayObject) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_removeChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_getChildAt (index:int) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_getChildByName (name:String) : DisplayObject;
		/**
		 *  @private
		 */
		function rawChildren_getChildIndex (child:DisplayObject) : int;
		/**
		 *  @private
		 */
		function rawChildren_setChildIndex (child:DisplayObject, newIndex:int) : void;
		/**
		 *  @private
		 */
		function rawChildren_getObjectsUnderPoint (pt:Point) : Array;
		/**
		 *  @private
		 */
		function rawChildren_contains (child:DisplayObject) : Boolean;
		/**
		 *  Respond to size changes by setting the positions and sizes
		 */
		protected function layoutChrome (unscaledWidth:Number, unscaledHeight:Number) : void;
		/**
		 *  Creates the container's border skin 
		 */
		protected function createBorder () : void;
		/**
		 *  @private
		 */
		private function isBorderNeeded () : Boolean;
		/**
		 *  @private
		 */
		function invalidateViewMetricsAndPadding () : void;
		/**
		 *  @private
		 */
		private function createOrDestroyBlocker () : void;
		/**
		 *  @private
		 */
		private function updateBackgroundImageRect () : void;
		/**
		 *  @private
		 */
		private function createContentPaneAndScrollbarsIfNeeded () : Boolean;
		/**
		 *  @private
		 */
		function getScrollableRect () : Rectangle;
		/**
		 *  @private
		 */
		private function createScrollbarsIfNeeded (bounds:Rectangle) : Boolean;
		/**
		 *  @private
		 */
		private function createOrDestroyScrollbars (needHorizontal:Boolean, needVertical:Boolean, needContentPane:Boolean) : Boolean;
		/**
		 *  @private
		 */
		private function clampScrollPositions () : Boolean;
		/**
		 *  @private
		 */
		function createContentPane () : void;
		/**
		 *  Positions the container's content area relative to the viewable area 
		 */
		protected function scrollChildren () : void;
		/**
		 *  @private
		 */
		private function dispatchScrollEvent (direction:String, oldPosition:Number, newPosition:Number, detail:String) : void;
		/**
		 *  Executes the bindings into this Container's child UIComponent objects.
		 */
		public function executeChildBindings (recurse:Boolean) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		private function mouseWheelHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function layoutCompleteHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function creationCompleteHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function horizontalScrollBar_scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function verticalScrollBar_scrollHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function blocker_clickHandler (event:Event) : void;
	}
}