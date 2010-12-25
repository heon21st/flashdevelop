﻿package fl.transitions
{
	import flash.events.EventDispatcher;
	import flash.display.*;
	import flash.geom.Rectangle;
	import flash.events.Event;

	/**
	 * The TransitionManager class defines animation effects. It allows you to apply one of ten 
	 */
	public class TransitionManager extends EventDispatcher
	{
		/**
		 * @private
		 */
		private static var IDCount : int;
		/**
		 * @private
		 */
		public var type : Object;
		/**
		 * @private
		 */
		public var className : String;
		/**
		 * @private
		 */
		private var _content : MovieClip;
		/**
		 * @private
		 */
		private var _transitions : Object;
		/**
		 * @private
		 */
		public var _innerBounds : Rectangle;
		/**
		 * @private
		 */
		public var _outerBounds : Rectangle;
		/**
		 * @private
		 */
		public var _width : Number;
		/**
		 * @private
		 */
		public var _height : Number;
		/**
		 * @private
		 */
		private var _contentAppearance : Object;
		/**
		 * @private
		 */
		private var _visualPropList : Object;
		/**
		 * @private
		 */
		private var _triggerEvent : String;

		/**
		 * The movie clip instance to which TransitionManager is to apply a transition.
		 */
		public function set content (c:MovieClip) : void;
		public function get content () : MovieClip;
		/**
		 * @private this was changed from get transitions() to get transitionsList() because hitting compile error
		 */
		public function get transitionsList () : Object;
		/**
		 * @private
		 */
		public function get numTransitions () : Number;
		/**
		 * @private
		 */
		public function get numInTransitions () : Number;
		/**
		 * @private
		 */
		public function get numOutTransitions () : Number;
		/**
		 * An object that contains the saved visual properties of the content (target movie clip) 
		 */
		public function get contentAppearance () : Object;

		/**
		 * Creates a new TransitionManager instance, designates the target object, applies a transition, and starts the transition. Specifically, calling this method creates an instance of the TransitionManager class if one does not already exist, creates an instance of the specified transition class designated in the <code>transParams</code> parameter, and then starts the transition. The transition is applied to the movie clip that is designated in the <code>content</code> parameter.
		 */
		public static function start (content:MovieClip, transParams:Object) : Transition;
		/**
		 * Constructor function for creating a new TransitionManager instance. However, the <code>TransitionManager.start()</code> method is a more efficient way of creating and implementing a TransitionManager instance. If you do use the TransitionManager constructor function to create an instance, use the <code>new</code> operator then designate the transition properties and start the transition effect in a second step by calling the <code>TransitionManager.startTransition()</code> method.
		 */
		function TransitionManager (content:MovieClip);
		/**
		 * Creates a transition instance and starts it. If a matching transition already exists,
		 */
		public function startTransition (transParams:Object) : Transition;
		/**
		 * @private
		 */
		public function addTransition (trans:Transition) : Transition;
		/**
		 * @private
		 */
		public function removeTransition (trans:Transition) : Boolean;
		/**
		 * @private
		 */
		public function findTransition (transParams:Object) : Transition;
		/**
		 * @private
		 */
		public function removeAllTransitions () : void;
		/**
		 * @private
		 */
		public function saveContentAppearance () : void;
		/**
		 * @private
		 */
		public function restoreContentAppearance () : void;
		/**
		 * @private
		 */
		function transitionInDone (e:Object) : void;
		/**
		 * @private
		 */
		function transitionOutDone (e:Object) : void;
	}
}