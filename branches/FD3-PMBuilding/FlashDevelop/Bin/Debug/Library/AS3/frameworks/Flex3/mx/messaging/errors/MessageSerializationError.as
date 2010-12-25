﻿package mx.messaging.errors
{
	import mx.messaging.messages.ErrorMessage;

	/**
	 *  This error indicates a problem serializing a message within a channel.
	 */
	public class MessageSerializationError extends MessagingError
	{
		/**
		 *  Provides specific information about the fault that occurred and for
		 */
		public var fault : ErrorMessage;

		/**
		 *  Constructs a new instance of the MessageSerializationError
		 */
		public function MessageSerializationError (msg:String, fault:ErrorMessage);
	}
}