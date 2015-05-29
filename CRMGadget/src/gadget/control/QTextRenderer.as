package gadget.control
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import mx.collections.ArrayCollection;
	import mx.controls.AdvancedDataGrid;
	import mx.controls.TextInput;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.listClasses.BaseListData;

	public class QTextRenderer extends TextInput
	{
		private var _columns:ArrayCollection;
		public var column:AdvancedDataGridColumn;
		private var _dataField:String;
		private var grid:AdvancedDataGrid = null;
		public function QTextRenderer()
		{
			addEventListener(Event.CHANGE,onChange);
			super();
		}

		public function get dataField():String
		{
			return _dataField;
		}

		public function set dataField(value:String):void
		{
			_dataField = value;
		}
		public function set focusOutHandler(f:Function):void{
			
			addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void{f(columns,dataField)});
		}
		private function onChange(e:Event):void{
			if(column != null){
				var q1:int = parseInt(super.text,0);
				if(q1>0){
					var val:Number = q1/3;
					if(columns != null){
						for each(var col:String in columns){
							super.data[col] = val;
						}
					}
				}
				if(grid != null){
					grid.invalidateList();
				}
			}
		}
		public function get columns():ArrayCollection
		{
			return _columns;
		}

		public function set columns(value:ArrayCollection):void
		{
			_columns = value;
		}

		override public function set data(value:Object):void
		{
			
			super.data = value;
		}
		
		override public function set listData(value:BaseListData):void
		{
			// TODO Auto Generated method stub
			super.listData = value;
			if(value!=null){
				grid = value.owner as AdvancedDataGrid;
				var list:AdvancedDataGridListData = value as AdvancedDataGridListData;
				if(list!=null){					
					column = grid.columns[list.columnIndex];
					
				}
				
			}
		}
		
		
	}
}