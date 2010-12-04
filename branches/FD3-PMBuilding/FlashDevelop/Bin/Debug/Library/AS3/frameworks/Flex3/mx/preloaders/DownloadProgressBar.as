﻿package mx.preloaders
{
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;
	import mx.graphics.RectangularDropShadow;
	import mx.graphics.RoundedRectangle;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.system.Capabilities;
	import flash.text.TextFieldAutoSize;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import mx.preloaders.DownloadProgressBar;

	/**
	 *  The DownloadProgressBar class displays download progress.
	 */
	public class DownloadProgressBar extends Sprite implements IPreloaderDisplay
	{
		/**
		 *  The minimum number of milliseconds
		 */
		protected var MINIMUM_DISPLAY_TIME : uint;
		/**
		 *  The percentage of the progress bar that the downloading phase
		 */
		protected var DOWNLOAD_PERCENTAGE : uint;
		/**
		 *  @private
		 */
		private var _showProgressBar : Boolean;
		/**
		 *  @private
		 */
		private var _labelRect : Rectangle;
		/**
		 *  @private
		 */
		private var _percentRect : Rectangle;
		/**
		 *  @private
		 */
		private var _borderRect : RoundedRectangle;
		/**
		 *  @private
		 */
		private var _barFrameRect : RoundedRectangle;
		/**
		 *  @private
		 */
		private var _barRect : RoundedRectangle;
		/**
		 *  @private
		 */
		private var _xOffset : Number;
		/**
		 *  @private
		 */
		private var _yOffset : Number;
		/**
		 *  @private
		 */
		private var _maximum : Number;
		/**
		 *  @private
		 */
		private var _value : Number;
		/**
		 *  @private
		 */
		private var _barSprite : Sprite;
		/**
		 *  @private
		 */
		private var _barFrameSprite : Sprite;
		/**
		 *  @private
		 */
		private var _labelObj : TextField;
		/**
		 *  @private
		 */
		private var _percentObj : TextField;
		/**
		 *  @private
		 */
		private var _startTime : int;
		/**
		 *  @private
		 */
		private var _displayTime : int;
		/**
		 *  @private
		 */
		private var _startedLoading : Boolean;
		/**
		 *  @private
		 */
		private var _startedInit : Boolean;
		/**
		 *  @private
		 */
		private var _showingDisplay : Boolean;
		/**
		 *  @private
		 */
		private var _displayStartCount : uint;
		/**
		 *  @private
		 */
		private var _initProgressCount : uint;
		/**
		 *  @private
		 */
		private var _initProgressTotal : uint;
		/**
		 *  @private
		 */
		private var _visible : Boolean;
		/**
		 *  @private
		 */
		private var _backgroundAlpha : Number;
		/**
		 *  @private
		 */
		private var _backgroundColor : uint;
		/**
		 *  @private
		 */
		private var _backgroundImage : Object;
		/**
		 *  @private
		 */
		private var _backgroundSize : String;
		/**
		 *  @private
		 */
		private var _preloader : Sprite;
		/**
		 *  @private
		 */
		private var _stageHeight : Number;
		/**
		 *  @private
		 */
		private var _stageWidth : Number;
		/**
		 *  @private
		 */
		private var _downloadingLabel : String;
		/**
		 *  @private
		 */
		private static var _initializingLabel : String;
		/**
		 *  @private
		 */
		private var _label : String;
		/**
		 *  @private
		 */
		private var _showLabel : Boolean;
		/**
		 *  @private
		 */
		private var _showPercentage : Boolean;

		/**
		 *  Specifies whether the download progress bar is visible.
		 */
		public function get visible () : Boolean;
		/**
		 *  @private
		 */
		public function set visible (value:Boolean) : void;
		/**
		 *  Alpha level of the SWF file or image defined by 
		 */
		public function get backgroundAlpha () : Number;
		/**
		 *  @private
		 */
		public function set backgroundAlpha (value:Number) : void;
		/**
		 *  Background color of a download progress bar.
		 */
		public function get backgroundColor () : uint;
		/**
		 *  @private
		 */
		public function set backgroundColor (value:uint) : void;
		/**
		 *  The background image of the application,
		 */
		public function get backgroundImage () : Object;
		/**
		 *  @private
		 */
		public function set backgroundImage (value:Object) : void;
		/**
		 *  Scales the image specified by <code>backgroundImage</code>
		 */
		public function get backgroundSize () : String;
		/**
		 *  @private
		 */
		public function set backgroundSize (value:String) : void;
		/**
		 *  The Preloader class passes in a reference to itself to the display class
		 */
		public function set preloader (value:Sprite) : void;
		/**
		 *  The height of the stage,
		 */
		public function get stageHeight () : Number;
		/**
		 *  @private
		 */
		public function set stageHeight (value:Number) : void;
		/**
		 *  The width of the stage,
		 */
		public function get stageWidth () : Number;
		/**
		 *  @private
		 */
		public function set stageWidth (value:Number) : void;
		/**
		 *  The dimensions of the progress bar border.
		 */
		protected function get barFrameRect () : RoundedRectangle;
		/**
		 *  The dimensions of the progress bar.
		 */
		protected function get barRect () : RoundedRectangle;
		/**
		 *  The dimensions of the border of the display.
		 */
		protected function get borderRect () : RoundedRectangle;
		/**
		 *  The string to display as the label while in the downloading phase.
		 */
		protected function get downloadingLabel () : String;
		/**
		 *  @private
		 */
		protected function set downloadingLabel (value:String) : void;
		/**
		 *  The string to display as the label while in the initializing phase.
		 */
		public static function get initializingLabel () : String;
		/**
		 *  @private
		 */
		public static function set initializingLabel (value:String) : void;
		/**
		 *  Text to display when the progress bar is active.
		 */
		protected function get label () : String;
		/**
		 *  @private
		 */
		protected function set label (value:String) : void;
		/**
		 *  The TextFormat object of the TextField component of the label.
		 */
		protected function get labelFormat () : TextFormat;
		/**
		 *  The dimensions of the TextField component for the label. 
		 */
		protected function get labelRect () : Rectangle;
		/**
		 *  The TextFormat of the TextField component for displaying the percent.
		 */
		protected function get percentFormat () : TextFormat;
		/**
		 *  The dimensions of the TextField component for displaying the percent.
		 */
		protected function get percentRect () : Rectangle;
		/**
		 *  Controls whether to display the label, <code>true</code>, 
		 */
		protected function get showLabel () : Boolean;
		/**
		 *  @private
		 */
		protected function set showLabel (value:Boolean) : void;
		/**
		 *  Controls whether to display the percentage, <code>true</code>, 
		 */
		protected function get showPercentage () : Boolean;
		/**
		 *  @private
		 */
		protected function set showPercentage (value:Boolean) : void;

		/**
		 *  Constructor.
		 */
		public function DownloadProgressBar ();
		/**
		 *  Called by the Preloader after the download progress bar
		 */
		public function initialize () : void;
		/**
		 *  Centers the download progress bar based on the passed in dimensions.
		 */
		protected function center (width:Number, height:Number) : void;
		/**
		 *  @private
		 */
		private function draw () : void;
		/**
		 *  Creates the subcomponents of the display.
		 */
		protected function createChildren () : void;
		/**
		 *  @private
		 */
		private function drawProgressBar (percentage:Number) : void;
		/**
		 *  Updates the display of the download progress bar
		 */
		protected function setProgress (completed:Number, total:Number) : void;
		/**
		 *  Returns the percentage value of the application loaded. 
		 */
		protected function getPercentLoaded (loaded:Number, total:Number) : Number;
		/**
		 *  @private
		 */
		private function show () : void;
		/**
		 *  @private
		 */
		private function hide () : void;
		/**
		 *  @private
		 */
		private function calcX (base:Number) : Number;
		/**
		 *  @private
		 */
		private function calcY (base:Number) : Number;
		/**
		 *  @private
		 */
		private function calcScale () : void;
		/**
		 *  Defines the algorithm for determining whether to show
		 */
		protected function showDisplayForDownloading (elapsedTime:int, event:ProgressEvent) : Boolean;
		/**
		 *  Defines the algorithm for determining whether to show the download progress bar
		 */
		protected function showDisplayForInit (elapsedTime:int, count:int) : Boolean;
		/**
		 *  @private
		 */
		private function loadBackgroundImage (classOrString:Object) : void;
		/**
		 *  @private
		 */
		private function initBackgroundImage (image:DisplayObject) : void;
		/**
		 *  @private
		 */
		private function calcBackgroundSize () : Number;
		/**
		 *  Event listener for the <code>ProgressEvent.PROGRESS</code> event. 
		 */
		protected function progressHandler (event:ProgressEvent) : void;
		/**
		 *  Event listener for the <code>Event.COMPLETE</code> event. 
		 */
		protected function completeHandler (event:Event) : void;
		/**
		 *  Event listener for the <code>RSLEvent.RSL_PROGRESS</code> event. 
		 */
		protected function rslProgressHandler (event:RSLEvent) : void;
		/**
		 *  Event listener for the <code>RSLEvent.RSL_COMPLETE</code> event. 
		 */
		protected function rslCompleteHandler (event:RSLEvent) : void;
		/**
		 *  Event listener for the <code>RSLEvent.RSL_ERROR</code> event. 
		 */
		protected function rslErrorHandler (event:RSLEvent) : void;
		/**
		 *  @private
		 */
		private function timerHandler (event:Event = null) : void;
		/**
		 *  Event listener for the <code>FlexEvent.INIT_PROGRESS</code> event. 
		 */
		protected function initProgressHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function initCompleteHandler (event:Event) : void;
		/**
		 *  @private
		 */
		private function loader_completeHandler (event:Event) : void;
		private function loader_ioErrorHandler (event:IOErrorEvent) : void;
	}
	/**
	 * @private
	 */
	internal class ErrorField extends Sprite
	{
		private var downloadProgressBar : DownloadProgressBar;
		private const MIN_WIDTH_INCHES : int = 2;
		private const MAX_WIDTH_INCHES : int = 6;
		private const TEXT_MARGIN_PX : int = 10;

		/**
		 *  The TextFormat object of the TextField component of the label.
		 */
		protected function get labelFormat () : TextFormat;

		/**
		 * @private
		 */
		public function ErrorField (downloadProgressBar:DownloadProgressBar);
		/**
		 * Create and show the error message.
		 */
		public function show (errorText:String) : void;
	}
}