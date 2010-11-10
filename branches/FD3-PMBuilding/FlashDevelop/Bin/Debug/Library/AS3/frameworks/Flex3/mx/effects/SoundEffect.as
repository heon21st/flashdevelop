﻿package mx.effects
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import mx.effects.effectClasses.SoundEffectInstance;
	import mx.managers.ISystemManager;
	import mx.managers.SystemManager;
	import mx.resources.IResourceManager;
	import mx.resources.ResourceManager;

	/**
	 *  Dispatched when the sound file finishes loading.
	 */
	[Event(name="complete", type="flash.events.Event")] 
	/**
	 *  Dispatched when ID3 data is available for an MP3 sound file.
	 */
	[Event(name="id3", type="flash.events.Event")] 
	/**
	 *  Dispatched when an error occurs during the loading of the sound file.
	 */
	[Event(name="ioError", type="flash.events.IOErrorEvent")] 
	/**
	 *  Dispatched periodically as the sound file loads.
	 */
	[Event(name="progress", type="flash.events.ProgressEvent")] 

	/**
	 *  The SoundEffect class plays an MP3 audio file. 
	 */
	public class SoundEffect extends Effect
	{
		/**
		 *  @private
		 */
		private var needsLoading : Boolean;
		/**
		 *  @private
		 */
		private var resourceManager : IResourceManager;
		/**
		 *  @private
		 */
		private var _autoLoad : Boolean;
		/**
		 *  The SoundEffect class uses an internal Sound object to control
		 */
		public var bufferTime : Number;
		/**
		 *  The number of times to play the sound in a loop, where a value of
		 */
		public var loops : int;
		/**
		 *  The easing function for the pan effect.
		 */
		public var panEasingFunction : Function;
		/**
		 *  Initial pan of the Sound object.
		 */
		public var panFrom : Number;
		/**
		 *  Final pan of the Sound object.
		 */
		public var panTo : Number;
		/**
		 *  @private
		 */
		private var _sound : Sound;
		/**
		 *  @private
		 */
		private var _source : Object;
		/**
		 *  The initial position in the MP3 file, in milliseconds, 
		 */
		public var startTime : Number;
		/**
		 *  If <code>true</code>, stop the effect
		 */
		public var useDuration : Boolean;
		/**
		 *  The easing function for the volume effect.
		 */
		public var volumeEasingFunction : Function;
		/**
		 *  Initial volume of the Sound object.
		 */
		public var volumeFrom : Number;
		/**
		 *  Final volume of the Sound object.
		 */
		public var volumeTo : Number;

		/**
		 *  If <code>true</code>, load the MP3 file 
		 */
		public function get autoLoad () : Boolean;
		/**
		 *  @private
		 */
		public function set autoLoad (value:Boolean) : void;
		/**
		 *  This property is <code>true</code> if the MP3 has been loaded.
		 */
		public function get isLoading () : Boolean;
		/**
		 *  The Sound object that the MP3 file has been loaded into.
		 */
		public function get sound () : Sound;
		/**
		 *  The URL or class of the MP3 file to play.
		 */
		public function get source () : Object;
		/**
		 *  @private
		 */
		public function set source (value:Object) : void;

		/**
		 *  Constructor.
		 */
		public function SoundEffect (target:Object = null);
		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;
		/**
		 *  Loads the MP3 if the <code>source</code> property points to a URL.
		 */
		public function load () : void;
		/**
		 *  @private
		 */
		private function attachSoundListeners () : void;
		/**
		 *  @private
		 */
		private function removeSoundListeners () : void;
		/**
		 *  Just act as a proxy for all events from the sound.
		 */
		private function soundEventHandler (event:Event) : void;
	}
}