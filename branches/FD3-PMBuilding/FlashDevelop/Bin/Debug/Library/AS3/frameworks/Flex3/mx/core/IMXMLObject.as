﻿package mx.core
{
	/**
	 *  The IMXMLObject interface defines the APIs that a non-visual component
	 */
	public interface IMXMLObject
	{
		/**
		 *  Called after the implementing object has been created and all
		 */
		public function initialized (document:Object, id:String) : void;
	}
}