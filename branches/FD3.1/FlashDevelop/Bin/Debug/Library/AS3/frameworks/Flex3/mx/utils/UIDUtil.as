/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.utils {
	import flash.utils.ByteArray;
	public class UIDUtil {
		/**
		 * Generates a UID (unique identifier) based on ActionScript's
		 *  pseudo-random number generator and the current time.
		 *
		 * @return                  <String> The newly-generated UID.
		 */
		public static function createUID():String;
		/**
		 * Converts a 128-bit UID encoded as a ByteArray to a String representation.
		 *  The format matches that generated by createUID. If a suitable ByteArray
		 *  is not provided, null is returned.
		 *
		 * @param ba                <ByteArray> ByteArray 16 bytes in length representing a 128-bit UID.
		 * @return                  <String> String representation of the UID, or null if an invalid
		 *                            ByteArray is provided.
		 */
		public static function fromByteArray(ba:ByteArray):String;
		/**
		 * Returns the UID (unique identifier) for the specified object.
		 *  If the specified object doesn't have an UID
		 *  then the method assigns one to it.
		 *  If a map is specified this method will use the map
		 *  to construct the UID.
		 *  As a special case, if the item passed in is null,
		 *  this method returns a null UID.
		 *
		 * @param item              <Object> Object that we need to find the UID for.
		 * @return                  <String> The UID that was either found or generated.
		 */
		public static function getUID(item:Object):String;
		/**
		 * A utility method to check whether a String value represents a
		 *  correctly formatted UID value. UID values are expected to be
		 *  in the format generated by createUID(), implying that only
		 *  capitalized A-F characters in addition to 0-9 digits are
		 *  supported.
		 *
		 * @param uid               <String> The value to test whether it is formatted as a UID.
		 * @return                  <Boolean> Returns true if the value is formatted as a UID.
		 */
		public static function isUID(uid:String):Boolean;
		/**
		 * Converts a UID formatted String to a ByteArray. The UID must be in the
		 *  format generated by createUID, otherwise null is returned.
		 *
		 * @param uid               <String> representing a 128-bit UID
		 * @return                  <ByteArray> ByteArray 16 bytes in length representing the 128-bits of the
		 *                            UID or null if the uid could not be converted.
		 */
		public static function toByteArray(uid:String):ByteArray;
	}
}
