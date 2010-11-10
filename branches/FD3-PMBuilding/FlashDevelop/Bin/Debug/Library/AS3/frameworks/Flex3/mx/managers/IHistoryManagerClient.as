﻿package mx.managers
{
	/**
	 *  Interface that must be implemented by objects
	 */
	public interface IHistoryManagerClient
	{
		/**
		 *  Saves the state of this object. 
		 */
		public function saveState () : Object;
		/**
		 *  Loads the state of this object.
		 */
		public function loadState (state:Object) : void;
		/**
		 *  Converts this object to a unique string. 
		 */
		public function toString () : String;
	}
}