﻿package mx.messaging
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import mx.core.mx_internal;
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	import mx.events.CollectionEvent;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.messaging.events.MessageEvent;
	import mx.messaging.errors.MessagingError;
	import mx.messaging.messages.AsyncMessage;
	import mx.messaging.messages.CommandMessage;
	import mx.messaging.messages.IMessage;

	/**
	 *  Dispatched when a message is received by the Consumer.
	 */
	[Event(name="message", type="mx.messaging.events.MessageEvent")] 

	/**
	 *  Like a Consumer, a MultiTopicConsumer subscribes to a destination with a single
	 */
	public class MultiTopicConsumer extends AbstractConsumer
	{
		/**
		 *  @private
		 */
		private var _subscriptions : ArrayCollection;
		/**
		 * This is a map where the keys are string names of the form subtopic + separator + selector
		 */
		private var _currentSubscriptions : Object;
		/**
		 * Used when the subscriptions property changes so we batch all changes made in one
		 */
		private var _subchangeTimer : Timer;

		/**
		 *  Stores an Array of SubscriptionInfo objects.  Each subscription
		 */
		public function get subscriptions () : ArrayCollection;
		/**
		 * Provide a new subscriptions array collection.  This should be an ArrayCollection
		 */
		public function set subscriptions (value:ArrayCollection) : void;

		/**
		 *  Constructs a MultiTopicConsumer.
		 */
		public function MultiTopicConsumer ();
		/**
		 * This is a convenience method for adding a new subscription.  It just creates
		 */
		public function addSubscription (subtopic:String = null, selector:String = null) : void;
		/**
		 * This method removes the subscription specified by the subtopic
		 */
		public function removeSubscription (subtopic:String = null, selector:String = null) : void;
		/**
		 * Returns a subscribe message.
		 */
		protected function buildSubscribeMessage () : CommandMessage;
		/**
		 * Returns an unsubscribe mesage.
		 */
		protected function buildUnsubscribeMessage (preserveDurable:Boolean) : CommandMessage;
		/**
		 * @private
		 */
		protected function internalSend (message:IMessage, waitForClientId:Boolean = true) : void;
		/**
		 * @private
		 */
		protected function setSubscribed (value:Boolean) : void;
		private function getCurrentSubscriptions () : Object;
		private function subscriptionsChangeHandler (event:CollectionEvent) : void;
		private function doResubscribe (event:TimerEvent) : void;
	}
}