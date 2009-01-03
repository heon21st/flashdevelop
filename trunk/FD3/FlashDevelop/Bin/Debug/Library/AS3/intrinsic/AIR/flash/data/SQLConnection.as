package flash.data
{
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	import flash.data.SQLSchemaResult;
	import flash.utils.ByteArray;

	/**
	 * Dispatched when data in any table in any of the connected databases changes as a result of a SQL UPDATE command.
	 * @eventType flash.events.SQLUpdateEvent.UPDATE
	 */
	[Event(name="update", type="flash.events.SQLUpdateEvent.UPDATE")] 

	/**
	 * Dispatched when a loadSchema() method call's operation completes successfully and the schema results are ready.
	 * @eventType flash.events.SQLEvent.SCHEMA
	 */
	[Event(name="schema", type="flash.events.SQLEvent.SCHEMA")] 

	/**
	 * Dispatched when a rollback() method call's operation completes successfully.
	 * @eventType flash.events.SQLEvent.ROLLBACK
	 */
	[Event(name="rollback", type="flash.events.SQLEvent.ROLLBACK")] 

	/**
	 * Dispatched when an openAsync() method call's operation completes successfully.
	 * @eventType flash.events.SQLEvent.OPEN
	 */
	[Event(name="open", type="flash.events.SQLEvent.OPEN")] 

	/**
	 * Dispatched when data in any table in any of the connected databases changes as a result of a SQL INSERT command.
	 * @eventType flash.events.SQLUpdateEvent.INSERT
	 */
	[Event(name="insert", type="flash.events.SQLUpdateEvent.INSERT")] 

	/**
	 * Dispatched when any of the SQLConnection object's asynchronous operations results in an error.
	 * @eventType flash.events.SQLErrorEvent.ERROR
	 */
	[Event(name="error", type="flash.events.SQLErrorEvent.ERROR")] 

	/**
	 * Dispatched when a detach() method call's operation completes successfully.
	 * @eventType flash.events.SQLEvent.DETACH
	 */
	[Event(name="detach", type="flash.events.SQLEvent.DETACH")] 

	/**
	 * Dispatched when data in any table in any of the connected databases changes as a result of a SQL DELETE command.
	 * @eventType flash.events.SQLUpdateEvent.DELETE
	 */
	[Event(name="delete", type="flash.events.SQLUpdateEvent.DELETE")] 

	/**
	 * Dispatched when a deanalyze() method call's operation completes successfully.
	 * @eventType flash.events.SQLEvent.DEANALYZE
	 */
	[Event(name="deanalyze", type="flash.events.SQLEvent.DEANALYZE")] 

	/**
	 * Dispatched when a commit() method call's operation completes successfully.
	 * @eventType flash.events.SQLEvent.COMMIT
	 */
	[Event(name="commit", type="flash.events.SQLEvent.COMMIT")] 

	/**
	 * Dispatched when a close() method call's operation completes successfully.
	 * @eventType flash.events.SQLEvent.CLOSE
	 */
	[Event(name="close", type="flash.events.SQLEvent.CLOSE")] 

	/**
	 * Dispatched when a compact() method call's operation completes successfully.
	 * @eventType flash.events.SQLEvent.COMPACT
	 */
	[Event(name="compact", type="flash.events.SQLEvent.COMPACT")] 

	/**
	 * Dispatched when a cancel() method call's operation completes successfully.
	 * @eventType flash.events.SQLEvent.CANCEL
	 */
	[Event(name="cancel", type="flash.events.SQLEvent.CANCEL")] 

	/**
	 * Dispatched when a begin() method call's operation completes successfully.
	 * @eventType flash.events.SQLEvent.BEGIN
	 */
	[Event(name="begin", type="flash.events.SQLEvent.BEGIN")] 

	/**
	 * Dispatched when an attach() method call's operation completes successfully.
	 * @eventType flash.events.SQLEvent.ATTACH
	 */
	[Event(name="attach", type="flash.events.SQLEvent.ATTACH")] 

	/**
	 * Dispatched when an analyze() operation completes successfully.
	 * @eventType flash.events.SQLEvent.ANALYZE
	 */
	[Event(name="analyze", type="flash.events.SQLEvent.ANALYZE")] 

	/// A SQLConnection instance is used to manage the creation of and connection to local SQL database files (local databases).
	public class SQLConnection extends EventDispatcher
	{
		/// [AIR] Indicates whether autocompacting was enabled when the current database was originally created (the value that was specified for the autoCompact parameter in the open() or openAsync() call that created the database).
		public function get autoCompact () : Boolean;

		/// [AIR] Provides access to the cache size for this connection, which represents the maximum number of database disk pages that are held in memory at one time.
		public function get cacheSize () : uint;
		public function set cacheSize (value:uint) : void;

		/// [AIR] Indicates how column names are reported in the result of a SELECT statement.
		public function get columnNameStyle () : String;
		public function set columnNameStyle (value:String) : void;

		/// [AIR] Indicates whether the SQLConnection instance has an open connection to a database file.
		public function get connected () : Boolean;

		/// [AIR] Indicates whether this connection is currently involved in a transaction.
		public function get inTransaction () : Boolean;

		/// [AIR] The last generated row identifier created by a SQL INSERT statement.
		public function get lastInsertRowID () : Number;

		/// [AIR] Indicates the database page size (in bytes) that was specified when the current database was originally created (the value that was specified for the pageSize parameter in the open() or openAsync() call that created the database).
		public function get pageSize () : uint;

		/// [AIR] Contains the total number of data changes that have been made since the connection to the database was opened.
		public function get totalChanges () : Number;

		/// [AIR] Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
		public function addEventListener (type:String, listener:Function, useCapture:Boolean, priority:int, useWeakReference:Boolean) : void;

		/// [AIR] Gathers statistics about database indices and stores them in the database.
		public function analyze (resourceName:String, responder:Responder) : void;

		/// [AIR] Adds another database to the SQLConnection instance, giving the new database the specified name.
		public function attach (name:String, reference:Object, responder:Responder, encryptionKey:ByteArray) : void;

		/// [AIR] Begins a transaction within which all SQL statements executed against the connection's database or databases are grouped.
		public function begin (option:String, responder:Responder) : void;

		/// [AIR] Aborts all SQL statements that are currently executing on databases connected to the SQLConnection instance.
		public function cancel (responder:Responder) : void;

		/// [AIR] Closes the current database connection.
		public function close (responder:Responder) : void;

		/// [AIR] Commits an existing transaction, causing any actions performed by the transaction's statements to be permanently applied to the database.
		public function commit (responder:Responder) : void;

		/// [AIR] Reclaims all unused space in the database.
		public function compact (responder:Responder) : void;

		/// [AIR] Removes all statistical information created by a call to the analyze() method.
		public function deanalyze (responder:Responder) : void;

		/// [AIR] Detaches an additional database previously attached to the SQLConnection instance using the attach() method.
		public function detach (name:String, responder:Responder) : void;

		/// [AIR] Provides access to the result of a call to the loadSchema() method.
		public function getSchemaResult () : SQLSchemaResult;

		/// [AIR] Loads schema information from the connected database or any attached databases.
		public function loadSchema (type:Class, name:String, database:String, includeColumnSchema:Boolean, responder:Responder) : void;

		/// [AIR] Opens a connection to the database file at the specified location in the file system, or creates and opens a new database file at the location, or creates and opens an in-memory database.
		public function open (reference:Object, openMode:String, autoCompact:Boolean, pageSize:int, encryptionKey:ByteArray) : void;

		/// [AIR] Opens a connection to the database file at the specified location in the file system, or creates and opens a new database file at the location, or creates and opens an in-memory database.
		public function openAsync (reference:Object, openMode:String, responder:Responder, autoCompact:Boolean, pageSize:int, encryptionKey:ByteArray) : void;

		public function reencrypt (newEncryptionKey:ByteArray, responder:Responder) : void;

		/// [AIR] Removes a listener from the EventDispatcher object.
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean) : void;

		/// [AIR] Rolls back an existing transaction created using the begin() method, meaning all changes made by any SQL statements in the transaction are discarded.
		public function rollback (responder:Responder) : void;
	}
}
