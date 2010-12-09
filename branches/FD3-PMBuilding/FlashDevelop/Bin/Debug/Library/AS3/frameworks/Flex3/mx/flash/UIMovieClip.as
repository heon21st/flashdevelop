﻿package mx.flash
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import mx.automation.IAutomationObject;
	import mx.core.IConstraintClient;
	import mx.core.IDeferredInstantiationUIComponent;
	import mx.core.IFlexDisplayObject;
	import mx.core.IInvalidating;
	import mx.core.IStateClient;
	import mx.core.IUIComponent;
	import mx.core.UIComponentDescriptor;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.MoveEvent;
	import mx.events.ResizeEvent;
	import mx.events.StateChangeEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.IToolTipManagerClient;
	import flash.events.FocusEvent;

	/**
	 *  Dispatched when the component is added to a container as a content child
	 */
	[Event(name="add", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the component has finished its construction.
	 */
	[Event(name="creationComplete", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when an object's state changes from visible to invisible.
	 */
	[Event(name="hide", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the component has finished its construction
	 */
	[Event(name="initialize", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the object has moved.
	 */
	[Event(name="move", type="mx.events.MoveEvent")] 
	/**
	 *  Dispatched at the beginning of the component initialization sequence. 
	 */
	[Event(name="preinitialize", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the component is removed from a container as a content child
	 */
	[Event(name="remove", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched when the component is resized.
	 */
	[Event(name="resize", type="mx.events.ResizeEvent")] 
	/**
	 *  Dispatched when an object's state changes from invisible to visible.
	 */
	[Event(name="show", type="mx.events.FlexEvent")] 
	/**
	 *  Dispatched from a component opened using the PopUpManager 
	 */
	[Event(name="mouseDownOutside", type="mx.events.FlexMouseEvent")] 
	/**
	 *  Dispatched from a component opened using the PopUpManager 
	 */
	[Event(name="mouseWheelOutside", type="mx.events.FlexMouseEvent")] 
	/**
	 *  Dispatched by a component when the user moves the mouse over the component
	 */
	[Event(name="dragEnter", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched by a component when the user moves the mouse while over the component
	 */
	[Event(name="dragOver", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched by the component when the user drags outside the component,
	 */
	[Event(name="dragExit", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched by the drop target when the user releases the mouse over it.
	 */
	[Event(name="dragDrop", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched by the drag initiator (the component that is the source
	 */
	[Event(name="dragComplete", type="mx.events.DragEvent")] 
	/**
	 *  Dispatched after the <code>currentState</code> property changes,
	 */
	[Event(name="currentStateChanging", type="mx.events.StateChangeEvent")] 
	/**
	 *  Dispatched after the view state has changed.
	 */
	[Event(name="currentStateChange", type="mx.events.StateChangeEvent")] 
	/**
	 *  Dispatched by the component when it is time to create a ToolTip.
	 */
	[Event(name="toolTipCreate", type="mx.events.ToolTipEvent")] 
	/**
	 *  Dispatched by the component when its ToolTip has been hidden
	 */
	[Event(name="toolTipEnd", type="mx.events.ToolTipEvent")] 
	/**
	 *  Dispatched by the component when its ToolTip is about to be hidden.
	 */
	[Event(name="toolTipHide", type="mx.events.ToolTipEvent")] 
	/**
	 *  Dispatched by the component when its ToolTip is about to be shown.
	 */
	[Event(name="toolTipShow", type="mx.events.ToolTipEvent")] 
	/**
	 *  Dispatched by the component when its ToolTip has been shown.
	 */
	[Event(name="toolTipShown", type="mx.events.ToolTipEvent")] 
	/**
	 *  Dispatched by a component whose <code>toolTip</code> property is set,
	 */
	[Event(name="toolTipStart", type="mx.events.ToolTipEvent")] 

	/**
	 *  Components created in Adobe Flash CS3 Professional for use in Flex 
	 */
	public dynamic class UIMovieClip extends MovieClip implements IDeferredInstantiationUIComponent
	{
		protected var initialized : Boolean;
		private var validateMeasuredSizeFlag : Boolean;
		private var _parent : DisplayObjectContainer;
		private var stateMap : Object;
		private var focusableObjects : Array;
		private var reverseDirectionFocus : Boolean;
		private var focusListenersAdded : Boolean;
		private var transitionStartFrame : Number;
		private var transitionEndFrame : Number;
		private var transitionDirection : Number;
		private var transitionEndState : String;
		private var oldX : Number;
		private var oldY : Number;
		protected var trackSizeChanges : Boolean;
		private var oldWidth : Number;
		private var oldHeight : Number;
		private var explicitSizeChanged : Boolean;
		private var explicitTabEnabledChanged : Boolean;
		/**
		 *  Name of the object to use as the bounding box.
		 */
		public var boundingBoxName : String;
		private var _baseline : *;
		private var _bottom : *;
		private var _horizontalCenter : *;
		private var _left : *;
		private var _right : *;
		private var _top : *;
		private var _verticalCenter : *;
		private var _descriptor : UIComponentDescriptor;
		private var _id : String;
		private var _document : Object;
		private var _explicitHeight : Number;
		private var _explicitMaxHeight : Number;
		private var _explicitMaxWidth : Number;
		private var _explicitMinHeight : Number;
		private var _explicitMinWidth : Number;
		private var _explicitWidth : Number;
		private var _focusPane : Sprite;
		private var _includeInLayout : Boolean;
		private var _isPopUp : Boolean;
		private var _measuredMinHeight : Number;
		private var _measuredMinWidth : Number;
		private var _owner : DisplayObjectContainer;
		private var _percentHeight : Number;
		private var _percentWidth : Number;
		private var _systemManager : ISystemManager;
		private var _tweeningProperties : Array;
		/**
		 *  @private
		 */
		protected var _height : Number;
		private var _measuredHeight : Number;
		private var _measuredWidth : Number;
		/**
		 *  @private
		 */
		protected var _width : Number;
		private var _toolTip : String;
		private var _focusEnabled : Boolean;
		private var _currentState : String;
		private var _automationDelegate : IAutomationObject;
		/**
		 *  @private
		 */
		private var _automationName : String;
		/**
		 *  @private
		 */
		private var _showInAutomationHierarchy : Boolean;

		/**
		 *  Baseline constraint.
		 */
		public function get baseline () : *;
		public function set baseline (value:*) : void;
		/**
		 *  Bottom constraint.
		 */
		public function get bottom () : *;
		public function set bottom (value:*) : void;
		/**
		 *  Horizontal Center constraint.
		 */
		public function get horizontalCenter () : *;
		public function set horizontalCenter (value:*) : void;
		/**
		 *  Left constraint.
		 */
		public function get left () : *;
		public function set left (value:*) : void;
		/**
		 *  Right constraint.
		 */
		public function get right () : *;
		public function set right (value:*) : void;
		/**
		 *  Top constraint.
		 */
		public function get top () : *;
		public function set top (value:*) : void;
		/**
		 *  Vertical Center constraint.
		 */
		public function get verticalCenter () : *;
		public function set verticalCenter (value:*) : void;
		/**
		 *  Used by Flex to suggest bitmap caching for the object.
		 */
		public function set cacheHeuristic (value:Boolean) : void;
		/**
		 *  Specifies the bitmap caching policy for this object.
		 */
		public function get cachePolicy () : String;
		/**
		 *  Reference to the UIComponentDescriptor, if any, that was used
		 */
		public function get descriptor () : UIComponentDescriptor;
		/**
		 *  @private
		 */
		public function set descriptor (value:UIComponentDescriptor) : void;
		/**
		 *  ID of the component. This value becomes the instance name of the object
		 */
		public function get id () : String;
		/**
		 *  @private
		 */
		public function set id (value:String) : void;
		/**
		 *  The y-coordinate of the baseline
		 */
		public function get baselinePosition () : Number;
		/**
		 *  @copy mx.core.IUIComponent#document
		 */
		public function get document () : Object;
		/**
		 *  @private
		 */
		public function set document (value:Object) : void;
		/**
		 *  The explicitly specified height for the component, 
		 */
		public function get explicitHeight () : Number;
		/**
		 *  @private
		 */
		public function set explicitHeight (value:Number) : void;
		/**
		 *  Number that specifies the maximum height of the component, 
		 */
		public function get explicitMaxHeight () : Number;
		public function set explicitMaxHeight (value:Number) : void;
		/**
		 *  Number that specifies the maximum width of the component, 
		 */
		public function get explicitMaxWidth () : Number;
		public function set explicitMaxWidth (value:Number) : void;
		/**
		 *  Number that specifies the minimum height of the component, 
		 */
		public function get explicitMinHeight () : Number;
		public function set explicitMinHeight (value:Number) : void;
		/**
		 *  Number that specifies the minimum width of the component, 
		 */
		public function get explicitMinWidth () : Number;
		public function set explicitMinWidth (value:Number) : void;
		/**
		 *  The explicitly specified width for the component, 
		 */
		public function get explicitWidth () : Number;
		public function set explicitWidth (value:Number) : void;
		/**
		 *  A single Sprite object that is shared among components
		 */
		public function get focusPane () : Sprite;
		/**
		 *  @private
		 */
		public function set focusPane (value:Sprite) : void;
		/**
		 *  Specifies whether this component is included in the layout of the
		 */
		public function get includeInLayout () : Boolean;
		/**
		 *  @private
		 */
		public function set includeInLayout (value:Boolean) : void;
		/**
		 *  Set to <code>true</code> by the PopUpManager to indicate
		 */
		public function get isPopUp () : Boolean;
		/**
		 *  @private
		 */
		public function set isPopUp (value:Boolean) : void;
		/**
		 *  Number that specifies the maximum height of the component, 
		 */
		public function get maxHeight () : Number;
		public function set maxHeight (value:Number) : void;
		/**
		 *  Number that specifies the maximum width of the component, 
		 */
		public function get maxWidth () : Number;
		public function set maxWidth (value:Number) : void;
		/**
		 *  The default minimum height of the component, in pixels.
		 */
		public function get measuredMinHeight () : Number;
		/**
		 *  @private
		 */
		public function set measuredMinHeight (value:Number) : void;
		/**
		 *  The default minimum width of the component, in pixels.
		 */
		public function get measuredMinWidth () : Number;
		/**
		 *  @private
		 */
		public function set measuredMinWidth (value:Number) : void;
		/**
		 *  Number that specifies the minimum height of the component, 
		 */
		public function get minHeight () : Number;
		public function set minHeight (value:Number) : void;
		/**
		 *  Number that specifies the minimum width of the component, 
		 */
		public function get minWidth () : Number;
		public function set minWidth (value:Number) : void;
		/**
		 *  Your owner is usually your parent, however
		 */
		public function get owner () : DisplayObjectContainer;
		/**
		 *  @private
		 */
		public function set owner (value:DisplayObjectContainer) : void;
		/**
		 *  Number that specifies the height of a component as a 
		 */
		public function get percentHeight () : Number;
		public function set percentHeight (value:Number) : void;
		/**
		 *  Number that specifies the width of a component as a 
		 */
		public function get percentWidth () : Number;
		public function set percentWidth (value:Number) : void;
		/**
		 *  A reference to the SystemManager object for this component.
		 */
		public function get systemManager () : ISystemManager;
		/**
		 *  @private
		 */
		public function set systemManager (value:ISystemManager) : void;
		/**
		 *  Used by EffectManager.
		 */
		public function get tweeningProperties () : Array;
		/**
		 *  @private
		 */
		public function set tweeningProperties (value:Array) : void;
		/**
		 *  @private
		 */
		public function set visible (value:Boolean) : void;
		/**
		 *  The height of this object, in pixels.
		 */
		public function get height () : Number;
		/**
		 *  @private
		 */
		public function set height (value:Number) : void;
		/**
		 *  The measured height of this object.
		 */
		public function get measuredHeight () : Number;
		/**
		 *  The measured width of this object.
		 */
		public function get measuredWidth () : Number;
		/**
		 *  The width of this object, in pixels.
		 */
		public function get width () : Number;
		/**
		 *  @private
		 */
		public function set width (value:Number) : void;
		/**
		 *  Text to display in the ToolTip.
		 */
		public function get toolTip () : String;
		/**
		 *  @private
		 */
		public function set toolTip (value:String) : void;
		/**
		 *  A flag that indicates whether the component can receive focus when selected.
		 */
		public function get focusEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set focusEnabled (value:Boolean) : void;
		/**
		 *  A flag that indicates whether the component can receive focus 
		 */
		public function get mouseFocusEnabled () : Boolean;
		/**
		 *  The unscaled bounds of the content.
		 */
		protected function get bounds () : Rectangle;
		/**
		 *  @private
		 */
		public function get parent () : DisplayObjectContainer;
		/**
		 *  The document containing this component.
		 */
		public function get parentDocument () : Object;
		/**
		 *  The current state of this component. For UIMovieClip, the value of the 
		 */
		public function get currentState () : String;
		public function set currentState (value:String) : void;
		/**
		 *  @private
		 */
		public function get tabEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set tabEnabled (value:Boolean) : void;
		/**
		 *  The delegate object that handles the automation-related functionality.
		 */
		public function get automationDelegate () : Object;
		/**
		 *  @private
		 */
		public function set automationDelegate (value:Object) : void;
		/**
		 *  @inheritDoc
		 */
		public function get automationName () : String;
		/**
		 *  @private
		 */
		public function set automationName (value:String) : void;
		/**
		 *  @copy mx.automation.IAutomationObject#automationValue
		 */
		public function get automationValue () : Array;
		/**
		 *  @inheritDoc
		 */
		public function get showInAutomationHierarchy () : Boolean;
		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;
		/**
		 *  @inheritDoc
		 */
		public function get numAutomationChildren () : int;
		/**
		 *  @inheritDoc
		 */
		public function get automationTabularData () : Object;

		/**
		 *  Constructor.
		 */
		public function UIMovieClip ();
		/**
		 *  Creates an <code>id</code> reference to this IUIComponent object
		 */
		public function createReferenceOnParentDocument (parentDocument:IFlexDisplayObject) : void;
		/**
		 *  Deletes the <code>id</code> reference to this IUIComponent object
		 */
		public function deleteReferenceOnParentDocument (parentDocument:IFlexDisplayObject) : void;
		/**
		 *  Executes the data bindings into this UIComponent object.
		 */
		public function executeBindings (recurse:Boolean = false) : void;
		/**
		 *  For each effect event, register the EffectManager
		 */
		public function registerEffects (effects:Array) : void;
		public function getConstraintValue (constraintName:String) : *;
		public function setConstraintValue (constraintName:String, value:*) : void;
		/**
		 *  Initialize the object.
		 */
		public function initialize () : void;
		/**
		 *  Called by Flex when a UIComponent object is added to or removed from a parent.
		 */
		public function parentChanged (p:DisplayObjectContainer) : void;
		/**
		 *  A convenience method for determining whether to use the
		 */
		public function getExplicitOrMeasuredWidth () : Number;
		/**
		 *  A convenience method for determining whether to use the
		 */
		public function getExplicitOrMeasuredHeight () : Number;
		/**
		 *  Called when the <code>visible</code> property changes.
		 */
		public function setVisible (value:Boolean, noEvent:Boolean = false) : void;
		/**
		 *  Returns <code>true</code> if the chain of <code>owner</code> properties 
		 */
		public function owns (displayObject:DisplayObject) : Boolean;
		/**
		 *  Moves this object to the specified x and y coordinates.
		 */
		public function move (x:Number, y:Number) : void;
		/**
		 *  Sets the actual size of this object.
		 */
		public function setActualSize (newWidth:Number, newHeight:Number) : void;
		/**
		 *  Called by the FocusManager when the component receives focus.
		 */
		public function setFocus () : void;
		/**
		 *  Called by the FocusManager when the component receives focus.
		 */
		public function drawFocus (isFocused:Boolean) : void;
		/**
		 *  Validate the measuredWidth and measuredHeight properties to match the 
		 */
		private function validateMeasuredSize () : void;
		/**
		 *  Notify our parent that our size has changed.
		 */
		protected function notifySizeChanged () : void;
		/**
		 *  @private
		 */
		private function dispatchMoveEvent () : void;
		/**
		 *  @private
		 */
		protected function dispatchResizeEvent () : void;
		/**
		 *  @private
		 */
		protected function sizeChanged (oldValue:Number, newValue:Number) : Boolean;
		/**
		 *  Recursively finds all children that have tabEnabled=true and adds them
		 */
		protected function findFocusCandidates (obj:DisplayObjectContainer) : void;
		/**
		 *  Build a map of state name to labels.
		 */
		private function buildStateMap () : void;
		/**
		 *  The main function that watches our size and progesses through transitions.
		 */
		protected function enterFrameHandler (event:Event) : void;
		/**
		 *  Add the focus event listeners.
		 */
		private function addFocusEventListeners () : void;
		/**
		 *  Remove our focus event listeners.
		 */
		private function removeFocusEventListeners () : void;
		/**
		 *  Called when the focus is changed by keyboard navigation (TAB or Shift+TAB).
		 */
		private function keyFocusChangeHandler (event:FocusEvent) : void;
		/**
		 *  Called when focus is entering any of our children. Make sure our
		 */
		protected function focusInHandler (event:FocusEvent) : void;
		/**
		 *  Called when focus is leaving an object. We check to see if the new
		 */
		private function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  Called during event capture phase when keyboard navigation is changing
		 */
		private function keyFocusChangeCaptureHandler (event:FocusEvent) : void;
		private function creationCompleteHandler (event:Event) : void;
		/**
		 *  @inheritDoc
		 */
		public function createAutomationIDPart (child:IAutomationObject) : Object;
		/**
		 *  @inheritDoc
		 */
		public function resolveAutomationIDPart (criteria:Object) : Array;
		/**
		 *  @inheritDoc
		 */
		public function getAutomationChildAt (index:int) : IAutomationObject;
		/**
		 *  @inheritDoc
		 */
		public function replayAutomatableEvent (event:Event) : Boolean;
	}
}