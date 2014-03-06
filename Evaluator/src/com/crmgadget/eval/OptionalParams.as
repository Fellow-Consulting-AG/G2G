package com.crmgadget.eval
{
	import mx.collections.ArrayCollection;

	public class OptionalParams
	{
		public	var objEntity:Object=null;
		public	var doGetPickList:Function=null;
		public	var doGetPickListId:Function=null;
		public	var doGetXMLValueField:Function=null;
		public	var isFiltered:Boolean=false;
		public	var doGetJoinField:Function=null;
		public	var getFieldNameFromIntegrationTag:Function=null;
		public	var sqlLists:ArrayCollection=null;
		public var current_field:String = null;
		public var doGetOracleId:Function;
		public function OptionalParams()
		{
			
		}
	}
}