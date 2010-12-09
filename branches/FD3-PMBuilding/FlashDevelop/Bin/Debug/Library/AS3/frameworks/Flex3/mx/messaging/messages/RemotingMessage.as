﻿package mx.messaging.messages
{
	/**
	 *  RemotingMessages are used to send RPC requests to a remote endpoint.
	 */
	public class RemotingMessage extends AbstractMessage
	{
		/**
		 *  Provides access to the name of the remote method/operation that
		 */
		public var operation : String;
		/**
		 *  This property is provided for backwards compatibility. The best
		 */
		public var source : String;

		/**
		 *  Constructs an uninitialized RemotingMessage.
		 */
		public function RemotingMessage ();
	}
}