﻿package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.Stage;
	import flash.utils.Proxy;
	import mx.automation.IAutomationObject;
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.core.ApplicationGlobals;
	import mx.core.FlexSprite;
	import mx.core.IChildList;
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModule;
	import mx.core.IInvalidating;
	import mx.core.ISWFLoader;
	import mx.core.IUIComponent;
	import mx.core.UIComponentGlobals;
	import mx.core.mx_internal;
	import mx.effects.Blur;
	import mx.effects.IEffect;
	import mx.effects.Fade;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.events.FlexMouseEvent;
	import mx.events.MoveEvent;
	import mx.events.SWFBridgeRequest;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.managers.SystemManagerProxy;
	import mx.styles.IStyleClient;
	import mx.utils.NameUtil;
	import mx.events.InterManagerRequest;
	import mx.core.UIComponent;
	import mx.events.SandboxMouseEvent;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.display.Stage;
	import flash.geom.Point;
	import mx.core.IUIComponent;
	import mx.core.mx_internal;
	import mx.effects.Effect;
	import mx.events.SandboxMouseEvent;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManagerImpl;

	/**
	 *  @private
	 */
	public class PopUpManagerImpl implements IPopUpManager
	{
		/**
		 *  @private
		 */
		private static var instance : IPopUpManager;
		/**
		 *  @private
		 */
		local var modalWindowClass : Class;
		/**
		 *  @private
		 */
		private var popupInfo : Array;

		/**
		 *  @private
		 */
		public static function getInstance () : IPopUpManager;
		/**
		 *  @private
		 */
		public function PopUpManagerImpl ();
		/**
		 *  Creates a top-level window and places it above other windows in the
		 */
		public function createPopUp (parent:DisplayObject, className:Class, modal:Boolean = false, childList:String = null) : IFlexDisplayObject;
		/**
		 *  Pops up a top-level window.
		 */
		public function addPopUp (window:IFlexDisplayObject, parent:DisplayObject, modal:Boolean = false, childList:String = null) : void;
		private function getTopLevelSystemManager (parent:DisplayObject) : ISystemManager;
		/**
		 *  Centers a popup window over whatever window was used in the call 
		 */
		public function centerPopUp (popUp:IFlexDisplayObject) : void;
		/**
		 *  Removes a popup window popped up by 
		 */
		public function removePopUp (popUp:IFlexDisplayObject) : void;
		/**
		 *  Makes sure a popup window is higher than other objects in its child list
		 */
		public function bringToFront (popUp:IFlexDisplayObject) : void;
		/**
		 *  @private
		 */
		private function createModalWindow (parentReference:DisplayObject, o:PopUpData, childrenList:IChildList, visibleFlag:Boolean, sm:ISystemManager, sbRoot:DisplayObject) : void;
		private function dispatchModalWindowRequest (type:String, sm:ISystemManager, sbRoot:DisplayObject, o:PopUpData, visibleFlag:Boolean) : void;
		/**
		 *  @private
		 */
		static function updateModalMask (sm:ISystemManager, modalWindow:DisplayObject, exclude:IUIComponent, excludeRect:Rectangle, mask:Sprite) : void;
		/**
		 *  @private
		 */
		private function endEffects (o:PopUpData) : void;
		private function showModalWindow (o:PopUpData, sm:ISystemManager, sendRequest:Boolean = true) : void;
		/**
		 *  @private
		 */
		private function showModalWindowInternal (o:PopUpData, transparencyDuration:Number, transparency:Number, transparencyColor:Number, transparencyBlur:Number, sm:ISystemManager, sbRoot:DisplayObject) : void;
		/**
		 *  @private
		 */
		private function hideModalWindow (o:PopUpData, destroy:Boolean = false) : void;
		/**
		 *  @private
		 */
		private function findPopupInfoByOwner (owner:Object) : PopUpData;
		/**
		 *  @private
		 */
		private function findHighestRemoteModalPopupInfo () : PopUpData;
		/**
		 *  @private
		 */
		private function addMouseOutEventListeners (o:PopUpData) : void;
		/**
		 *  @private
		 */
		private function removeMouseOutEventListeners (o:PopUpData) : void;
		/**
		 *  @private
		 */
		private function popupShowHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function popupHideHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function showOwnerHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function hideOwnerHandler (event:FlexEvent) : void;
		/**
		 *  @private
		 */
		private function createModalWindowRequestHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function showModalWindowRequest (event:Event) : void;
		/**
		 *  @private
		 */
		private function hideModalWindowRequest (event:Event) : void;
		/**
		 *  @private
		 */
		private function popupRemovedHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function fadeInEffectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private
		 */
		private function fadeOutDestroyEffectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private
		 */
		private function fadeOutCloseEffectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private
		 */
		private function effectEndHandler (event:EffectEvent) : void;
		/**
		 *  @private
		 */
		private static function nonmodalMouseDownOutsideHandler (owner:DisplayObject, evt:MouseEvent) : void;
		/**
		 *  @private
		 */
		private static function nonmodalMouseWheelOutsideHandler (owner:DisplayObject, evt:MouseEvent) : void;
		/**
		 *  @private
		 */
		private static function dispatchMouseWheelOutsideEvent (owner:DisplayObject, evt:MouseEvent) : void;
		/**
		 *  @private
		 */
		private static function dispatchMouseDownOutsideEvent (owner:DisplayObject, evt:MouseEvent) : void;
	}
	/**
	 *  @private
	 */
	internal class PopUpData
	{
		/**
		 *  @private
		 */
		public var owner : DisplayObject;
		/**
		 *  @private
		 */
		public var parent : DisplayObject;
		/**
		 *  @private
		 */
		public var topMost : Boolean;
		/**
		 *  @private
		 */
		public var modalWindow : DisplayObject;
		/**
		 *  @private
		 */
		public var _mouseDownOutsideHandler : Function;
		/**
		 *  @private
		 */
		public var _mouseWheelOutsideHandler : Function;
		/**
		 *  @private
		 */
		public var fade : Effect;
		/**
		 *  @private
		 */
		public var blur : Effect;
		/**
		 *  @private
		 */
		public var blurTarget : Object;
		/**
		 *   @private
		 */
		public var systemManager : ISystemManager;
		/**
		 *   @private
		 */
		public var isRemoteModalWindow : Boolean;
		/**
		 *   @private
		 */
		public var modalTransparencyDuration : Number;
		/**
		 *   @private
		 */
		public var modalTransparency : Number;
		/**
		 *   @private
		 */
		public var modalTransparencyBlur : Number;
		/**
		 *   @private
		 */
		public var modalTransparencyColor : Number;
		/**
		 *   @private
		 */
		public var exclude : IUIComponent;
		/**
		 *   @private
		 */
		public var useExclude : Boolean;
		/**
		 *   @private
		 */
		public var excludeRect : Rectangle;
		/**
		 *   @private
		 */
		public var modalMask : Sprite;

		/**
		 *  Constructor.
		 */
		public function PopUpData ();
		/**
		 *  @private
		 */
		public function mouseDownOutsideHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		public function mouseWheelOutsideHandler (event:MouseEvent) : void;
		/**
		 *  @private
		 */
		public function marshalMouseOutsideHandler (event:Event) : void;
		/**
		 *  @private
		 */
		public function resizeHandler (event:Event) : void;
	}
}