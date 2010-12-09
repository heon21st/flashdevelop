﻿package mx.utils
{
	import flash.utils.ByteArray;

	/**
	 *  Documentation is not currently available.
	 */
	public class HexDecoder
	{
		/**
		 *  @private
		 */
		private var _output : ByteArray;
		/**
		 *  @private
		 */
		private var _work : Array;

		/**
		 *  @private
		 */
		public function HexDecoder ();
		/**
		 *  @private
		 */
		public function decode (encoded:String) : void;
		/**
		 * Returns the decimal representation of a hex digit.
		 */
		public function digit (char:String) : int;
		/**
		 *  @private
		 */
		public function drain () : ByteArray;
		/**
		 *  @private
		 */
		public function flush () : ByteArray;
	}
}