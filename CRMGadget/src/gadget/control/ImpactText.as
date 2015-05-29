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

	public class ImpactText extends TextInput
	{
		
		private var _columns:ArrayCollection;
		public var column:AdvancedDataGridColumn;
		private var grid:AdvancedDataGrid = null;
		private var _columnTarget:String;
		public function ImpactText()
		{
			addEventListener(Event.CHANGE,onChange);
			super();
		}

		public function get columnTarget():String
		{
			return _columnTarget;
		}

		public function set columnTarget(value:String):void
		{
			_columnTarget = value;
		}

		public function set focusOutHandler(f:Function):void{
			
			addEventListener(FocusEvent.FOCUS_OUT,function(e:FocusEvent):void{f()});
		}
		
		private function onChange(e:Event):void{
			
					
					if(column != null){
						var currentValEnter:int = parseInt(super.text,0);
						super.data[column.dataField] = currentValEnter;
					}
					var total:int = 0;
					if(columns != null){
						for each(var col:String in columns){
							var val:int = parseInt(super.data[col],0);
							total = total + val;
						}
					}
					if(columnTarget != null){
						super.data[columnTarget] = total;
					}
					
					if(grid != null){
						grid.invalidateList();
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