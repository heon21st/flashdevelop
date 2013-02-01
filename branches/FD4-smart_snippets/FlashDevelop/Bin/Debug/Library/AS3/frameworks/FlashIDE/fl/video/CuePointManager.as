﻿package fl.video
{
	/**
	 * Dispatched when a cue point is reached.  Event Object has an
	 */
	[Event("cuePoint")] 

	/**
	 * The CuePointManager class manages ActionScript cue points and enabling/disabling FLV
	 */
	public class CuePointManager
	{
		private var _owner : FLVPlayback;
		local var _metadataLoaded : Boolean;
		local var _disabledCuePoints : Array;
		local var _disabledCuePointsByNameOnly : Object;
		local var _asCuePointIndex : int;
		local var _asCuePointTolerance : Number;
		local var _linearSearchTolerance : Number;
		local var _id : uint;
		static const DEFAULT_LINEAR_SEARCH_TOLERANCE : Number = 50;
		local var allCuePoints : Array;
		local var asCuePoints : Array;
		local var flvCuePoints : Array;
		local var navCuePoints : Array;
		local var eventCuePoints : Array;
		static var cuePointsReplace : Array;

		/**
		 * Has metadata been loaded.
		 */
		public function get metadataLoaded () : Boolean;
		/**
		 * Set by FLVPlayback to update _asCuePointTolerance.
		 */
		public function set playheadUpdateInterval (aTime:Number) : void;
		/**
		 * Corresponds to _vp and _cpMgr array index in FLVPlayback.
		 */
		public function get id () : uint;

		/**
		 * Constructor
		 */
		public function CuePointManager (owner:FLVPlayback, id:uint);
		/**
		 * Reset cue point lists.
		 */
		public function reset () : void;
		/**
		 * Add an ActionScript cue point.
		 */
		public function addASCuePoint (timeOrCuePoint:*, name:String = null, parameters:Object = null) : Object;
		/**
		 * Remove an ActionScript cue point from the currently
		 */
		public function removeASCuePoint (timeNameOrCuePoint:*) : Object;
		/**
		 * <p>Enable or disable one or more FLV cue point.  Disabled cue
		 */
		public function setFLVCuePointEnabled (enabled:Boolean, timeNameOrCuePoint:*) : int;
		/**
		 * removes enabled cue points from _disabledCuePoints
		 */
		public function removeCuePoints (cuePointArray:Array, cuePoint:Object) : Number;
		/**
		 * Inserts cue points into array.
		 */
		public function insertCuePoint (insertIndex:int, cuePointArray:Array, cuePoint:Object) : Array;
		/**
		 * Returns false if FLV embedded cue point is disabled by
		 */
		public function isFLVCuePointEnabled (timeNameOrCuePoint:*) : Boolean;
		/**
		 * Called by FLVPlayback on "playheadUpdate" event
		 */
		public function dispatchASCuePoints () : void;
		/**
		 * When our place in the stream is changed, this is called
		 */
		public function resetASCuePointIndex (time:Number) : void;
		/**
		 * Called by FLVPlayback "metadataReceived" event handler to process flv
		 */
		public function processFLVCuePoints (metadataCuePoints:Array) : void;
		/**
		 * <p>Process Array passed into FLVPlayback cuePoints property.
		 */
		public function processCuePointsProperty (cuePoints:Array) : void;
		/**
		 * Used by processCuePointsProperty
		 */
		function addOrDisable (disable:Boolean, cuePoint:Object) : void;
		/**
		 * Used by processCuePointsProperty
		 */
		function unescape (origStr:String) : String;
		/**
		 * Search for a cue point in an array sorted by time.  See
		 */
		function getCuePointIndex (cuePointArray:Array, closeIsOK:Boolean, time:Number = NaN, name:String = null, start:int = -1, len:int = -1) : int;
		/**
		 * Given a name, array and index, returns the next cue point in
		 */
		function getNextCuePointIndexWithName (name:String, array:Array, index:int) : int;
		/**
		 * Takes two cue point Objects and returns -1 if first sorts
		 */
		static function cuePointCompare (time:Number, name:String, cuePoint:Object) : int;
		/**
		 * <p>Search for a cue point in the given array at the given time
		 */
		function getCuePoint (cuePointArray:Array, closeIsOK:Boolean, timeNameOrCuePoint:*) : Object;
		/**
		 * <p>Given a cue point object returned from getCuePoint (needs
		 */
		function getNextCuePointWithName (cuePoint:Object) : Object;
		/**
		 * Used to make copies of cue point objects.
		 */
		static function deepCopyObject (obj:Object, recurseLevel:uint = 0) : Object;
	}
}