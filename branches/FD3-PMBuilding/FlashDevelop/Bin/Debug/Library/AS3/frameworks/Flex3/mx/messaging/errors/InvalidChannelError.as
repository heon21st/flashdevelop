﻿package mx.messaging.errors
{
	/**
	 *  This error is thrown when a Channel can't be accessed
	 */
	public class InvalidChannelError extends ChannelError
	{
		/**
		 *  Constructs a new instance of an InvalidChannelError with the specified message.
		 */
		public function InvalidChannelError (msg:String);
	}
}