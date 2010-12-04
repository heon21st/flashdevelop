﻿package mx.graphics.codec
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 *  The JPEGEncoder class converts raw bitmap images into encoded
	 */
	public class JPEGEncoder implements IImageEncoder
	{
		/**
		 *  @private
		 */
		private static const CONTENT_TYPE : String = "image/jpeg";
		/**
		 *  @private
		 */
		private const std_dc_luminance_nrcodes : Array = [];
		/**
		 *  @private
		 */
		private const std_dc_luminance_values : Array = [];
		/**
		 *  @private
		 */
		private const std_dc_chrominance_nrcodes : Array = [];
		/**
		 *  @private
		 */
		private const std_dc_chrominance_values : Array = [];
		/**
		 *  @private
		 */
		private const std_ac_luminance_nrcodes : Array = [];
		/**
		 *  @private
		 */
		private const std_ac_luminance_values : Array = [];
		/**
		 *  @private
		 */
		private const std_ac_chrominance_nrcodes : Array = [];
		/**
		 *  @private
		 */
		private const std_ac_chrominance_values : Array = [];
		/**
		 *  @private
		 */
		private const ZigZag : Array = [];
		/**
		 *  @private
		 */
		private var YDC_HT : Array;
		/**
		 *  @private
		 */
		private var UVDC_HT : Array;
		/**
		 *  @private
		 */
		private var YAC_HT : Array;
		/**
		 *  @private
		 */
		private var UVAC_HT : Array;
		/**
		 *  @private
		 */
		private var category : Array;
		/**
		 *  @private
		 */
		private var bitcode : Array;
		/**
		 *  @private
		 */
		private var YTable : Array;
		/**
		 *  @private
		 */
		private var UVTable : Array;
		/**
		 *  @private
		 */
		private var fdtbl_Y : Array;
		/**
		 *  @private
		 */
		private var fdtbl_UV : Array;
		/**
		 *  @private
		 */
		private var byteout : ByteArray;
		/**
		 *  @private
		 */
		private var bytenew : int;
		/**
		 *  @private
		 */
		private var bytepos : int;
		/**
		 *  @private
		 */
		private var DU : Array;
		/**
		 *  @private
		 */
		private var YDU : Array;
		/**
		 *  @private
		 */
		private var UDU : Array;
		/**
		 *  @private
		 */
		private var VDU : Array;

		/**
		 *  The MIME type for the JPEG encoded image. 
		 */
		public function get contentType () : String;

		/**
		 *  Constructor.
		 */
		public function JPEGEncoder (quality:Number = 50.0);
		/**
		 *  Converts the pixels of BitmapData object
		 */
		public function encode (bitmapData:BitmapData) : ByteArray;
		/**
		 *  Converts a ByteArray object containing raw pixels
		 */
		public function encodeByteArray (byteArray:ByteArray, width:int, height:int, transparent:Boolean = true) : ByteArray;
		/**
		 *  @private
		 */
		private function initHuffmanTbl () : void;
		/**
		 *  @private
		 */
		private function computeHuffmanTbl (nrcodes:Array, std_table:Array) : Array;
		/**
		 *  @private
		 */
		private function initCategoryNumber () : void;
		/**
		 *  @private
		 */
		private function initQuantTables (sf:int) : void;
		/**
		 *  @private
		 */
		private function internalEncode (source:Object, width:int, height:int, transparent:Boolean = true) : ByteArray;
		/**
		 *  @private
		 */
		private function RGB2YUV (sourceBitmapData:BitmapData, sourceByteArray:ByteArray, xpos:int, ypos:int, width:int, height:int) : void;
		/**
		 *  @private
		 */
		private function processDU (CDU:Array, fdtbl:Array, DC:Number, HTDC:Array, HTAC:Array) : Number;
		/**
		 *  @private
		 */
		private function fDCTQuant (data:Array, fdtbl:Array) : Array;
		/**
		 *  @private
		 */
		private function writeBits (bs:BitString) : void;
		/**
		 *  @private
		 */
		private function writeByte (value:int) : void;
		/**
		 *  @private
		 */
		private function writeWord (value:int) : void;
		/**
		 *  @private
		 */
		private function writeAPP0 () : void;
		/**
		 *  @private
		 */
		private function writeDQT () : void;
		/**
		 *  @private
		 */
		private function writeSOF0 (width:int, height:int) : void;
		/**
		 *  @private
		 */
		private function writeDHT () : void;
		/**
		 *  @private
		 */
		private function writeSOS () : void;
	}
	internal class BitString
	{
		/**
		 *  @private
		 */
		public var len : int;
		/**
		 *  @private
		 */
		public var val : int;

		/**
		 *  Constructor.
		 */
		public function BitString ();
	}
}