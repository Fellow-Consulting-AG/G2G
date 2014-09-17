package gadget.control
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	import spark.components.NumericStepper;
	
	public class StringStepper extends NumericStepper
	{
		public function StringStepper()
		{
			enabled = false;
			valueFormatFunction = defaultValueFormatFunction;
			valueParseFunction = defaultValueParseFunction;
		}
		
		private var _dataProvider:ArrayCollection;
		
		public function get dataProvider():ArrayCollection
		{
			return _dataProvider;
		}
		
		public function set dataProvider(value:ArrayCollection):void
		{
			if (_dataProvider == value)
				return;
			
			if (_dataProvider)
				_dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE,
					dataProvider_collectionChangeHandler);
			
			_dataProvider = value;
			commitDataProvider();
			
			if (_dataProvider)
				_dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE,
					dataProvider_collectionChangeHandler);
		}
		
		/**
		 * Same event as for <code>value</code>.
		 */
		[Bindable("valueCommit")]
		public function get selectedItem():Object
		{
			return _dataProvider && value <= _dataProvider.length - 1 ? _dataProvider[value] : null; 
		}
		
		public function set selectedItem(value:Object):void
		{
			if (!_dataProvider)
				return;
			
			value = _dataProvider.getItemIndex(value);
		}
		
		private function defaultValueFormatFunction(value:Number):String
		{
			return _dataProvider && value <= _dataProvider.length - 1 ? _dataProvider[value] : String(value);
		}
		
		private function defaultValueParseFunction(value:String):Number
		{
			if (!_dataProvider)
				return 0;
			
			var n:int = _dataProvider.length;
			for (var i:int = 0; i < n; i++)
			{
				var string:String = _dataProvider[i];
				if (string == value)
					return i;
			}
			return 0;
		}
		
		private function commitDataProvider():void
		{
			if (!_dataProvider)
			{
				minimum = 0;
				maximum = 0;
				enabled = false;
				return;
			}
			
			enabled = true;
			minimum = 0;
			maximum = _dataProvider.length - 1;
		}
		
		private function dataProvider_collectionChangeHandler(event:CollectionEvent):void
		{
			commitDataProvider();
		}
		
	}
}