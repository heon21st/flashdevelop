﻿package mx.rpc.xml
{
	/**
	 * This internal utility class is used by XMLDecoder. The class is basically
	 */
	internal dynamic class SimpleContent
	{
		public var value : *;

		public function SimpleContent (val:*);
		public function toString () : String;
		public function valueOf () : Object;
	}
}