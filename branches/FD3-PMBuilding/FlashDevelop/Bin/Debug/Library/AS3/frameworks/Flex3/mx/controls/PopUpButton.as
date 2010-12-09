﻿package mx.controls
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.EdgeMetrics;
	import mx.core.IFlexDisplayObject;
	import mx.core.IRectangularBorder;
	import mx.core.IUIComponent;
	import mx.core.FlexVersion;
	import mx.core.UIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Tween;
	import mx.events.DropdownEvent;
	import mx.events.InterManagerRequest;
	import mx.events.ListEvent;
	import mx.events.MenuEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.SandboxMouseEvent;
	import mx.managers.IFocusManagerComponent;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;
	import mx.styles.ISimpleStyleClient;

	/**
	 *  Dispatched when the specified UIComponent closes. 
	 */
	[Event(name="close", type="mx.events.DropdownEvent")] 
	/**
	 *  Dispatched when the specified UIComponent opens.
	 */
	[Event(name="open", type="mx.events.DropdownEvent")] 
	/**
	 *  Number of pixels between the divider line and the right 
	 */
	[Style(name="arrowButtonWidth", type="Number", format="Length", inherit="no")] 
	/**
	 *  Length of a close transition, in milliseconds.
	 */
	[Style(name="closeDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  Easing function to control component closing tween.
	 */
	[Style(name="closeEasingFunction", type="Function", inherit="no")] 
	/**
	 *  The default icon class for the main button.
	 */
	[Style(name="icon", type="Class", inherit="no", states="up, over, down, disabled")] 
	/**
	 *  Length of an open transition, in milliseconds.
	 */
	[Style(name="openDuration", type="Number", format="Time", inherit="no")] 
	/**
	 *  Easing function to control component opening tween.
	 */
	[Style(name="openEasingFunction", type="Function", inherit="no")] 
	/**
	 *  The name of a CSS style declaration used by the control.  
	 */
	[Style(name="popUpStyleName", type="String", inherit="no")] 
	/**
	 *  Skin class for the popUpDown state (when arrowButton is in down 
	 */
	[Style(name="popUpDownSkin", type="Class", inherit="no")] 
	/**
	 *  Number of vertical pixels between the PopUpButton and the
	 */
	[Style(name="popUpGap", type="Number", format="Length", inherit="no")] 
	/**
	 *  The icon used for the right button of PopUpButton.
	 */
	[Style(name="popUpIcon", type="Class", inherit="no")] 
	/**
	 *  Skin class for the popUpOver state (over arrowButton) of 
	 */
	[Style(name="popUpOverSkin", type="Class", inherit="no")] 
	/**
	 *  Default stateful skin class for the control.
	 */
	[Style(name="skin", type="Class", inherit="no", states="up, over, down, disabled, popUpOver, popUpDown")] 

	/**
	 *  The PopUpButton control adds a flexible pop-up control
	 */
	public class PopUpButton extends Button
	{
		/**
		 *  @private
		 */
		private var inTween : Boolean;
		/**
		 *  @private
		 */
		private var showingPopUp : Boolean;
		/**
		 *  @private
		 */
		private var tween : Tween;
		/**
		 *  @private
		 */
		private var arrowButtonsWidth : Number;
		/**
		 *  @private
		 */
		private var arrowButtonsHeight : Number;
		/**
		 *  @private
		 */
		private var popUpIconChanged : Boolean;
		/**
		 *  @private
		 */
		private var popUpChanged : Boolean;
		/**
		 *  @private
		 */
		private var _closeOnActivity : Boolean;
		/**
		 *  @private
		 */
		private var _openAlways : Boolean;
		/**
		 *  @private
		 */
		private var _popUp : IUIComponent;

		/**
		 *  @private
		 */
		public function set showInAutomationHierarchy (value:Boolean) : void;
		/**
		 *  @private
		 */
		public function set toggle (value:Boolean) : void;
		/**
		 *  @private
		 */
		private function get closeOnActivity () : Boolean;
		/**
		 *  @private
		 */
		private function set closeOnActivity (value:Boolean) : void;
		/**
		 *  If <code>true</code>, specifies to pop up the 
		 */
		public function get openAlways () : Boolean;
		/**
		 *  @private
		 */
		public function set openAlways (value:Boolean) : void;
		/**
		 *  Specifies the UIComponent object, or object defined by a subclass 
		 */
		public function get popUp () : IUIComponent;
		/**
		 *  @private
		 */
		public function set popUp (value:IUIComponent) : void;
		/**
		 *  @private
		 */
		function get isShowingPopUp () : Boolean;

		/**
		 *  Constructor.
		 */
		public function PopUpButton ();
		/**
		 *  @private
		 */
		protected function commitProperties () : void;
		/**
		 *  @private
		 */
		protected function measure () : void;
		/**
		 *  @private
		 */
		public function styleChanged (styleProp:String) : void;
		/**
		 *  @private
		 */
		function layoutContents (unscaledWidth:Number, unscaledHeight:Number, offset:Boolean) : void;
		/**
		 *  @private
		 */
		function viewSkin () : void;
		/**
		 *  @private
		 */
		function getCurrentIconName () : String;
		/**
		 *  @private
		 */
		function viewIcon () : void;
		/**
		 *  @private
		 */
		function getPopUp () : IUIComponent;
		/**
		 *  Opens the UIComponent object specified by the <code>popUp</code> property.
		 */
		public function open () : void;
		/**
		 *  @private
		 */
		private function openWithEvent (trigger:Event = null) : void;
		/**
		 *  Closes the UIComponent object opened by the PopUpButton control.
		 */
		public function close () : void;
		/**
		 *  @private
		 */
		private function closeWithEvent (trigger:Event = null) : void;
		/**
		 *  @private
		 */
		private function displayPopUp (show:Boolean) : void;
		/**
		 *  @private
		 */
		private function calcArrowButtonSize () : void;
		/**
		 *  @private
		 */
		function overArrowButton (event:MouseEvent) : Boolean;
		/**
		 *  @private
		 */
		function onTweenUpdate (value:Number) : void;
		/**
		 *  @private
		 */
		function onTweenEnd (value:Number) : void;
		/**
		 *  @private
		 */
		protected function keyDownHandler (event:KeyboardEvent) : void;
		/**
		 *  @private
		 */
		protected function focusOutHandler (event:FocusEvent) : void;
		/**
		 *  @private
		 */
		protected function rollOverHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function rollOutHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseDownHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function mouseUpHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		protected function clickHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function mouseMoveHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		private function popUpItemClickHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function menuHideHandler (event:MenuEvent) : void;
		/**
		 *  @private
		 */
		private function popMouseDownOutsideHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function removedFromStageHandler (event:Event) : void;
		/**
		 *  @private
		 */
		function getUnscaledWidth () : Number;
		/**
		 *  @private
		 */
		function getUnscaledHeight () : Number;
		/**
		 *  @private
		 */
		function getArrowButtonsWidth () : Number;
	}
}